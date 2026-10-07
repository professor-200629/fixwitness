import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:fixwitness_flutter/sync/file_photo_vault.dart';
import 'package:fixwitness_flutter/sync/outbox.dart';
import 'package:fixwitness_flutter/sync/outbox_api.dart';
import 'package:fixwitness_flutter/sync/outbox_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:serverpod_database/serverpod_database.dart';

/// In-memory stand-in for the server with the same idempotency rules
/// (one record per operation id) and switches to inject failures.
class FakeServer implements OutboxApi {
  bool online = true;
  bool loseNextRegisterResponse = false;
  bool failNextRegisterBeforeWrite = false;
  bool corruptNextUpload = false;

  final jobs = <String, RepairJob>{};
  final notes = <String, JobNote>{};
  final reports = <String, ConditionReport>{};
  final photos = <String, EvidencePhoto>{};
  final storedBytes = <String, Uint8List>{};
  int uploads = 0;
  int prepares = 0;
  int _id = 100;

  void _net() {
    if (!online) throw TimeoutException('offline');
  }

  @override
  Future<RepairJob> createJob(UuidValue opId, NewJobInput input) async {
    _net();
    return jobs.putIfAbsent(
      opId.uuid,
      () => RepairJob(
        id: _id++,
        shopId: 1,
        jobNumber: jobs.length + 1,
        clientOpId: opId,
        customerName: input.customerName,
        customerPhone: input.customerPhone,
        deviceMake: input.deviceMake,
        deviceModel: input.deviceModel,
        reportedFault: input.reportedFault,
        status: JobStatus.checkedIn,
        createdByUserId: UuidValue.fromString(
          '11111111-1111-4111-8111-111111111111',
        ),
      ),
    );
  }

