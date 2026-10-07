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

enum JobEventType implements _isc.SerializableModel {
  jobCreated,
  conditionRecorded,
  photoAdded,
  noteAdded,
  estimateIssued,
  estimateSuperseded,
  estimateApproved,
  estimateDeclined,
  approvalRejected,
  workStarted,
  repairCompleted,
  collectionAcknowledged,
  customerLinkCreated,
  customerLinkRevoked;

  static JobEventType fromJson(String name) {
    switch (name) {
      case 'jobCreated':
        return JobEventType.jobCreated;
      case 'conditionRecorded':
        return JobEventType.conditionRecorded;
      case 'photoAdded':
        return JobEventType.photoAdded;
      case 'noteAdded':
        return JobEventType.noteAdded;
      case 'estimateIssued':
        return JobEventType.estimateIssued;
      case 'estimateSuperseded':
        return JobEventType.estimateSuperseded;
      case 'estimateApproved':
        return JobEventType.estimateApproved;
      case 'estimateDeclined':
        return JobEventType.estimateDeclined;
      case 'approvalRejected':
        return JobEventType.approvalRejected;
      case 'workStarted':
        return JobEventType.workStarted;
      case 'repairCompleted':
        return JobEventType.repairCompleted;
      case 'collectionAcknowledged':
        return JobEventType.collectionAcknowledged;
      case 'customerLinkCreated':
        return JobEventType.customerLinkCreated;
      case 'customerLinkRevoked':
        return JobEventType.customerLinkRevoked;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "JobEventType"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
