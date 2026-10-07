import 'package:serverpod/serverpod.dart';

import '../fixwitness/errors.dart';
import '../fixwitness/history.dart';
import '../fixwitness/links.dart';
import '../fixwitness/validation.dart';
import '../fixwitness/workflow.dart';
import '../generated/protocol.dart';

/// The customer side, reached only with a review-link token. No account is
/// needed; the token grants access to exactly one job.
///
/// Decisions are refused when the request carries a signed-in shop session,
/// and no shop endpoint can record a customer decision.
class CustomerEndpoint extends Endpoint {
  Future<CustomerJobView> view(Session session, String token) async {
    final link = await resolveLink(session, token);
    await CustomerLink.db.updateRow(
      session,
      link.copyWith(lastOpenedAt: DateTime.now().toUtc()),
    );
    final job = (await RepairJob.db.findById(session, link.jobId))!;
    final shop = (await Shop.db.findById(session, job.shopId))!;
    final jobId = job.id!;
    final estimates = await Estimate.db.find(
      session,
      where: (t) => t.jobId.equals(jobId),
      orderBy: (t) => t.versionNumber,
    );
    final current = estimates
        .where((e) => e.id == job.currentEstimateId)
        .firstOrNull;
    final photos = await EvidencePhoto.db.find(
      session,
      where: (t) => t.jobId.equals(jobId) & t.customerVisible.equals(true),
      orderBy: (t) => t.capturedAt,
    );
    return CustomerJobView(
      shopName: shop.name,
      jobNumber: job.jobNumber,
      deviceLabel: deviceLabel(job),
      customerName: job.customerName,
      reportedFault: job.reportedFault,
      status: job.status,
      currency: shop.currency,
      authorization: authorizationFor(job, estimates, shop.currency),
      currentEstimate: current,
      estimates: estimates,
      decisions: await EstimateDecision.db.find(
        session,
        where: (t) => t.jobId.equals(jobId),
        orderBy: (t) => t.decidedAt,
      ),
      condition: await ConditionReport.db.findFirstRow(
        session,
        where: (t) => t.jobId.equals(jobId),
        orderBy: (t) => t.receivedAt,
      ),
      photos: [
        for (final p in photos)
          CustomerPhoto(
            id: p.id!,
            stage: p.stage,
            caption: p.caption,
            capturedAt: p.capturedAt,
            url: (await session.storage.temporaryDownloadUrl(
              storageId: 'private',
              path: p.storagePath!,
              options: TemporaryDownloadUrlOptions(
                expirationDuration: const Duration(minutes: 30),
                contentType: p.contentType,
              ),
            )).toString(),
          ),
      ],
      notes: await JobNote.db.find(
        session,
        where: (t) => t.jobId.equals(jobId) & t.customerVisible.equals(true),
        orderBy: (t) => t.writtenAt,
      ),
      history: await JobEvent.db.find(
        session,
        where: (t) => t.jobId.equals(jobId) & t.customerVisible.equals(true),
        orderBy: (t) => t.seq,
      ),
      linkExpiresAt: link.expiresAt,
      canDecide:
          job.status == JobStatus.awaitingApproval &&
          current?.status == EstimateStatus.issued,
      canAcknowledgeCollection:
          job.status == JobStatus.completed || job.status == JobStatus.declined,
    );
  }

  /// Approves exactly [versionNumber] of the estimate whose content hash the
  /// customer saw. Refused if a newer version exists or the content differs.
  Future<EstimateDecision> approve(
    Session session,
    String token,
    int estimateId,
    int versionNumber,
    String contentHash,
    String typedName,
  ) => _decide(
    session,
    token,
    estimateId,
    versionNumber,
    contentHash,
    typedName,
    DecisionKind.approved,
    null,
  );

  Future<EstimateDecision> decline(
    Session session,
    String token,
    int estimateId,
    int versionNumber,
    String contentHash,
    String typedName,
    String? reason,
  ) => _decide(
    session,
    token,
    estimateId,
    versionNumber,
    contentHash,
    typedName,
    DecisionKind.declined,
    reason,
  );

