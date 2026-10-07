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
import 'package:fixwitness_client/src/protocol/protocol.dart' as _i7z9lov6;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'estimate_line.dart' as _icm2x340;
import 'estimate_status.dart' as _i3t4a52c;

/// One issued estimate version. Rows are inserted once; afterwards only status and
/// decidedAt change. Lines and totals are never edited.
abstract class Estimate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Estimate._({
    this.id,
    required this.jobId,
    required this.versionNumber,
    required this.status,
    required this.lines,
    required this.totalMinor,
    required this.currency,
    this.note,
    this.reasonForRevision,
    required this.contentHash,
    required this.issuedAt,
    required this.issuedByUserId,
    required this.issuedByName,
    this.decidedAt,
  });

  factory Estimate({
    int? id,
    required int jobId,
    required int versionNumber,
    required _i3t4a52c.EstimateStatus status,
    required List<_icm2x340.EstimateLine> lines,
    required int totalMinor,
    required String currency,
    String? note,
    String? reasonForRevision,
    required String contentHash,
    required DateTime issuedAt,
    required _isc.UuidValue issuedByUserId,
    required String issuedByName,
    DateTime? decidedAt,
  }) = _EstimateImpl;

  factory Estimate.fromJson(Map<String, dynamic> jsonSerialization) {
    return Estimate(
      id: jsonSerialization['id'] as int?,
      jobId: jsonSerialization['jobId'] as int,
      versionNumber: jsonSerialization['versionNumber'] as int,
      status: _i3t4a52c.EstimateStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      lines: _i7z9lov6.Protocol().deserialize<List<_icm2x340.EstimateLine>>(
        jsonSerialization['lines'],
      ),
      totalMinor: jsonSerialization['totalMinor'] as int,
      currency: jsonSerialization['currency'] as String,
      note: jsonSerialization['note'] as String?,
      reasonForRevision: jsonSerialization['reasonForRevision'] as String?,
      contentHash: jsonSerialization['contentHash'] as String,
      issuedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['issuedAt'],
      ),
      issuedByUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['issuedByUserId'],
      ),
      issuedByName: jsonSerialization['issuedByName'] as String,
      decidedAt: jsonSerialization['decidedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['decidedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int jobId;

  int versionNumber;

  _i3t4a52c.EstimateStatus status;

  List<_icm2x340.EstimateLine> lines;

  int totalMinor;

  String currency;

  String? note;

  /// Why the shop issued a new version (required from version 2 on).
  String? reasonForRevision;

  /// SHA-256 over the canonical content; the customer approves this exact hash.
  String contentHash;

  DateTime issuedAt;

  _isc.UuidValue issuedByUserId;

  String issuedByName;

  DateTime? decidedAt;

  /// Returns a shallow copy of this [Estimate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Estimate copyWith({
    int? id,
    int? jobId,
    int? versionNumber,
    _i3t4a52c.EstimateStatus? status,
    List<_icm2x340.EstimateLine>? lines,
    int? totalMinor,
    String? currency,
    String? note,
    String? reasonForRevision,
    String? contentHash,
    DateTime? issuedAt,
    _isc.UuidValue? issuedByUserId,
    String? issuedByName,
    DateTime? decidedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Estimate',
      if (id != null) 'id': id,
      'jobId': jobId,
      'versionNumber': versionNumber,
      'status': status.toJson(),
      'lines': lines.toJson(valueToJson: (v) => v.toJson()),
      'totalMinor': totalMinor,
      'currency': currency,
      if (note != null) 'note': note,
      if (reasonForRevision != null) 'reasonForRevision': reasonForRevision,
      'contentHash': contentHash,
      'issuedAt': issuedAt.toJson(),
      'issuedByUserId': issuedByUserId.toJson(),
      'issuedByName': issuedByName,
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Estimate',
      if (id != null) 'id': id,
      'jobId': jobId,
      'versionNumber': versionNumber,
      'status': status.toJson(),
      'lines': lines.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'totalMinor': totalMinor,
      'currency': currency,
      if (note != null) 'note': note,
      if (reasonForRevision != null) 'reasonForRevision': reasonForRevision,
      'contentHash': contentHash,
      'issuedAt': issuedAt.toJson(),
      'issuedByUserId': issuedByUserId.toJson(),
      'issuedByName': issuedByName,
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EstimateImpl extends Estimate {
  _EstimateImpl({
    int? id,
    required int jobId,
    required int versionNumber,
    required _i3t4a52c.EstimateStatus status,
    required List<_icm2x340.EstimateLine> lines,
    required int totalMinor,
    required String currency,
    String? note,
    String? reasonForRevision,
    required String contentHash,
    required DateTime issuedAt,
    required _isc.UuidValue issuedByUserId,
    required String issuedByName,
    DateTime? decidedAt,
  }) : super._(
         id: id,
         jobId: jobId,
         versionNumber: versionNumber,
         status: status,
         lines: lines,
         totalMinor: totalMinor,
         currency: currency,
         note: note,
         reasonForRevision: reasonForRevision,
         contentHash: contentHash,
         issuedAt: issuedAt,
         issuedByUserId: issuedByUserId,
         issuedByName: issuedByName,
         decidedAt: decidedAt,
       );

  /// Returns a shallow copy of this [Estimate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Estimate copyWith({
    Object? id = _Undefined,
    int? jobId,
    int? versionNumber,
    _i3t4a52c.EstimateStatus? status,
    List<_icm2x340.EstimateLine>? lines,
    int? totalMinor,
    String? currency,
    Object? note = _Undefined,
    Object? reasonForRevision = _Undefined,
    String? contentHash,
    DateTime? issuedAt,
    _isc.UuidValue? issuedByUserId,
    String? issuedByName,
    Object? decidedAt = _Undefined,
  }) {
    return Estimate(
      id: id is int? ? id : this.id,
      jobId: jobId ?? this.jobId,
      versionNumber: versionNumber ?? this.versionNumber,
      status: status ?? this.status,
      lines: lines ?? this.lines.map((e0) => e0.copyWith()).toList(),
      totalMinor: totalMinor ?? this.totalMinor,
      currency: currency ?? this.currency,
      note: note is String? ? note : this.note,
      reasonForRevision: reasonForRevision is String?
          ? reasonForRevision
          : this.reasonForRevision,
      contentHash: contentHash ?? this.contentHash,
      issuedAt: issuedAt ?? this.issuedAt,
      issuedByUserId: issuedByUserId ?? this.issuedByUserId,
      issuedByName: issuedByName ?? this.issuedByName,
      decidedAt: decidedAt is DateTime? ? decidedAt : this.decidedAt,
    );
  }
}
