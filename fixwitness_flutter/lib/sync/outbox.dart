import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:fixwitness_client/fixwitness_client.dart';

import 'outbox_api.dart';
import 'outbox_store.dart';

/// How a failed attempt should be treated.
enum FailureKind {
  /// No connection, timeout, server restarting: keep the operation pending.
  transient,

  /// The server rejected the content: needs the technician (retry/discard).
  permanent,
}

FailureKind classify(Object error) {
  if (error is FwException) return FailureKind.permanent;
  if (error is ServerpodClientBadRequest ||
      error is ServerpodClientForbidden ||
      error is ServerpodClientNotFound) {
    return FailureKind.permanent;
  }
  // Network errors, timeouts, 401 (session expired; the auth manager
  // refreshes or the user signs in again), 5xx while the server restarts.
  return FailureKind.transient;
}

String describe(Object error) {
  if (error is FwException) return error.message;
  if (error is _UploadInterrupted) return error.message;
  if (error is ServerpodClientUnauthorized) {
    return 'Signed out. Sign in again to send this.';
  }
  if (error is ServerpodClientException) return 'No connection to the server.';
  if (error is TimeoutException) return 'The server did not answer in time.';
  return 'No connection to the server.';
}

/// Result of one sync pass, for the UI and for tests.
class SyncReport {
  int confirmed = 0;
  int failed = 0;
  int stillPending = 0;
  bool reachedServer = true;

  @override
  String toString() =>
      'confirmed=$confirmed failed=$failed pending=$stillPending reached=$reachedServer';
}

/// Durable queue of evidence captured on the shop floor: new jobs, notes,
/// condition checklists and photos. Everything is written locally first and
/// sent in order; the server deduplicates by operation id, so resending after
/// a lost response is always safe.
///
/// Estimates, workflow transitions and customer approvals are deliberately
/// not queued: they need the server's answer at the moment they happen.
class Outbox {
  Outbox({
    required this.store,
    required this.vault,
    required this.api,
    this.callTimeout = const Duration(seconds: 30),
    this.uploadTimeout = const Duration(minutes: 2),
  });

  /// A request that has not answered by then is treated as a lost
  /// connection: the operation stays pending and the queue is not blocked.
  /// Resending later is safe because the server deduplicates by operation id.
  final Duration callTimeout;
  final Duration uploadTimeout;

  final OutboxStore store;
  final PhotoVault vault;
  final OutboxApi api;

  final _changes = StreamController<void>.broadcast();
  bool _syncing = false;
  Completer<SyncReport>? _running;

  /// Fires whenever any operation changes state.
  Stream<void> get changes => _changes.stream;

  Future<List<PendingOperation>> operations() => store.all();

  /// Operations that belong to [serverJobId] (or to the queued job [jobOpId]).
  Future<List<PendingOperation>> forJob({
    int? serverJobId,
    UuidValue? jobOpId,
  }) async {
    final all = await store.all();
    return all
        .where(
          (o) =>
              (serverJobId != null && o.serverJobId == serverJobId) ||
              (jobOpId != null &&
                  (o.parentOpId == jobOpId || o.opId == jobOpId)),
        )
        .toList();
  }

  Future<PendingOperation> enqueueCreateJob(NewJobInput input) => _enqueue(
    kind: OpKind.createJob,
    payload: input.toJson(),
  );

  Future<PendingOperation> enqueueNote({
    int? serverJobId,
    UuidValue? jobOpId,
    required String text,
    required bool customerVisible,
  }) => _enqueue(
    kind: OpKind.addNote,
    serverJobId: serverJobId,
    parentOpId: jobOpId,
    payload: {
      'text': text,
      'customerVisible': customerVisible,
      'writtenAt': DateTime.now().toUtc().toIso8601String(),
    },
  );

  Future<PendingOperation> enqueueCondition({
    int? serverJobId,
    UuidValue? jobOpId,
    required List<ConditionItem> items,
  }) => _enqueue(
    kind: OpKind.saveCondition,
    serverJobId: serverJobId,
    parentOpId: jobOpId,
    payload: {
      'items': [for (final i in items) i.toJson()],
      'capturedAt': DateTime.now().toUtc().toIso8601String(),
    },
  );