  Future<EstimateDecision> _decide(
    Session session,
    String token,
    int estimateId,
    int versionNumber,
    String contentHash,
    String typedName,
    DecisionKind decision,
    String? reason,
  ) async {
    _refuseShopSession(session);
    final name = requireText(typedName, 'Your name', min: 2, max: 80);
    final declineReason = optionalText(reason, 'Reason', max: 300);
    final origin = requestOrigin(session);
    try {
      return await session.db.transaction((tx) async {
        final link = await resolveLink(session, token, transaction: tx);
        var job = (await RepairJob.db.findById(
          session,
          link.jobId,
          transaction: tx,
          lockMode: LockMode.forUpdate,
        ))!;
        final estimate = await Estimate.db.findById(
          session,
          estimateId,
          transaction: tx,
        );
        if (estimate == null || estimate.jobId != job.id) {
          throw notFound('That estimate does not belong to this repair.');
        }
        if (estimate.id != job.currentEstimateId ||
            estimate.versionNumber != versionNumber) {
          final current = (await Estimate.db.findById(
            session,
            job.currentEstimateId!,
            transaction: tx,
          ))!;
          throw _outdated(versionNumber, current);
        }
        if (estimate.status != EstimateStatus.issued) {
          throw badTransition(
            'Estimate v${estimate.versionNumber} was already '
            '${estimate.status.name} on ${_day(estimate.decidedAt)}.',
          );
        }
        if (estimate.contentHash != contentHash) {
          throw FwException(
            code: FwErrorCode.estimateOutdated,
            message:
                'The estimate on your screen does not match version '
                '${estimate.versionNumber} on record. Reload the page and review '
                'it again. Nothing was recorded.',
            attemptedVersion: versionNumber,
            currentVersion: estimate.versionNumber,
          );
        }
        final approved = decision == DecisionKind.approved;
        requireTransition(
          job.status,
          approved ? JobStatus.approved : JobStatus.declined,
          'record your decision',
        );
        final now = DateTime.now().toUtc();
        final saved = await EstimateDecision.db.insertRow(
          session,
          EstimateDecision(
            jobId: job.id!,
            estimateId: estimate.id!,
            versionNumber: estimate.versionNumber,
            contentHash: estimate.contentHash,
            decision: decision,
            typedName: name,
            declineReason: declineReason,
            customerLinkId: link.id!,
            ipAddress: origin.ip,
            userAgent: origin.userAgent,
            decidedAt: now,
          ),
          transaction: tx,
        );
        await Estimate.db.updateRow(
          session,
          estimate.copyWith(
            status: approved
                ? EstimateStatus.approved
                : EstimateStatus.declined,
            decidedAt: now,
          ),
          transaction: tx,
        );
        final total = formatMoney(estimate.totalMinor, estimate.currency);
        job = await appendEvent(
          session,
          tx,
          job,
          type: approved
              ? JobEventType.estimateApproved
              : JobEventType.estimateDeclined,
          actorKind: ActorKind.customer,
          actorLabel: name,
          summary: approved
              ? 'Customer approved estimate v${estimate.versionNumber} ($total), '
                    'signed as "$name".'
              : 'Customer declined estimate v${estimate.versionNumber} ($total)'
                    '${declineReason == null ? '' : ': $declineReason'}.',
          estimateVersion: estimate.versionNumber,
        );
        await saveJob(
          session,
          tx,
          approved
              ? job.copyWith(
                  status: JobStatus.approved,
                  authorizedEstimateId: estimate.id,
                )
              : job.copyWith(status: JobStatus.declined),
        );
        return saved;
      });
    } on FwException catch (e) {
      if (e.code == FwErrorCode.estimateOutdated) {
        await _recordRefusedDecision(session, token, versionNumber, e);
      }
      rethrow;
    }
  }

  /// Confirms that the customer has their device back.
  Future<void> acknowledgeCollection(
    Session session,
    String token,
    String typedName,
  ) async {
    _refuseShopSession(session);
    final name = requireText(typedName, 'Your name', min: 2, max: 80);
    await session.db.transaction((tx) async {
      final link = await resolveLink(session, token, transaction: tx);
      var job = (await RepairJob.db.findById(
        session,
        link.jobId,
        transaction: tx,
        lockMode: LockMode.forUpdate,
      ))!;
      requireTransition(job.status, JobStatus.collected, 'confirm collection');
      job = await appendEvent(
        session,
        tx,
        job,
        type: JobEventType.collectionAcknowledged,
        actorKind: ActorKind.customer,
        actorLabel: name,
        summary: 'Customer confirmed collecting the device, signed as "$name".',
      );
      await saveJob(
        session,
        tx,
        job.copyWith(
          status: JobStatus.collected,
          collectedAt: DateTime.now().toUtc(),
        ),
      );
    });
  }

  void _refuseShopSession(Session session) {
    if (session.isUserSignedIn) {
      throw FwException(
        code: FwErrorCode.shopAccountCannotApprove,
        message:
            'You are signed in to a FixWitness shop account. Only the '
            'customer can decide on an estimate or confirm collection, from '
            'their own link.',
      );
    }
  }

  FwException _outdated(int attempted, Estimate current) => FwException(
    code: FwErrorCode.estimateOutdated,
    message:
        'You were looking at estimate v$attempted, but the shop issued '
        'v${current.versionNumber} on ${_day(current.issuedAt)} '
        '(${formatMoney(current.totalMinor, current.currency)}). Your decision '
        'was not recorded. Review v${current.versionNumber} and decide on it.',
    attemptedVersion: attempted,
    currentVersion: current.versionNumber,
  );

  /// Writes the refused attempt to history in its own transaction (the main
  /// one rolled back). Best effort: the refusal itself must still reach the
  /// customer even if this write fails.
  Future<void> _recordRefusedDecision(
    Session session,
    String token,
    int attemptedVersion,
    FwException refusal,
  ) async {
    try {
      await session.db.transaction((tx) async {
        final link = await resolveLink(session, token, transaction: tx);
        var job = (await RepairJob.db.findById(
          session,
          link.jobId,
          transaction: tx,
          lockMode: LockMode.forUpdate,
        ))!;
        job = await appendEvent(
          session,
          tx,
          job,
          type: JobEventType.approvalRejected,
          actorKind: ActorKind.system,
          actorLabel: 'FixWitness',
          summary:
              'A decision on v$attemptedVersion was refused: '
              '${refusal.currentVersion == attemptedVersion ? 'the content had changed' : 'v${refusal.currentVersion} is the current version'}.',
          estimateVersion: attemptedVersion,
        );
        await saveJob(session, tx, job);
      });
    } catch (e, st) {
      session.log('Could not record refused decision: $e', stackTrace: st);
    }
  }

  String _day(DateTime? t) {
    if (t == null) return 'an earlier date';
    final iso = t
        .toUtc()
        .toIso8601String()
        .substring(0, 16)
        .replaceFirst('T', ' ');
    return '$iso UTC';
  }
}
