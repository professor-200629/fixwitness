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

/// Pushed live to every signed-in device of a shop when one of its jobs
/// changes. Carries only what a notification needs; clients reload the job.
abstract class JobChange
    implements _is.SerializableModel, _is.ProtocolSerialization {
  JobChange._({
    required this.jobId,
    required this.jobNumber,
    required this.summary,
    required this.fromCustomer,
    required this.occurredAt,
  });

  factory JobChange({
    required int jobId,
    required int jobNumber,
    required String summary,
    required bool fromCustomer,
    required DateTime occurredAt,
  }) = _JobChangeImpl;

  factory JobChange.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobChange(
      jobId: jsonSerialization['jobId'] as int,
      jobNumber: jsonSerialization['jobNumber'] as int,
      summary: jsonSerialization['summary'] as String,
      fromCustomer: _is.BoolJsonExtension.fromJson(
        jsonSerialization['fromCustomer'],
      ),
      occurredAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredAt'],
      ),
    );
  }

  int jobId;

  int jobNumber;

  String summary;

  /// True when the customer did it (approval, decline, collection).
  bool fromCustomer;

  DateTime occurredAt;

  /// Returns a shallow copy of this [JobChange]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  JobChange copyWith({
    int? jobId,
    int? jobNumber,
    String? summary,
    bool? fromCustomer,
    DateTime? occurredAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobChange',
      'jobId': jobId,
      'jobNumber': jobNumber,
      'summary': summary,
      'fromCustomer': fromCustomer,
      'occurredAt': occurredAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobChange',
      'jobId': jobId,
      'jobNumber': jobNumber,
      'summary': summary,
      'fromCustomer': fromCustomer,
      'occurredAt': occurredAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _JobChangeImpl extends JobChange {
  _JobChangeImpl({
    required int jobId,
    required int jobNumber,
    required String summary,
    required bool fromCustomer,
    required DateTime occurredAt,
  }) : super._(
         jobId: jobId,
         jobNumber: jobNumber,
         summary: summary,
         fromCustomer: fromCustomer,
         occurredAt: occurredAt,
       );

  /// Returns a shallow copy of this [JobChange]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  JobChange copyWith({
    int? jobId,
    int? jobNumber,
    String? summary,
    bool? fromCustomer,
    DateTime? occurredAt,
  }) {
    return JobChange(
      jobId: jobId ?? this.jobId,
      jobNumber: jobNumber ?? this.jobNumber,
      summary: summary ?? this.summary,
      fromCustomer: fromCustomer ?? this.fromCustomer,
      occurredAt: occurredAt ?? this.occurredAt,
    );
  }
}