  Future<PendingOperation> enqueuePhoto({
    int? serverJobId,
    UuidValue? jobOpId,
    required Uint8List bytes,
    required String contentType,
    required PhotoStage stage,
    String? caption,
  }) async {
    final opId = const Uuid().v4obj();
    // Bytes go to disk before the queue row exists, so a crash in between
    // leaves at worst an orphan file, never a queue row without its photo.
    final path = await vault.save(opId, bytes);
    return _enqueue(
      opId: opId,
      kind: OpKind.addPhoto,
      serverJobId: serverJobId,
      parentOpId: jobOpId,
      localFilePath: path,
      payload: {
        'contentType': contentType,
        'sizeBytes': bytes.length,
        'sha256': sha256.convert(bytes).toString(),
        'stage': stage.name,
        'caption': caption,
        'capturedAt': DateTime.now().toUtc().toIso8601String(),
      },
    );
  }

  Future<PendingOperation> _enqueue({
    UuidValue? opId,
    required OpKind kind,
    int? serverJobId,
    UuidValue? parentOpId,
    String? localFilePath,
    required Map<String, dynamic> payload,
  }) async {
    final now = DateTime.now().toUtc();
    final op = await store.insert(
      PendingOperation(
        opId: opId ?? const Uuid().v4obj(),
        kind: kind,
        status: OpStatus.pending,
        serverJobId: serverJobId,
        parentOpId: parentOpId,
        payloadJson: jsonEncode(payload),
        localFilePath: localFilePath,
        createdAt: now,
        updatedAt: now,
      ),
    );
    _changes.add(null);
    return op;
  }

  /// Puts a failed operation back in the queue.
  Future<void> retry(PendingOperation op) async {
    await _save(op.copyWith(status: OpStatus.pending, lastError: null));
  }

  /// Drops an operation the technician decided not to send.
  Future<void> discard(PendingOperation op) async {
    if (op.localFilePath != null) await vault.delete(op.localFilePath!);
    await store.delete(op);
    _changes.add(null);
  }

  /// Removes confirmed operations older than [age].
  Future<void> pruneConfirmed({Duration age = const Duration(days: 1)}) async {
    final cutoff = DateTime.now().toUtc().subtract(age);
    for (final op in await store.all()) {
      if (op.status == OpStatus.confirmed && op.updatedAt.isBefore(cutoff)) {
        await store.delete(op);
      }
    }
  }

  /// Called at startup: an operation marked `syncing` when the app died was
  /// interrupted mid-flight. It goes back to pending; the server-side
  /// deduplication makes resending it harmless.
  Future<void> recoverInterrupted() async {
    for (final op in await store.all()) {
      if (op.status == OpStatus.syncing) {
        await _save(op.copyWith(status: OpStatus.pending));
      }
    }
  }

  /// Sends queued operations in order. Stops at the first network failure, so
  /// later work is not attempted while offline. Concurrent calls share one run.
  Future<SyncReport> syncOnce() {
    if (_syncing) return _running!.future;
    _syncing = true;
    _running = Completer<SyncReport>();
    _run()
        .then(_running!.complete, onError: _running!.completeError)
        .whenComplete(
          () => _syncing = false,
        );
    return _running!.future;
  }

  Future<SyncReport> _run() async {
    final report = SyncReport();
    final ops = await store.all();
    final byOpId = {for (final o in ops) o.opId.uuid: o};
    for (var op in ops) {
      if (op.status == OpStatus.confirmed || op.status == OpStatus.failed) {
        if (op.status == OpStatus.failed) report.failed++;
        continue;
      }
      // Work on a job created offline waits until the job itself is confirmed.
      if (op.serverJobId == null && op.parentOpId != null) {
        final parent = byOpId[op.parentOpId!.uuid];
        if (parent?.status == OpStatus.confirmed && parent?.resultId != null) {
          op = await _save(op.copyWith(serverJobId: parent!.resultId));
        } else {
          if (parent == null || parent.status == OpStatus.failed) {
            await _save(
              op.copyWith(
                status: OpStatus.failed,
                lastError: 'The job this belongs to could not be created.',
              ),
            );
            report.failed++;
          } else {
            report.stillPending++;
          }
          continue;
        }
      }

      op = await _save(
        op.copyWith(
          status: OpStatus.syncing,
          attempts: op.attempts + 1,
        ),
      );
      try {
        op = await _send(op);
        op = await _save(
          op.copyWith(status: OpStatus.confirmed, lastError: null),
        );
        byOpId[op.opId.uuid] = op;
        if (op.localFilePath != null) await vault.delete(op.localFilePath!);
        report.confirmed++;
      } catch (e) {
        // _send may have persisted progress (uploadDone); build on that copy.
        op = await _reload(op);
        if (classify(e) == FailureKind.permanent) {
          await _save(
            op.copyWith(status: OpStatus.failed, lastError: describe(e)),
          );
          report.failed++;
        } else {
          await _save(
            op.copyWith(status: OpStatus.pending, lastError: describe(e)),
          );
          report.stillPending++;
          report.reachedServer = false;
          // Offline: leave the rest queued and in order.
          for (final rest in ops.skipWhile((o) => o.opId != op.opId).skip(1)) {
            if (rest.status == OpStatus.pending) report.stillPending++;
          }
          break;
        }
      }
    }
    return report;
  }

