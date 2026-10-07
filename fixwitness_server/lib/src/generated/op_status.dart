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

enum OpStatus implements _is.SerializableModel {
  pending,
  syncing,
  failed,
  confirmed;

  static OpStatus fromJson(String name) {
    switch (name) {
      case 'pending':
        return OpStatus.pending;
      case 'syncing':
        return OpStatus.syncing;
      case 'failed':
        return OpStatus.failed;
      case 'confirmed':
        return OpStatus.confirmed;
      default:
        throw ArgumentError('Value "$name" cannot be converted to "OpStatus"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
