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
import 'decision_kind.dart' as _i21mg86q;

/// The customer decision on one exact estimate version.
abstract class EstimateDecision
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  EstimateDecision._({
    this.id,
    required this.jobId,
    required this.estimateId,
    required this.versionNumber,
    required this.contentHash,
    required this.decision,
    required this.typedName,
    this.declineReason,
    required this.customerLinkId,
    this.ipAddress,
    this.userAgent,
    required this.decidedAt,
  });

  factory EstimateDecision({
    int? id,
    required int jobId,
    required int estimateId,
    required int versionNumber,
    required String contentHash,
    required _i21mg86q.DecisionKind decision,
    required String typedName,
    String? declineReason,
    required int customerLinkId,
    String? ipAddress,
    String? userAgent,
    required DateTime decidedAt,
  }) = _EstimateDecisionImpl;

  factory EstimateDecision.fromJson(Map<String, dynamic> jsonSerialization) {
    return EstimateDecision(
      id: jsonSerialization['id'] as int?,
      jobId: jsonSerialization['jobId'] as int,
      estimateId: jsonSerialization['estimateId'] as int,
      versionNumber: jsonSerialization['versionNumber'] as int,
      contentHash: jsonSerialization['contentHash'] as String,
      decision: _i21mg86q.DecisionKind.fromJson(
        (jsonSerialization['decision'] as String),
      ),
      typedName: jsonSerialization['typedName'] as String,
      declineReason: jsonSerialization['declineReason'] as String?,
      customerLinkId: jsonSerialization['customerLinkId'] as int,
      ipAddress: jsonSerialization['ipAddress'] as String?,
      userAgent: jsonSerialization['userAgent'] as String?,
      decidedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['decidedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int jobId;

  int estimateId;

  int versionNumber;

  String contentHash;

  _i21mg86q.DecisionKind decision;

  String typedName;

  String? declineReason;

  int customerLinkId;

  String? ipAddress;

  String? userAgent;

  DateTime decidedAt;

  /// Returns a shallow copy of this [EstimateDecision]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  EstimateDecision copyWith({
    int? id,
    int? jobId,
    int? estimateId,
    int? versionNumber,
    String? contentHash,
    _i21mg86q.DecisionKind? decision,
    String? typedName,
    String? declineReason,
    int? customerLinkId,
    String? ipAddress,
    String? userAgent,
    DateTime? decidedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EstimateDecision',
      if (id != null) 'id': id,
      'jobId': jobId,
      'estimateId': estimateId,
      'versionNumber': versionNumber,
      'contentHash': contentHash,
      'decision': decision.toJson(),
      'typedName': typedName,
      if (declineReason != null) 'declineReason': declineReason,
      'customerLinkId': customerLinkId,
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (userAgent != null) 'userAgent': userAgent,
      'decidedAt': decidedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EstimateDecision',
      if (id != null) 'id': id,
      'jobId': jobId,
      'estimateId': estimateId,
      'versionNumber': versionNumber,
      'contentHash': contentHash,
      'decision': decision.toJson(),
      'typedName': typedName,
      if (declineReason != null) 'declineReason': declineReason,
      'customerLinkId': customerLinkId,
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (userAgent != null) 'userAgent': userAgent,
      'decidedAt': decidedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EstimateDecisionImpl extends EstimateDecision {
  _EstimateDecisionImpl({
    int? id,
    required int jobId,
    required int estimateId,
    required int versionNumber,
    required String contentHash,
    required _i21mg86q.DecisionKind decision,
    required String typedName,
    String? declineReason,
    required int customerLinkId,
    String? ipAddress,
    String? userAgent,
    required DateTime decidedAt,
  }) : super._(
         id: id,
         jobId: jobId,
         estimateId: estimateId,
         versionNumber: versionNumber,
         contentHash: contentHash,
         decision: decision,
         typedName: typedName,
         declineReason: declineReason,
         customerLinkId: customerLinkId,
         ipAddress: ipAddress,
         userAgent: userAgent,
         decidedAt: decidedAt,
       );

  /// Returns a shallow copy of this [EstimateDecision]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  EstimateDecision copyWith({
    Object? id = _Undefined,
    int? jobId,
    int? estimateId,
    int? versionNumber,
    String? contentHash,
    _i21mg86q.DecisionKind? decision,
    String? typedName,
    Object? declineReason = _Undefined,
    int? customerLinkId,
    Object? ipAddress = _Undefined,
    Object? userAgent = _Undefined,
    DateTime? decidedAt,
  }) {
    return EstimateDecision(
      id: id is int? ? id : this.id,
      jobId: jobId ?? this.jobId,
      estimateId: estimateId ?? this.estimateId,
      versionNumber: versionNumber ?? this.versionNumber,
      contentHash: contentHash ?? this.contentHash,
      decision: decision ?? this.decision,
      typedName: typedName ?? this.typedName,
      declineReason: declineReason is String?
          ? declineReason
          : this.declineReason,
      customerLinkId: customerLinkId ?? this.customerLinkId,
      ipAddress: ipAddress is String? ? ipAddress : this.ipAddress,
      userAgent: userAgent is String? ? userAgent : this.userAgent,
      decidedAt: decidedAt ?? this.decidedAt,
    );
  }
}
