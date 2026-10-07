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
import 'job_status.dart' as _iayt1i3u;

abstract class RepairJob
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RepairJob._({
    this.id,
    required this.shopId,
    required this.jobNumber,
    required this.clientOpId,
    required this.customerName,
    required this.customerPhone,
    required this.deviceMake,
    required this.deviceModel,
    this.deviceSerial,
    required this.reportedFault,
    this.accessories,
    required this.status,
    int? rowVersion,
    int? eventSeq,
    this.currentEstimateId,
    this.authorizedEstimateId,
    required this.createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.completedAt,
    this.collectedAt,
  }) : rowVersion = rowVersion ?? 1,
       eventSeq = eventSeq ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory RepairJob({
    int? id,
    required int shopId,
    required int jobNumber,
    required _isc.UuidValue clientOpId,
    required String customerName,
    required String customerPhone,
    required String deviceMake,
    required String deviceModel,
    String? deviceSerial,
    required String reportedFault,
    String? accessories,
    required _iayt1i3u.JobStatus status,
    int? rowVersion,
    int? eventSeq,
    int? currentEstimateId,
    int? authorizedEstimateId,
    required _isc.UuidValue createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
    DateTime? collectedAt,
  }) = _RepairJobImpl;

  factory RepairJob.fromJson(Map<String, dynamic> jsonSerialization) {
    return RepairJob(
      id: jsonSerialization['id'] as int?,
      shopId: jsonSerialization['shopId'] as int,
      jobNumber: jsonSerialization['jobNumber'] as int,
      clientOpId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['clientOpId'],
      ),
      customerName: jsonSerialization['customerName'] as String,
      customerPhone: jsonSerialization['customerPhone'] as String,
      deviceMake: jsonSerialization['deviceMake'] as String,
      deviceModel: jsonSerialization['deviceModel'] as String,
      deviceSerial: jsonSerialization['deviceSerial'] as String?,
      reportedFault: jsonSerialization['reportedFault'] as String,
      accessories: jsonSerialization['accessories'] as String?,
      status: _iayt1i3u.JobStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      rowVersion: jsonSerialization['rowVersion'] as int?,
      eventSeq: jsonSerialization['eventSeq'] as int?,
      currentEstimateId: jsonSerialization['currentEstimateId'] as int?,
      authorizedEstimateId: jsonSerialization['authorizedEstimateId'] as int?,
      createdByUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['createdByUserId'],
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      collectedAt: jsonSerialization['collectedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['collectedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int shopId;

  /// Human-facing number, unique within the shop.
  int jobNumber;

  /// Operation id from the device that created the job; makes creation idempotent.
  _isc.UuidValue clientOpId;

  String customerName;

  String customerPhone;

  String deviceMake;

  String deviceModel;

  /// IMEI or serial as printed on the device. Never a passcode.
  String? deviceSerial;

  String reportedFault;

  String? accessories;

  _iayt1i3u.JobStatus status;

  /// Incremented by every state change; lets clients detect stale views.
  int rowVersion;

  /// Last JobEvent.seq written for this job.
  int eventSeq;

  /// Latest issued estimate (any status).
  int? currentEstimateId;

  /// Latest estimate the customer approved. Work beyond it is not authorized.
  int? authorizedEstimateId;

  _isc.UuidValue createdByUserId;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? completedAt;

  DateTime? collectedAt;

  /// Returns a shallow copy of this [RepairJob]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RepairJob copyWith({
    int? id,
    int? shopId,
    int? jobNumber,
    _isc.UuidValue? clientOpId,
    String? customerName,
    String? customerPhone,
    String? deviceMake,
    String? deviceModel,
    String? deviceSerial,
    String? reportedFault,
    String? accessories,
    _iayt1i3u.JobStatus? status,
    int? rowVersion,
    int? eventSeq,
    int? currentEstimateId,
    int? authorizedEstimateId,
    _isc.UuidValue? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
    DateTime? collectedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RepairJob',
      if (id != null) 'id': id,
      'shopId': shopId,
      'jobNumber': jobNumber,
      'clientOpId': clientOpId.toJson(),
      'customerName': customerName,
      'customerPhone': customerPhone,
      'deviceMake': deviceMake,
      'deviceModel': deviceModel,
      if (deviceSerial != null) 'deviceSerial': deviceSerial,
      'reportedFault': reportedFault,
      if (accessories != null) 'accessories': accessories,
      'status': status.toJson(),
      'rowVersion': rowVersion,
      'eventSeq': eventSeq,
      if (currentEstimateId != null) 'currentEstimateId': currentEstimateId,
      if (authorizedEstimateId != null)
        'authorizedEstimateId': authorizedEstimateId,
      'createdByUserId': createdByUserId.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (collectedAt != null) 'collectedAt': collectedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RepairJob',
      if (id != null) 'id': id,
      'shopId': shopId,
      'jobNumber': jobNumber,
      'clientOpId': clientOpId.toJson(),
      'customerName': customerName,
      'customerPhone': customerPhone,
      'deviceMake': deviceMake,
      'deviceModel': deviceModel,
      if (deviceSerial != null) 'deviceSerial': deviceSerial,
      'reportedFault': reportedFault,
      if (accessories != null) 'accessories': accessories,
      'status': status.toJson(),
      'rowVersion': rowVersion,
      'eventSeq': eventSeq,
      if (currentEstimateId != null) 'currentEstimateId': currentEstimateId,
      if (authorizedEstimateId != null)
        'authorizedEstimateId': authorizedEstimateId,
      'createdByUserId': createdByUserId.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (collectedAt != null) 'collectedAt': collectedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RepairJobImpl extends RepairJob {
  _RepairJobImpl({
    int? id,
    required int shopId,
    required int jobNumber,
    required _isc.UuidValue clientOpId,
    required String customerName,
    required String customerPhone,
    required String deviceMake,
    required String deviceModel,
    String? deviceSerial,
    required String reportedFault,
    String? accessories,
    required _iayt1i3u.JobStatus status,
    int? rowVersion,
    int? eventSeq,
    int? currentEstimateId,
    int? authorizedEstimateId,
    required _isc.UuidValue createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
    DateTime? collectedAt,
  }) : super._(
         id: id,
         shopId: shopId,
         jobNumber: jobNumber,
         clientOpId: clientOpId,
         customerName: customerName,
         customerPhone: customerPhone,
         deviceMake: deviceMake,
         deviceModel: deviceModel,
         deviceSerial: deviceSerial,
         reportedFault: reportedFault,
         accessories: accessories,
         status: status,
         rowVersion: rowVersion,
         eventSeq: eventSeq,
         currentEstimateId: currentEstimateId,
         authorizedEstimateId: authorizedEstimateId,
         createdByUserId: createdByUserId,
         createdAt: createdAt,
         updatedAt: updatedAt,
         completedAt: completedAt,
         collectedAt: collectedAt,
       );

  /// Returns a shallow copy of this [RepairJob]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RepairJob copyWith({
    Object? id = _Undefined,
    int? shopId,
    int? jobNumber,
    _isc.UuidValue? clientOpId,
    String? customerName,
    String? customerPhone,
    String? deviceMake,
    String? deviceModel,
    Object? deviceSerial = _Undefined,
    String? reportedFault,
    Object? accessories = _Undefined,
    _iayt1i3u.JobStatus? status,
    int? rowVersion,
    int? eventSeq,
    Object? currentEstimateId = _Undefined,
    Object? authorizedEstimateId = _Undefined,
    _isc.UuidValue? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? completedAt = _Undefined,
    Object? collectedAt = _Undefined,
  }) {
    return RepairJob(
      id: id is int? ? id : this.id,
      shopId: shopId ?? this.shopId,
      jobNumber: jobNumber ?? this.jobNumber,
      clientOpId: clientOpId ?? this.clientOpId,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      deviceMake: deviceMake ?? this.deviceMake,
      deviceModel: deviceModel ?? this.deviceModel,
      deviceSerial: deviceSerial is String? ? deviceSerial : this.deviceSerial,
      reportedFault: reportedFault ?? this.reportedFault,
      accessories: accessories is String? ? accessories : this.accessories,
      status: status ?? this.status,
      rowVersion: rowVersion ?? this.rowVersion,
      eventSeq: eventSeq ?? this.eventSeq,
      currentEstimateId: currentEstimateId is int?
          ? currentEstimateId
          : this.currentEstimateId,
      authorizedEstimateId: authorizedEstimateId is int?
          ? authorizedEstimateId
          : this.authorizedEstimateId,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      collectedAt: collectedAt is DateTime? ? collectedAt : this.collectedAt,
    );
  }
}
