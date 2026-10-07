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
import 'package:serverpod/serverpod.dart' as _is;
import 'job_status.dart' as _iayt1i3u;

abstract class JobSummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  JobSummary._({
    required this.id,
    required this.jobNumber,
    required this.customerName,
    required this.deviceLabel,
    required this.status,
    required this.rowVersion,
    required this.updatedAt,
    required this.awaitingCustomer,
  });

  factory JobSummary({
    required int id,
    required int jobNumber,
    required String customerName,
    required String deviceLabel,
    required _iayt1i3u.JobStatus status,
    required int rowVersion,
    required DateTime updatedAt,
    required bool awaitingCustomer,
  }) = _JobSummaryImpl;

  factory JobSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobSummary(
      id: jsonSerialization['id'] as int,
      jobNumber: jsonSerialization['jobNumber'] as int,
      customerName: jsonSerialization['customerName'] as String,
      deviceLabel: jsonSerialization['deviceLabel'] as String,
      status: _iayt1i3u.JobStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      rowVersion: jsonSerialization['rowVersion'] as int,
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
      awaitingCustomer: _is.BoolJsonExtension.fromJson(
        jsonSerialization['awaitingCustomer'],
      ),
    );
  }

  int id;

  int jobNumber;

  String customerName;

  String deviceLabel;

  _iayt1i3u.JobStatus status;

  int rowVersion;

  DateTime updatedAt;

  /// True when the latest issued estimate is not approved yet.
  bool awaitingCustomer;

  /// Returns a shallow copy of this [JobSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  JobSummary copyWith({
    int? id,
    int? jobNumber,
    String? customerName,
    String? deviceLabel,
    _iayt1i3u.JobStatus? status,
    int? rowVersion,
    DateTime? updatedAt,
    bool? awaitingCustomer,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobSummary',
      'id': id,
      'jobNumber': jobNumber,
      'customerName': customerName,
      'deviceLabel': deviceLabel,
      'status': status.toJson(),
      'rowVersion': rowVersion,
      'updatedAt': updatedAt.toJson(),
      'awaitingCustomer': awaitingCustomer,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobSummary',
      'id': id,
      'jobNumber': jobNumber,
      'customerName': customerName,
      'deviceLabel': deviceLabel,
      'status': status.toJson(),
      'rowVersion': rowVersion,
      'updatedAt': updatedAt.toJson(),
      'awaitingCustomer': awaitingCustomer,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _JobSummaryImpl extends JobSummary {
  _JobSummaryImpl({
    required int id,
    required int jobNumber,
    required String customerName,
    required String deviceLabel,
    required _iayt1i3u.JobStatus status,
    required int rowVersion,
    required DateTime updatedAt,
    required bool awaitingCustomer,
  }) : super._(
         id: id,
         jobNumber: jobNumber,
         customerName: customerName,
         deviceLabel: deviceLabel,
         status: status,
         rowVersion: rowVersion,
         updatedAt: updatedAt,
         awaitingCustomer: awaitingCustomer,
       );

  /// Returns a shallow copy of this [JobSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  JobSummary copyWith({
    int? id,
    int? jobNumber,
    String? customerName,
    String? deviceLabel,
    _iayt1i3u.JobStatus? status,
    int? rowVersion,
    DateTime? updatedAt,
    bool? awaitingCustomer,
  }) {
    return JobSummary(
      id: id ?? this.id,
      jobNumber: jobNumber ?? this.jobNumber,
      customerName: customerName ?? this.customerName,
      deviceLabel: deviceLabel ?? this.deviceLabel,
      status: status ?? this.status,
      rowVersion: rowVersion ?? this.rowVersion,
      updatedAt: updatedAt ?? this.updatedAt,
      awaitingCustomer: awaitingCustomer ?? this.awaitingCustomer,
    );
  }
}
