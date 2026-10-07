import 'dart:typed_data';

import 'package:fixwitness_client/fixwitness_client.dart';

/// The server calls the outbox needs. Kept as an interface so tests can inject
/// failures (for example a lost response after a successful upload).
abstract class OutboxApi {
  Future<RepairJob> createJob(UuidValue opId, NewJobInput input);

  Future<JobNote> addNote(
    int jobId,
    UuidValue opId,
    String text,
    bool customerVisible,
    DateTime writtenAt,
  );

  Future<ConditionReport> saveCondition(
    int jobId,
    UuidValue opId,
    List<ConditionItem> items,
    DateTime capturedAt,
  );

  Future<PhotoUploadTicket> preparePhotoUpload(
    int jobId,
    UuidValue opId,
    String contentType,
    int sizeBytes,
  );

  /// Sends the bytes to the storage described by [uploadDescription].
  /// Returns false when the upload did not complete.
  Future<bool> upload(String uploadDescription, Uint8List bytes);

  Future<EvidencePhoto> registerPhoto(
    int jobId,
    UuidValue opId,
    String contentType,
    String sha256Hex,
    PhotoStage stage,
    String? caption,
    DateTime capturedAt,
  );
}

class ClientOutboxApi implements OutboxApi {
  ClientOutboxApi(this.client);

  final Client client;

  @override
  Future<RepairJob> createJob(UuidValue opId, NewJobInput input) =>
      client.jobs.create(opId, input);

  @override
  Future<JobNote> addNote(
    int jobId,
    UuidValue opId,
    String text,
    bool customerVisible,
    DateTime writtenAt,
  ) => client.jobs.addNote(jobId, opId, text, customerVisible, writtenAt);

  @override
  Future<ConditionReport> saveCondition(
    int jobId,
    UuidValue opId,
    List<ConditionItem> items,
    DateTime capturedAt,
  ) => client.jobs.saveCondition(jobId, opId, items, capturedAt);

  @override
  Future<PhotoUploadTicket> preparePhotoUpload(
    int jobId,
    UuidValue opId,
    String contentType,
    int sizeBytes,
  ) => client.evidence.preparePhotoUpload(jobId, opId, contentType, sizeBytes);

  @override
  Future<bool> upload(String uploadDescription, Uint8List bytes) =>
      FileUploader(uploadDescription).uploadByteData(ByteData.sublistView(bytes));

  @override
  Future<EvidencePhoto> registerPhoto(
    int jobId,
    UuidValue opId,
    String contentType,
    String sha256Hex,
    PhotoStage stage,
    String? caption,
    DateTime capturedAt,
  ) => client.evidence.registerPhoto(
    jobId,
    opId,
    contentType,
    sha256Hex,
    stage,
    caption,
    capturedAt,
  );
}
