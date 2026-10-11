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

enum FwErrorCode implements _is.SerializableModel {
  notFound,
  forbidden,
  invalidTransition,
  validation,
  estimateOutdated,
  linkInvalid,
  linkExpired,
  linkRevoked,
  shopAccountCannotApprove,
  sensitiveContent,
  uploadMissing,
  uploadRejected,
  inviteInvalid;

  static FwErrorCode fromJson(String name) {
    switch (name) {
      case 'notFound':
        return FwErrorCode.notFound;
      case 'forbidden':
        return FwErrorCode.forbidden;
      case 'invalidTransition':
        return FwErrorCode.invalidTransition;
      case 'validation':
        return FwErrorCode.validation;
      case 'estimateOutdated':
        return FwErrorCode.estimateOutdated;
      case 'linkInvalid':
        return FwErrorCode.linkInvalid;
      case 'linkExpired':
        return FwErrorCode.linkExpired;
      case 'linkRevoked':
        return FwErrorCode.linkRevoked;
      case 'shopAccountCannotApprove':
        return FwErrorCode.shopAccountCannotApprove;
      case 'sensitiveContent':
        return FwErrorCode.sensitiveContent;
      case 'uploadMissing':
        return FwErrorCode.uploadMissing;
      case 'uploadRejected':
        return FwErrorCode.uploadRejected;
      case 'inviteInvalid':
        return FwErrorCode.inviteInvalid;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "FwErrorCode"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
