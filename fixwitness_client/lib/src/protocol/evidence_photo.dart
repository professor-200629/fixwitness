/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'photo_stage.dart' as _izmwwpv6;

abstract class EvidencePhoto
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EvidencePhoto._({
    this.id,
    required this.jobId,
    required this.clientOpId,
    required this.stage,
    this.caption,
    required this.contentType,
    required this.sizeBytes,
    required this.sha256,
    required this.capturedAt,
    required this.uploadedByUserId,
    required this.uploadedByName,
    required this.registeredAt,
    bool? customerVisible,
  }) : customerVisible = customerVisible ?? true;

  factory EvidencePhoto({
    int? id,
    required int jobId,
    required _isc.UuidValue clientOpId,
    required _izmwwpv6.PhotoStage stage,
    String? caption,
    required String contentType,
    required int sizeBytes,
    required String sha256,
    required DateTime capturedAt,
    required _isc.UuidValue uploadedByUserId,
    required String uploadedByName,
    required DateTime registeredAt,
    bool? customerVisible,
  }) = _EvidencePhotoImpl;

  factory EvidencePhoto.fromJson(Map<String, dynamic> jsonSerialization) {
    return EvidencePhoto(
      id: jsonSerialization['id'] as int?,
      jobId: jsonSerialization['jobId'] as int,
      clientOpId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['clientOpId'],
      ),
      stage: _izmwwpv6.PhotoStage.fromJson(
        (jsonSerialization['stage'] as String),
      ),
      caption: jsonSerialization['caption'] as String?,
      contentType: jsonSerialization['contentType'] as String,
      sizeBytes: jsonSerialization['sizeBytes'] as int,
      sha256: jsonSerialization['sha256'] as String,
      capturedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['capturedAt'],
      ),
      uploadedByUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['uploadedByUserId'],
      ),
      uploadedByName: jsonSerialization['uploadedByName'] as String,
      registeredAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['registeredAt'],
      ),
      customerVisible: jsonSerialization['customerVisible'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['customerVisible'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int jobId;

  _isc.UuidValue clientOpId;

  _izmwwpv6.PhotoStage stage;

  String? caption;

  String contentType;

  int sizeBytes;

  String sha256;

  DateTime capturedAt;

  _isc.UuidValue uploadedByUserId;

  String uploadedByName;

  DateTime registeredAt;

  bool customerVisible;

  /// Returns a shallow copy of this [EvidencePhoto]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EvidencePhoto copyWith({
    int? id,
    int? jobId,
    _isc.UuidValue? clientOpId,
    _izmwwpv6.PhotoStage? stage,
    String? caption,
    String? contentType,
    int? sizeBytes,
    String? sha256,
    DateTime? capturedAt,
    _isc.UuidValue? uploadedByUserId,
    String? uploadedByName,
    DateTime? registeredAt,
    bool? customerVisible,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EvidencePhoto',
      if (id != null) 'id': id,
      'jobId': jobId,
      'clientOpId': clientOpId.toJson(),
      'stage': stage.toJson(),
      if (caption != null) 'caption': caption,
      'contentType': contentType,
      'sizeBytes': sizeBytes,
      'sha256': sha256,
      'capturedAt': capturedAt.toJson(),
      'uploadedByUserId': uploadedByUserId.toJson(),
      'uploadedByName': uploadedByName,
      'registeredAt': registeredAt.toJson(),
      'customerVisible': customerVisible,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EvidencePhoto',
      if (id != null) 'id': id,
      'jobId': jobId,
      'clientOpId': clientOpId.toJson(),
      'stage': stage.toJson(),
      if (caption != null) 'caption': caption,
      'contentType': contentType,
      'sizeBytes': sizeBytes,
      'sha256': sha256,
      'capturedAt': capturedAt.toJson(),
      'uploadedByUserId': uploadedByUserId.toJson(),
      'uploadedByName': uploadedByName,
      'registeredAt': registeredAt.toJson(),
      'customerVisible': customerVisible,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EvidencePhotoImpl extends EvidencePhoto {
  _EvidencePhotoImpl({
    int? id,
    required int jobId,
    required _isc.UuidValue clientOpId,
    required _izmwwpv6.PhotoStage stage,
    String? caption,
    required String contentType,
    required int sizeBytes,
    required String sha256,
    required DateTime capturedAt,
    required _isc.UuidValue uploadedByUserId,
    required String uploadedByName,
    required DateTime registeredAt,
    bool? customerVisible,
  }) : super._(
         id: id,
         jobId: jobId,
         clientOpId: clientOpId,
         stage: stage,
         caption: caption,
         contentType: contentType,
         sizeBytes: sizeBytes,
         sha256: sha256,
         capturedAt: capturedAt,
         uploadedByUserId: uploadedByUserId,
         uploadedByName: uploadedByName,
         registeredAt: registeredAt,
         customerVisible: customerVisible,
       );

  /// Returns a shallow copy of this [EvidencePhoto]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EvidencePhoto copyWith({
    Object? id = _Undefined,
    int? jobId,
    _isc.UuidValue? clientOpId,
    _izmwwpv6.PhotoStage? stage,
    Object? caption = _Undefined,
    String? contentType,
    int? sizeBytes,
    String? sha256,
    DateTime? capturedAt,
    _isc.UuidValue? uploadedByUserId,
    String? uploadedByName,
    DateTime? registeredAt,
    bool? customerVisible,
  }) {
    return EvidencePhoto(
      id: id is int? ? id : this.id,
      jobId: jobId ?? this.jobId,
      clientOpId: clientOpId ?? this.clientOpId,
      stage: stage ?? this.stage,
      caption: caption is String? ? caption : this.caption,
      contentType: contentType ?? this.contentType,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      sha256: sha256 ?? this.sha256,
      capturedAt: capturedAt ?? this.capturedAt,
      uploadedByUserId: uploadedByUserId ?? this.uploadedByUserId,
      uploadedByName: uploadedByName ?? this.uploadedByName,
      registeredAt: registeredAt ?? this.registeredAt,
      customerVisible: customerVisible ?? this.customerVisible,
    );
  }
}
