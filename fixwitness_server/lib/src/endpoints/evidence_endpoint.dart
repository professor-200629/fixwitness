import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../fixwitness/access.dart';
import '../fixwitness/errors.dart';
import '../fixwitness/history.dart';
import '../fixwitness/validation.dart';
import '../generated/protocol.dart';

const _storage = 'private';
const maxPhotoBytes = 5 * 1024 * 1024;
const _allowedTypes = {'image/jpeg': 'jpg', 'image/png': 'png'};

/// Condition and progress photos. Upload is two steps so a device can recover
/// from either half failing:
///
/// 1. [preparePhotoUpload] returns an upload description, or `alreadyStored`
///    when the bytes from an earlier attempt are already on the server.
/// 2. [registerPhoto] checks the stored bytes (type, size, SHA-256) and writes
///    the metadata. It is idempotent per operation id.
class EvidenceEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<PhotoUploadTicket> preparePhotoUpload(
    Session session,
    int jobId,
    UuidValue opId,
    String contentType,
    int sizeBytes,
  ) async {
    final ctx = await requireMember(session);
    await loadShopJob(session, jobId, ctx.shop.id!);
    final ext = _extensionFor(contentType);
    if (sizeBytes < 1 || sizeBytes > maxPhotoBytes) {
      throw FwException(
        code: FwErrorCode.uploadRejected,
        message:
            'Photos must be smaller than ${maxPhotoBytes ~/ (1024 * 1024)} MB.',
      );
    }
    final existing = await _photoForOp(session, opId, jobId);
    final path = _path(ctx.shop.id!, jobId, opId, ext);
    // Storage only reports an upload as existing once it is verified. Verify
    // here so bytes that arrived before a failed registerPhoto call are
    // recognised instead of being uploaded a second time.
    await session.storage.verifyUpload(storageId: _storage, path: path);
    if (existing != null ||
        await session.storage.fileExists(storageId: _storage, path: path)) {
      return PhotoUploadTicket(alreadyStored: true, maxBytes: maxPhotoBytes);
    }
    final description = await session.storage.createUploadDescription(
      storageId: _storage,
      path: path,
      options: UploadOptions(
        maxFileSize: maxPhotoBytes,
        contentLength: sizeBytes,
        preventOverwrite: true,
        metadata: FileMetadata(contentType: contentType),
      ),
    );
    return PhotoUploadTicket(
      alreadyStored: false,
      uploadDescription: description,
      maxBytes: maxPhotoBytes,
    );
  }

  Future<EvidencePhoto> registerPhoto(
    Session session,
    int jobId,
    UuidValue opId,
    String contentType,
    String sha256Hex,
    PhotoStage stage,
    String? caption,
    DateTime capturedAt,
  ) async {
    final ctx = await requireMember(session);
    await loadShopJob(session, jobId, ctx.shop.id!);
    final existing = await _photoForOp(session, opId, jobId);
    if (existing != null) return existing;

    final cleanCaption = optionalText(caption, 'Caption', max: 200);
    final path = _path(ctx.shop.id!, jobId, opId, _extensionFor(contentType));
    // verifyUpload marks a fresh upload as complete; it returns false when the
    // file was verified by an earlier attempt, so existence is checked apart.
    await session.storage.verifyUpload(storageId: _storage, path: path);
    if (!await session.storage.fileExists(storageId: _storage, path: path)) {
      throw FwException(
        code: FwErrorCode.uploadMissing,
        message:
            'The photo has not reached the server yet. It will be uploaded again.',
      );
    }
    final bytes = await session.storage.retrieveFile(
      storageId: _storage,
      path: path,
    );
    final data = bytes.buffer.asUint8List(
      bytes.offsetInBytes,
      bytes.lengthInBytes,
    );
    final problem = _checkImage(data, contentType, sha256Hex);
    if (problem != null) {
      await session.storage.deleteFile(storageId: _storage, path: path);
      throw FwException(code: FwErrorCode.uploadRejected, message: problem);
    }

    try {
      return await session.db.transaction((tx) async {
        var job = await loadShopJob(
          session,
          jobId,
          ctx.shop.id!,
          transaction: tx,
          lock: true,
        );
        final photo = await EvidencePhoto.db.insertRow(
          session,
          EvidencePhoto(
            jobId: jobId,
            clientOpId: opId,
            stage: stage,
            caption: cleanCaption,
            storagePath: path,
            contentType: contentType,
            sizeBytes: data.length,
            sha256: sha256Hex.toLowerCase(),
            capturedAt: capturedAt.toUtc(),
            uploadedByUserId: ctx.member.authUserId,
            uploadedByName: ctx.member.displayName,
            registeredAt: DateTime.now().toUtc(),
          ),
          transaction: tx,
        );
        job = await appendEvent(
          session,
          tx,
          job,
          type: JobEventType.photoAdded,
          actorKind: ActorKind.shop,
          actorLabel: ctx.member.displayName,
          summary:
              '${_stageLabel(stage)} photo added'
              '${cleanCaption == null ? '' : ': $cleanCaption'}.',
        );
        await saveJob(session, tx, job);
        return photo;
      });
    } catch (e) {
      if (!isUniqueViolation(e)) rethrow;
      final raced = await _photoForOp(session, opId, jobId);
      if (raced == null) rethrow;
      return raced;
    }
  }

  /// A short-lived URL for one photo of a job in the caller's shop.
  Future<String> photoUrl(Session session, int photoId) async {
    final ctx = await requireMember(session);
    final photo = await EvidencePhoto.db.findById(session, photoId);
    if (photo == null) throw notFound('Photo not found.');
    await loadShopJob(session, photo.jobId, ctx.shop.id!);
    final url = await session.storage.temporaryDownloadUrl(
      storageId: _storage,
      path: photo.storagePath!,
      options: TemporaryDownloadUrlOptions(
        expirationDuration: const Duration(minutes: 10),
        contentType: photo.contentType,
      ),
    );
    return url.toString();
  }

  Future<EvidencePhoto?> _photoForOp(
    Session session,
    UuidValue opId,
    int jobId,
  ) async {
    final photo = await EvidencePhoto.db.findFirstRow(
      session,
      where: (t) => t.clientOpId.equals(opId),
    );
    if (photo != null && photo.jobId != jobId) {
      throw forbidden('This operation id belongs to another job.');
    }
    return photo;
  }

  String _extensionFor(String contentType) {
    final ext = _allowedTypes[contentType];
    if (ext == null) {
      throw FwException(
        code: FwErrorCode.uploadRejected,
        message: 'Only JPEG and PNG photos are accepted.',
      );
    }
    return ext;
  }

  /// Server-derived path; the client never chooses where files go.
  String _path(int shopId, int jobId, UuidValue opId, String ext) =>
      'shops/$shopId/jobs/$jobId/photos/${opId.uuid}.$ext';

  String? _checkImage(Uint8List data, String contentType, String sha256Hex) {
    if (data.isEmpty || data.length > maxPhotoBytes) {
      return 'The stored photo has an invalid size; it will be uploaded again.';
    }
    final isJpeg =
        data.length > 3 &&
        data[0] == 0xFF &&
        data[1] == 0xD8 &&
        data[2] == 0xFF;
    final isPng =
        data.length > 8 &&
        data[0] == 0x89 &&
        data[1] == 0x50 &&
        data[2] == 0x4E &&
        data[3] == 0x47;
    if ((contentType == 'image/jpeg' && !isJpeg) ||
        (contentType == 'image/png' && !isPng)) {
      return 'The file is not a valid ${_allowedTypes[contentType]!.toUpperCase()} image.';
    }
    if (sha256.convert(data).toString() != sha256Hex.toLowerCase()) {
      return 'The photo arrived incomplete or changed in transit; it will be uploaded again.';
    }
    return null;
  }

  String _stageLabel(PhotoStage stage) => switch (stage) {
    PhotoStage.intake => 'Check-in condition',
    PhotoStage.progress => 'Repair progress',
    PhotoStage.completion => 'Completed repair',
    PhotoStage.handover => 'Handover',
  };
}
