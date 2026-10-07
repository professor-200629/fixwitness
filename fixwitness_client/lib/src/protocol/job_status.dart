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

/// Where a repair job is in the workflow. Transitions are validated on the server.
enum JobStatus implements _isc.SerializableModel {
  checkedIn,
  awaitingApproval,
  approved,
  inProgress,
  declined,
  completed,
  collected;

  static JobStatus fromJson(String name) {
    switch (name) {
      case 'checkedIn':
        return JobStatus.checkedIn;
      case 'awaitingApproval':
        return JobStatus.awaitingApproval;
      case 'approved':
        return JobStatus.approved;
      case 'inProgress':
        return JobStatus.inProgress;
      case 'declined':
        return JobStatus.declined;
      case 'completed':
        return JobStatus.completed;
      case 'collected':
        return JobStatus.collected;
      default:
        throw ArgumentError('Value "$name" cannot be converted to "JobStatus"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
