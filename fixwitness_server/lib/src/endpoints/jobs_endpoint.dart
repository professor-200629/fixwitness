import 'package:serverpod/serverpod.dart';

import '../fixwitness/access.dart';
import '../fixwitness/errors.dart';
import '../fixwitness/history.dart';
import '../fixwitness/job_views.dart';
import '../fixwitness/validation.dart';
import '../fixwitness/workflow.dart';
import '../generated/protocol.dart';

/// Shop-side job workflow. Every mutation locks the job row, validates the
/// transition, writes the change and its history event in one transaction.
///
/// Methods that a technician may queue offline (create, note, condition)
/// take an operation id and are idempotent: a retry returns the first result.
class JobsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<JobSummary>> list(Session session) async {
    final ctx = await requireMember(session);
    final jobs = await RepairJob.db.find(
      session,
      where: (t) => t.shopId.equals(ctx.shop.id!),
      orderBy: (t) => t.updatedAt.desc(),
      limit: 200,
    );
    if (jobs.isEmpty) return [];
    final pendingIds = {
      for (final e in await Estimate.db.find(
        session,
        where: (t) =>
            t.jobId.inSet(jobs.map((j) => j.id!).toSet()) &
            t.status.equals(EstimateStatus.issued),
      ))
        e.jobId,
    };
    return [
      for (final j in jobs)
        summaryOf(j, awaitingCustomer: pendingIds.contains(j.id)),
    ];
  }

  Future<JobDetail> get(Session session, int jobId) async {
    final ctx = await requireMember(session);
    final job = await loadShopJob(session, jobId, ctx.shop.id!);
    return buildJobDetail(session, job, ctx.shop);
  }

  /// Creates a job. [opId] is generated on the device when the technician
  /// starts the intake, so a retried or replayed request returns the same job.
  Future<RepairJob> create(
    Session session,
    UuidValue opId,
    NewJobInput input,
  ) async {
    final ctx = await requireMember(session);
    final replay = await _jobForOp(session, opId, ctx);
    if (replay != null) return replay;

    final fields = (
      customerName: requireText(input.customerName, 'Customer name', max: 80),
      customerPhone: requirePhone(input.customerPhone),
      deviceMake: requireText(input.deviceMake, 'Device make', max: 60),
      deviceModel: requireText(input.deviceModel, 'Device model', max: 60),
      deviceSerial: optionalText(input.deviceSerial, 'IMEI / serial', max: 40),
      reportedFault: requireText(
        input.reportedFault,
        'Reported fault',
        max: 1000,
      ),
      accessories: optionalText(input.accessories, 'Accessories', max: 200),
    );

    try {
      return await session.db.transaction((tx) async {
        // Lock the shop row to hand out the next job number without gaps or
        // duplicates when two devices create jobs at the same moment.
        final shop = (await Shop.db.findById(
          session,
          ctx.shop.id!,
          transaction: tx,
          lockMode: LockMode.forUpdate,
        ))!;
        await Shop.db.updateRow(
          session,
          shop.copyWith(nextJobNumber: shop.nextJobNumber + 1),
          transaction: tx,
        );
        var job = await RepairJob.db.insertRow(
          session,
          RepairJob(
            shopId: shop.id!,
            jobNumber: shop.nextJobNumber,
            clientOpId: opId,
            customerName: fields.customerName,
            customerPhone: fields.customerPhone,
            deviceMake: fields.deviceMake,
            deviceModel: fields.deviceModel,
            deviceSerial: fields.deviceSerial,
            reportedFault: fields.reportedFault,
            accessories: fields.accessories,
            status: JobStatus.checkedIn,
            createdByUserId: ctx.member.authUserId,
          ),
          transaction: tx,
        );
        job = await appendEvent(
          session,
          tx,
          job,
          type: JobEventType.jobCreated,
          actorKind: ActorKind.shop,
          actorLabel: ctx.member.displayName,
          summary:
              'Device checked in: ${deviceLabel(job)}. '
              'Reported fault: ${job.reportedFault}',
        );
        return RepairJob.db.updateRow(session, job, transaction: tx);
      });
    } catch (e) {
      if (!isUniqueViolation(e)) rethrow;
      final raced = await _jobForOp(session, opId, ctx);
      if (raced == null) rethrow;
      return raced;
    }
  }

  Future<RepairJob?> _jobForOp(
    Session session,
    UuidValue opId,
    ShopContext ctx,
  ) async {
    final existing = await RepairJob.db.findFirstRow(
      session,
      where: (t) => t.clientOpId.equals(opId),
    );
    if (existing == null) return null;
    if (existing.shopId != ctx.shop.id) {
      throw forbidden('This operation id belongs to another shop.');
    }
    return existing;
  }

  Future<JobNote> addNote(
    Session session,
    int jobId,
    UuidValue opId,
    String text,
    bool customerVisible,
    DateTime writtenAt,
  ) async {
    final ctx = await requireMember(session);
    Future<JobNote?> replay() async {
      final n = await JobNote.db.findFirstRow(
        session,
        where: (t) => t.clientOpId.equals(opId),
      );
      if (n != null && n.jobId != jobId) {
        throw forbidden('This operation id belongs to another job.');
      }
      return n;
    }

    final existing = await replay();
    if (existing != null) {
      await loadShopJob(session, existing.jobId, ctx.shop.id!);
      return existing;
    }
    final body = requireText(text, 'Note', max: 2000);
    try {
      return await session.db.transaction((tx) async {
        var job = await loadShopJob(
          session,
          jobId,
          ctx.shop.id!,
          transaction: tx,
          lock: true,
        );
        final note = await JobNote.db.insertRow(
          session,
          JobNote(
            jobId: jobId,
            clientOpId: opId,
            text: body,
            customerVisible: customerVisible,
            authorUserId: ctx.member.authUserId,
            authorName: ctx.member.displayName,
            writtenAt: writtenAt.toUtc(),
            receivedAt: DateTime.now().toUtc(),
          ),
          transaction: tx,
        );
        job = await appendEvent(
          session,
          tx,
          job,
          type: JobEventType.noteAdded,
          actorKind: ActorKind.shop,
          actorLabel: ctx.member.displayName,
          summary: customerVisible ? 'Update: $body' : 'Internal note added.',
          customerVisible: customerVisible,
        );
        await saveJob(session, tx, job);
        return note;
      });
    } catch (e) {
      if (!isUniqueViolation(e)) rethrow;
      final raced = await replay();
      if (raced == null) rethrow;
      return raced;
    }
  }

  Future<ConditionReport> saveCondition(
    Session session,
    int jobId,
    UuidValue opId,
    List<ConditionItem> items,
    DateTime capturedAt,
  ) async {
    final ctx = await requireMember(session);
    Future<ConditionReport?> replay() async {
      final r = await ConditionReport.db.findFirstRow(
        session,
        where: (t) => t.clientOpId.equals(opId),
      );
      if (r != null && r.jobId != jobId) {
        throw forbidden('This operation id belongs to another job.');
      }
      return r;
    }

    final existing = await replay();
    if (existing != null) {
      await loadShopJob(session, existing.jobId, ctx.shop.id!);
      return existing;
    }
    if (items.isEmpty || items.length > 30) {
      throw invalid('A condition checklist needs 1 to 30 items.');
    }
    final clean = [
      for (final i in items)
        ConditionItem(
          key: requireText(i.key, 'Checklist key', max: 40),
          label: requireText(i.label, 'Checklist label', max: 80),
          state: i.state,
          note: optionalText(i.note, 'Note for ${i.label}', max: 300),
        ),
    ];
    try {
      return await session.db.transaction((tx) async {
        var job = await loadShopJob(
          session,
          jobId,
          ctx.shop.id!,
          transaction: tx,
          lock: true,
        );
        final report = await ConditionReport.db.insertRow(
          session,
          ConditionReport(
            jobId: jobId,
            clientOpId: opId,
            items: clean,
            recordedByUserId: ctx.member.authUserId,
            recordedByName: ctx.member.displayName,
            capturedAt: capturedAt.toUtc(),
            receivedAt: DateTime.now().toUtc(),
          ),
          transaction: tx,
        );
        final flagged = clean
            .where(
              (i) =>
                  i.state == ConditionState.damaged ||
                  i.state == ConditionState.notWorking,
            )
            .map((i) => i.label)
            .toList();
        job = await appendEvent(
          session,
          tx,
          job,
          type: JobEventType.conditionRecorded,
          actorKind: ActorKind.shop,
          actorLabel: ctx.member.displayName,
          summary: flagged.isEmpty
              ? 'Condition recorded: no damage noted on ${clean.length} checks.'
              : 'Condition recorded: ${flagged.join(', ')} noted as damaged '
                    'or not working.',
        );
        await saveJob(session, tx, job);
        return report;
      });
    } catch (e) {
      if (!isUniqueViolation(e)) rethrow;
      final raced = await replay();
      if (raced == null) rethrow;
      return raced;
    }
  }

  /// Issues a new estimate version. [basedOnVersion] is the latest version the
  /// technician was looking at (null for the first); if someone else issued a
  /// version meanwhile the call is rejected instead of silently stacking.
  Future<Estimate> issueEstimate(
    Session session,
    int jobId,
    int? basedOnVersion,
    List<EstimateLine> lines,
    String? note,
    String? reasonForRevision,
  ) async {
    final ctx = await requireMember(session);
    final normalised = normaliseLines(lines);
    final cleanNote = optionalText(note, 'Estimate note', max: 500);
    final reason = optionalText(
      reasonForRevision,
      'Reason for revision',
      max: 300,
    );
    final currency = ctx.shop.currency;

    return session.db.transaction((tx) async {
      var job = await loadShopJob(
        session,
        jobId,
        ctx.shop.id!,
        transaction: tx,
        lock: true,
      );
      requireTransition(
        job.status,
        JobStatus.awaitingApproval,
        'issue an estimate',
      );
      final previous = job.currentEstimateId == null
          ? null
          : await Estimate.db.findById(
              session,
              job.currentEstimateId!,
              transaction: tx,
            );
      if (previous?.versionNumber != basedOnVersion) {
        throw FwException(
          code: FwErrorCode.estimateOutdated,
          message:
              'Estimate v${previous?.versionNumber} was issued after you '
              'opened this job. Reload and review it before issuing another version.',
          attemptedVersion: basedOnVersion,
          currentVersion: previous?.versionNumber,
        );
      }
      if (previous != null && reason == null) {
        throw invalid(
          'Explain what changed for the customer (reason for revision) when '
          'issuing a new version.',
        );
      }
      final version = (previous?.versionNumber ?? 0) + 1;
      if (previous != null && previous.status == EstimateStatus.issued) {
        await Estimate.db.updateRow(
          session,
          previous.copyWith(status: EstimateStatus.superseded),
          transaction: tx,
        );
        job = await appendEvent(
          session,
          tx,
          job,
          type: JobEventType.estimateSuperseded,
          actorKind: ActorKind.system,
          actorLabel: 'FixWitness',
          summary:
              'Estimate v${previous.versionNumber} was replaced by '
              'v$version before the customer decided.',
          estimateVersion: previous.versionNumber,
        );
      }
      final estimate = await Estimate.db.insertRow(
        session,
        Estimate(
          jobId: jobId,
          versionNumber: version,
          status: EstimateStatus.issued,
          lines: normalised.lines,
          totalMinor: normalised.totalMinor,
          currency: currency,
          note: cleanNote,
          reasonForRevision: reason,
          contentHash: estimateContentHash(
            jobId: jobId,
            versionNumber: version,
            lines: normalised.lines,
            totalMinor: normalised.totalMinor,
            currency: currency,
            note: cleanNote,
          ),
          issuedAt: DateTime.now().toUtc(),
          issuedByUserId: ctx.member.authUserId,
          issuedByName: ctx.member.displayName,
        ),
        transaction: tx,
      );
      job = await appendEvent(
        session,
        tx,
        job,
        type: JobEventType.estimateIssued,
        actorKind: ActorKind.shop,
        actorLabel: ctx.member.displayName,
        summary:
            'Estimate v$version issued: '
            '${formatMoney(estimate.totalMinor, currency)}'
            '${reason == null ? '' : '. Reason: $reason'}',
        estimateVersion: version,
      );
      await saveJob(
        session,
        tx,
        job.copyWith(
          status: JobStatus.awaitingApproval,
          currentEstimateId: estimate.id,
        ),
      );
      return estimate;
    });
  }

  Future<RepairJob> startWork(Session session, int jobId) =>
      _authorizedTransition(
        session,
        jobId,
        to: JobStatus.inProgress,
        action: 'start work',
        type: JobEventType.workStarted,
        summary: (v) => 'Repair work started under estimate v$v.',
      );

  Future<RepairJob> completeRepair(Session session, int jobId) =>
      _authorizedTransition(
        session,
        jobId,
        to: JobStatus.completed,
        action: 'mark the repair complete',
        type: JobEventType.repairCompleted,
        summary: (v) =>
            'Repair completed under estimate v$v. Ready for collection.',
      );

  Future<RepairJob> _authorizedTransition(
    Session session,
    int jobId, {
    required JobStatus to,
    required String action,
    required JobEventType type,
    required String Function(int version) summary,
  }) async {
    final ctx = await requireMember(session);
    return session.db.transaction((tx) async {
      var job = await loadShopJob(
        session,
        jobId,
        ctx.shop.id!,
        transaction: tx,
        lock: true,
      );
      requireTransition(job.status, to, action);
      final current = job.currentEstimateId == null
          ? null
          : await Estimate.db.findById(
              session,
              job.currentEstimateId!,
              transaction: tx,
            );
      requireAuthorizedWork(job, current, action);
      final authorized = (await Estimate.db.findById(
        session,
        job.authorizedEstimateId!,
        transaction: tx,
      ))!;
      job = await appendEvent(
        session,
        tx,
        job,
        type: type,
        actorKind: ActorKind.shop,
        actorLabel: ctx.member.displayName,
        summary: summary(authorized.versionNumber),
        estimateVersion: authorized.versionNumber,
      );
      return saveJob(
        session,
        tx,
        to == JobStatus.completed
            ? job.copyWith(status: to, completedAt: DateTime.now().toUtc())
            : job.copyWith(status: to),
      );
    });
  }

  /// Records a handover at the counter when the customer cannot confirm on
  /// their own link. History marks it as recorded by shop staff.
  Future<RepairJob> recordCollection(
    Session session,
    int jobId,
    String collectedBy,
  ) async {
    final ctx = await requireMember(session);
    final who = requireText(collectedBy, 'Collected by', max: 80);
    return session.db.transaction((tx) async {
      var job = await loadShopJob(
        session,
        jobId,
        ctx.shop.id!,
        transaction: tx,
        lock: true,
      );
      requireTransition(job.status, JobStatus.collected, 'record collection');
      job = await appendEvent(
        session,
        tx,
        job,
        type: JobEventType.collectionAcknowledged,
        actorKind: ActorKind.shop,
        actorLabel: ctx.member.displayName,
        summary:
            'Device handed over to $who. Recorded by shop staff '
            '(${ctx.member.displayName}), not confirmed on the customer link.',
      );
      return saveJob(
        session,
        tx,
        job.copyWith(
          status: JobStatus.collected,
          collectedAt: DateTime.now().toUtc(),
        ),
      );
    });
  }
}