  Future<PendingOperation> _send(PendingOperation op) async {
    final payload = jsonDecode(op.payloadJson) as Map<String, dynamic>;
    switch (op.kind) {
      case OpKind.createJob:
        final job = await api
            .createJob(op.opId, NewJobInput.fromJson(payload))
            .timeout(callTimeout);
        return op.copyWith(resultId: job.id, serverJobId: job.id);
      case OpKind.addNote:
        final note = await api
            .addNote(
              op.serverJobId!,
              op.opId,
              payload['text'] as String,
              payload['customerVisible'] as bool,
              DateTime.parse(payload['writtenAt'] as String),
            )
            .timeout(callTimeout);
        return op.copyWith(resultId: note.id);
      case OpKind.saveCondition:
        final report = await api
            .saveCondition(
              op.serverJobId!,
              op.opId,
              [
                for (final i in payload['items'] as List)
                  ConditionItem.fromJson(i as Map<String, dynamic>),
              ],
              DateTime.parse(payload['capturedAt'] as String),
            )
            .timeout(callTimeout);
        return op.copyWith(resultId: report.id);
      case OpKind.addPhoto:
        return _sendPhoto(op, payload);
    }
  }

  /// Photo upload in two recorded steps. `uploadDone` is persisted as soon as
  /// the bytes are on the server, so if registering the metadata fails (or the
  /// app is killed) the next attempt only registers. If the server reports the
  /// bytes missing or damaged, the flag is cleared and the upload repeats.
  Future<PendingOperation> _sendPhoto(
    PendingOperation op,
    Map<String, dynamic> payload,
  ) async {
    final jobId = op.serverJobId!;
    final contentType = payload['contentType'] as String;
    if (!op.uploadDone) {
      final bytes = await vault.read(op.localFilePath!);
      if (bytes == null) {
        throw FwException(
          code: FwErrorCode.uploadMissing,
          message: 'The photo file is no longer on this device. Take it again.',
        );
      }
      final ticket = await api
          .preparePhotoUpload(
            jobId,
            op.opId,
            contentType,
            bytes.length,
          )
          .timeout(callTimeout);
      if (!ticket.alreadyStored) {
        final ok = await api
            .upload(ticket.uploadDescription!, bytes)
            .timeout(uploadTimeout);
        if (!ok) throw const _UploadInterrupted();
      }
      op = await _save(op.copyWith(uploadDone: true));
    }
    try {
      final photo = await api
          .registerPhoto(
            jobId,
            op.opId,
            contentType,
            payload['sha256'] as String,
            PhotoStage.values.byName(payload['stage'] as String),
            payload['caption'] as String?,
            DateTime.parse(payload['capturedAt'] as String),
          )
          .timeout(callTimeout);
      return op.copyWith(resultId: photo.id);
    } on FwException catch (e) {
      if (e.code == FwErrorCode.uploadMissing ||
          e.code == FwErrorCode.uploadRejected) {
        await _save(op.copyWith(uploadDone: false));
        // Retry the whole upload on the next pass instead of failing for good.
        throw _UploadInterrupted(e.message);
      }
      rethrow;
    }
  }

  Future<PendingOperation> _reload(PendingOperation op) async =>
      (await store.all()).firstWhere((o) => o.id == op.id, orElse: () => op);

  Future<PendingOperation> _save(PendingOperation op) async {
    final saved = await store.update(
      op.copyWith(updatedAt: DateTime.now().toUtc()),
    );
    _changes.add(null);
    return saved;
  }

  Future<void> dispose() => _changes.close();
}

class _UploadInterrupted implements Exception {
  const _UploadInterrupted([
    this.message = 'The photo upload was interrupted.',
  ]);

  final String message;

  @override
  String toString() => message;
}
