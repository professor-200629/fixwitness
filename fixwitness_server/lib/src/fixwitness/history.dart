import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Appends a history event for [job] inside [transaction] and returns the job
/// with its `eventSeq` advanced. The caller must hold the job row lock and save
/// the returned job with [saveJob] in the same transaction, so the state change
/// and its history commit or roll back together.
Future<RepairJob> appendEvent(
  Session session,
  Transaction transaction,
  RepairJob job, {
  required JobEventType type,
  required ActorKind actorKind,
  required String actorLabel,
  required String summary,
  bool customerVisible = true,
  int? estimateVersion,
}) async {
  final seq = job.eventSeq + 1;
  await JobEvent.db.insertRow(
    session,
    JobEvent(
      jobId: job.id!,
      seq: seq,
      type: type,
      actorKind: actorKind,
      actorLabel: actorLabel,
      summary: summary,
      customerVisible: customerVisible,
      estimateVersion: estimateVersion,
      occurredAt: DateTime.now().toUtc(),
    ),
    transaction: transaction,
  );
  return job.copyWith(eventSeq: seq);
}

/// Persists [job] with a bumped `rowVersion` and `updatedAt`.
Future<RepairJob> saveJob(
  Session session,
  Transaction transaction,
  RepairJob job,
) {
  return RepairJob.db.updateRow(
    session,
    job.copyWith(
      rowVersion: job.rowVersion + 1,
      updatedAt: DateTime.now().toUtc(),
    ),
    transaction: transaction,
  );
}