  @override
  Future<JobNote> addNote(
    int jobId,
    UuidValue opId,
    String text,
    bool customerVisible,
    DateTime writtenAt,
  ) async {
    _net();
    if (text.contains('passcode')) {
      throw FwException(
        code: FwErrorCode.sensitiveContent,
        message: 'Remove the passcode.',
      );
    }
    return notes.putIfAbsent(
      opId.uuid,
      () => JobNote(
        id: _id++,
        jobId: jobId,
        clientOpId: opId,
        text: text,
        customerVisible: customerVisible,
        authorUserId: UuidValue.fromString(
          '11111111-1111-4111-8111-111111111111',
        ),
        authorName: 'Meena',
        writtenAt: writtenAt,
        receivedAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<ConditionReport> saveCondition(
    int jobId,
    UuidValue opId,
    List<ConditionItem> items,
    DateTime capturedAt,
  ) async {
    _net();
    return reports.putIfAbsent(
      opId.uuid,
      () => ConditionReport(
        id: _id++,
        jobId: jobId,
        clientOpId: opId,
        items: items,
        recordedByUserId: UuidValue.fromString(
          '11111111-1111-4111-8111-111111111111',
        ),
        recordedByName: 'Meena',
        capturedAt: capturedAt,
        receivedAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<PhotoUploadTicket> preparePhotoUpload(
    int jobId,
    UuidValue opId,
    String contentType,
    int sizeBytes,
  ) async {
    _net();
    prepares++;
    final stored =
        photos.containsKey(opId.uuid) || storedBytes.containsKey(opId.uuid);
    return PhotoUploadTicket(
      alreadyStored: stored,
      uploadDescription: stored ? null : 'upload:${opId.uuid}',
      maxBytes: 5 << 20,
    );
  }

  @override
  Future<bool> upload(String uploadDescription, Uint8List bytes) async {
    _net();
    uploads++;
    final key = uploadDescription.substring('upload:'.length);
    storedBytes[key] = corruptNextUpload ? Uint8List(1) : bytes;
    corruptNextUpload = false;
    return true;
  }

  @override
  Future<EvidencePhoto> registerPhoto(
    int jobId,
    UuidValue opId,
    String contentType,
    String sha256Hex,
    PhotoStage stage,
    String? caption,
    DateTime capturedAt,
  ) async {
    _net();
    if (failNextRegisterBeforeWrite) {
      failNextRegisterBeforeWrite = false;
      throw TimeoutException('connection dropped before the server answered');
    }
    final existing = photos[opId.uuid];
    if (existing != null) return existing;
    final bytes = storedBytes[opId.uuid];
    if (bytes == null) {
      throw FwException(
        code: FwErrorCode.uploadMissing,
        message: 'Not on the server yet.',
      );
    }
    if (bytes.length == 1) {
      storedBytes.remove(opId.uuid);
      throw FwException(
        code: FwErrorCode.uploadRejected,
        message: 'Corrupted in transit.',
      );
    }
    final photo = EvidencePhoto(
      id: _id++,
      jobId: jobId,
      clientOpId: opId,
      stage: stage,
      caption: caption,
      contentType: contentType,
      sizeBytes: bytes.length,
      sha256: sha256Hex,
      capturedAt: capturedAt,
      uploadedByUserId: UuidValue.fromString(
        '11111111-1111-4111-8111-111111111111',
      ),
      uploadedByName: 'Meena',
      registeredAt: DateTime.now(),
    );
    photos[opId.uuid] = photo;
    if (loseNextRegisterResponse) {
      loseNextRegisterResponse = false;
      throw TimeoutException('response lost after the server saved the photo');
    }
    return photo;
  }
}

/// One "run" of the app: an open SQLite session and an outbox on top of it.
class AppRun {
  AppRun._(this.session, this.outbox);

  final ClientDatabaseSession session;
  final Outbox outbox;

  static Future<AppRun> start(Directory dir, FakeServer server) async {
    final client = Client('http://localhost:1/');
    final session = await client.createSession(p.join(dir.path, 'app.db'));
    final outbox = Outbox(
      store: SqliteOutboxStore(session),
      vault: FilePhotoVault(Directory(p.join(dir.path, 'photos'))),
      api: server,
    );
    await outbox.recoverInterrupted();
    return AppRun._(session, outbox);
  }

  /// Simulates the app being killed: the session closes without any cleanup.
  Future<void> kill() => session.close();
}

Uint8List jpeg() =>
    Uint8List.fromList([0xFF, 0xD8, 0xFF, ...List.filled(500, 7)]);

NewJobInput intake() => NewJobInput(
  customerName: 'Asha Rao',
  customerPhone: '9845012345',
  deviceMake: 'Samsung',
  deviceModel: 'A52',
  reportedFault: 'Cracked screen',
);

void main() {
  late Directory dir;
  late FakeServer server;

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('fixwitness_outbox_');
    server = FakeServer();
  });

  tearDown(() async {
    try {
      await dir.delete(recursive: true);
    } on FileSystemException {
      // SQLite may still hold the WAL file briefly on Windows.
    }
  });

  test(
    'work captured offline survives an app restart and syncs once online',
    () async {
      server.online = false;
      var run = await AppRun.start(dir, server);
      final jobOp = await run.outbox.enqueueCreateJob(intake());
      await run.outbox.enqueueCondition(
        jobOpId: jobOp.opId,
        items: [
          ConditionItem(
            key: 'screen',
            label: 'Screen',
            state: ConditionState.damaged,
          ),
        ],
      );
      await run.outbox.enqueueNote(
        jobOpId: jobOp.opId,
        text: 'Back glass scratched',
        customerVisible: true,
      );
      await run.outbox.enqueuePhoto(
        jobOpId: jobOp.opId,
        bytes: jpeg(),
        contentType: 'image/jpeg',
        stage: PhotoStage.intake,
      );

      final offline = await run.outbox.syncOnce();
      expect(offline.reachedServer, isFalse);
      expect(
        (await run.outbox.operations()).map((o) => o.status),
        everyElement(OpStatus.pending),
      );

      await run.kill();
      run = await AppRun.start(dir, server);
      final afterRestart = await run.outbox.operations();
      expect(afterRestart, hasLength(4), reason: 'the queue is durable');
      expect(
        afterRestart.first.lastError,
        isNotNull,
        reason: 'the reason it is waiting is kept',
      );

      server.online = true;
      final report = await run.outbox.syncOnce();
      expect(report.confirmed, 4);
      final ops = await run.outbox.operations();
      expect(ops.map((o) => o.status), everyElement(OpStatus.confirmed));
      final jobId = server.jobs.values.single.id;
      expect(
        server.notes.values.single.jobId,
        jobId,
        reason: 'queued work is attached to the job created offline',
      );
      expect(server.reports.values.single.jobId, jobId);
      expect(server.photos.values.single.jobId, jobId);
      expect(
        Directory(p.join(dir.path, 'photos')).listSync(),
        isEmpty,
        reason: 'local photo copies are removed after confirmation',
      );
      await run.kill();
    },
  );

  test(
    'when the upload succeeds but registering fails then only registration is repeated',
    () async {
      final run = await AppRun.start(dir, server);
      final job = await server.createJob(
        UuidValue.fromString('aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa'),
        intake(),
      );
      await run.outbox.enqueuePhoto(
        serverJobId: job.id,
        bytes: jpeg(),
        contentType: 'image/jpeg',
        stage: PhotoStage.intake,
      );

      server.failNextRegisterBeforeWrite = true;
      final first = await run.outbox.syncOnce();
      expect(first.stillPending, 1);
      var op = (await run.outbox.operations()).single;
      expect(
        op.uploadDone,
        isTrue,
        reason: 'the device remembers the bytes are on the server',
      );
      expect(op.status, OpStatus.pending);

      await run.outbox.syncOnce();
      op = (await run.outbox.operations()).single;
      expect(op.status, OpStatus.confirmed);
      expect(server.uploads, 1, reason: 'the photo was not uploaded twice');
      expect(server.photos, hasLength(1));
      await run.kill();
    },
  );

  test(
    'when the app dies between upload and registration then a restart resumes at registration',
    () async {
      var run = await AppRun.start(dir, server);
      final job = await server.createJob(
        UuidValue.fromString('bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb'),
        intake(),
      );
      await run.outbox.enqueuePhoto(
        serverJobId: job.id,
        bytes: jpeg(),
        contentType: 'image/jpeg',
        stage: PhotoStage.intake,
      );
      server.failNextRegisterBeforeWrite = true;
      await run.outbox.syncOnce();
      await run.kill();

      run = await AppRun.start(dir, server);
      await run.outbox.syncOnce();
      expect((await run.outbox.operations()).single.status, OpStatus.confirmed);
      expect(server.uploads, 1);
      await run.kill();
    },
  );

  test(
    'when the response to a saved photo is lost then the retry returns the same photo',
    () async {
      final run = await AppRun.start(dir, server);
      final job = await server.createJob(
        UuidValue.fromString('cccccccc-cccc-4ccc-8ccc-cccccccccccc'),
        intake(),
      );
      await run.outbox.enqueuePhoto(
        serverJobId: job.id,
        bytes: jpeg(),
        contentType: 'image/jpeg',
        stage: PhotoStage.progress,
      );
      server.loseNextRegisterResponse = true;
      await run.outbox.syncOnce();
      await run.outbox.syncOnce();
      final op = (await run.outbox.operations()).single;
      expect(op.status, OpStatus.confirmed);
      expect(op.resultId, server.photos.values.single.id);
      expect(server.photos, hasLength(1));
      await run.kill();
    },
  );

  test(
    'when the stored bytes are corrupted then the photo is uploaded again',
    () async {
      final run = await AppRun.start(dir, server);
      final job = await server.createJob(
        UuidValue.fromString('dddddddd-dddd-4ddd-8ddd-dddddddddddd'),
        intake(),
      );
      await run.outbox.enqueuePhoto(
        serverJobId: job.id,
        bytes: jpeg(),
        contentType: 'image/jpeg',
        stage: PhotoStage.intake,
      );
      server.corruptNextUpload = true;
      await run.outbox.syncOnce();
      var op = (await run.outbox.operations()).single;
      expect(op.status, OpStatus.pending);
      expect(op.uploadDone, isFalse);
      expect(op.lastError, contains('Corrupted'));
      await run.outbox.syncOnce();
      op = (await run.outbox.operations()).single;
      expect(op.status, OpStatus.confirmed);
      expect(server.uploads, 2);
      await run.kill();
    },
  );

  test(
    'when an operation was mid-flight at a crash then it is resent on restart',
    () async {
      var run = await AppRun.start(dir, server);
      final job = await server.createJob(
        UuidValue.fromString('eeeeeeee-eeee-4eee-8eee-eeeeeeeeeeee'),
        intake(),
      );
      final op = await run.outbox.enqueueNote(
        serverJobId: job.id,
        text: 'Ordered part',
        customerVisible: false,
      );
      await SqliteOutboxStore(
        run.session,
      ).update(op.copyWith(status: OpStatus.syncing));
      await run.kill();

      run = await AppRun.start(dir, server);
      expect((await run.outbox.operations()).single.status, OpStatus.pending);
      await run.outbox.syncOnce();
      await run.outbox.syncOnce();
      expect((await run.outbox.operations()).single.status, OpStatus.confirmed);
      expect(
        server.notes,
        hasLength(1),
        reason: 'resending is deduplicated by operation id',
      );
      await run.kill();
    },
  );

  test(
    'when the server rejects the content then the operation fails with the reason and can be discarded',
    () async {
      final run = await AppRun.start(dir, server);
      final job = await server.createJob(
        UuidValue.fromString('ffffffff-ffff-4fff-8fff-ffffffffffff'),
        intake(),
      );
      await run.outbox.enqueueNote(
        serverJobId: job.id,
        text: 'passcode 1234',
        customerVisible: false,
      );
      await run.outbox.enqueueNote(
        serverJobId: job.id,
        text: 'Screen ordered',
        customerVisible: true,
      );
      final report = await run.outbox.syncOnce();
      expect(report.failed, 1);
      expect(
        report.confirmed,
        1,
        reason: 'a rejected item does not block the rest of the queue',
      );
      final failed = (await run.outbox.operations()).firstWhere(
        (o) => o.status == OpStatus.failed,
      );
      expect(failed.lastError, 'Remove the passcode.');
      await run.outbox.discard(failed);
      expect(await run.outbox.operations(), hasLength(1));
      await run.kill();
    },
  );
}
