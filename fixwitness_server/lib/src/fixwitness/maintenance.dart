import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

const evidenceStorage = 'private';

/// Deletes photo bytes that were uploaded but never registered as evidence
/// (the device was lost, the job was abandoned, the app was uninstalled),
/// once their upload grant is older than [olderThan]. Registered photos are
/// never touched: their grant was removed when they were registered.
///
/// Returns how many files were deleted.
Future<int> sweepOrphanUploads(
  Session session, {
  Duration olderThan = const Duration(hours: 24),
}) async {
  final cutoff = DateTime.now().toUtc().subtract(olderThan);
  final stale = await UploadGrant.db.find(
    session,
    where: (t) => t.createdAt < cutoff,
    limit: 500,
  );
  var deleted = 0;
  for (final grant in stale) {
    final registered = await EvidencePhoto.db.findFirstRow(
      session,
      where: (t) => t.clientOpId.equals(grant.opId),
    );
    if (registered != null) {
      await UploadGrant.db.deleteRow(session, grant);
      continue;
    }
    // Storage only reports verified uploads as existing, and an orphan is by
    // definition never verified by registerPhoto: verify it first.
    await session.storage.verifyUpload(
      storageId: evidenceStorage,
      path: grant.path,
    );
    if (await session.storage.fileExists(
      storageId: evidenceStorage,
      path: grant.path,
    )) {
      await session.storage.deleteFile(
        storageId: evidenceStorage,
        path: grant.path,
      );
      deleted++;
    }
    await UploadGrant.db.deleteRow(session, grant);
  }
  if (stale.isNotEmpty) {
    session.log(
      'Orphan upload sweep: ${stale.length} grants expired, $deleted files deleted.',
    );
  }
  return deleted;
}

/// Scheduled by `server.dart` to run every hour.
class MaintenanceFutureCall extends FutureCall {
  Future<void> sweep(Session session) async {
    await sweepOrphanUploads(session);
  }
}
