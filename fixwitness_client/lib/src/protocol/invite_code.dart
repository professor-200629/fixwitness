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

/// Returned once to the owner who created an invite.
abstract class InviteCode
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  InviteCode._({
    required this.code,
    required this.expiresAt,
  });

  factory InviteCode({
    required String code,
    required DateTime expiresAt,
  }) = _InviteCodeImpl;

  factory InviteCode.fromJson(Map<String, dynamic> jsonSerialization) {
    return InviteCode(
      code: jsonSerialization['code'] as String,
      expiresAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
    );
  }

  String code;

  DateTime expiresAt;

  /// Returns a shallow copy of this [InviteCode]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  InviteCode copyWith({
    String? code,
    DateTime? expiresAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InviteCode',
      'code': code,
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InviteCode',
      'code': code,
      'expiresAt': expiresAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _InviteCodeImpl extends InviteCode {
  _InviteCodeImpl({
    required String code,
    required DateTime expiresAt,
  }) : super._(
         code: code,
         expiresAt: expiresAt,
       );

  /// Returns a shallow copy of this [InviteCode]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  InviteCode copyWith({
    String? code,
    DateTime? expiresAt,
  }) {
    return InviteCode(
      code: code ?? this.code,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}
