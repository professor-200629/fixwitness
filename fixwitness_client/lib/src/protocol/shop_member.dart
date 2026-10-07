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
import 'shop_role.dart' as _inr72q68;

abstract class ShopMember
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ShopMember._({
    this.id,
    required this.shopId,
    required this.authUserId,
    required this.displayName,
    required this.role,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ShopMember({
    int? id,
    required int shopId,
    required _isc.UuidValue authUserId,
    required String displayName,
    required _inr72q68.ShopRole role,
    DateTime? createdAt,
  }) = _ShopMemberImpl;

  factory ShopMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShopMember(
      id: jsonSerialization['id'] as int?,
      shopId: jsonSerialization['shopId'] as int,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      displayName: jsonSerialization['displayName'] as String,
      role: _inr72q68.ShopRole.fromJson((jsonSerialization['role'] as String)),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int shopId;

  _isc.UuidValue authUserId;

  String displayName;

  _inr72q68.ShopRole role;

  DateTime createdAt;

  /// Returns a shallow copy of this [ShopMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ShopMember copyWith({
    int? id,
    int? shopId,
    _isc.UuidValue? authUserId,
    String? displayName,
    _inr72q68.ShopRole? role,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ShopMember',
      if (id != null) 'id': id,
      'shopId': shopId,
      'authUserId': authUserId.toJson(),
      'displayName': displayName,
      'role': role.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ShopMember',
      if (id != null) 'id': id,
      'shopId': shopId,
      'authUserId': authUserId.toJson(),
      'displayName': displayName,
      'role': role.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ShopMemberImpl extends ShopMember {
  _ShopMemberImpl({
    int? id,
    required int shopId,
    required _isc.UuidValue authUserId,
    required String displayName,
    required _inr72q68.ShopRole role,
    DateTime? createdAt,
  }) : super._(
         id: id,
         shopId: shopId,
         authUserId: authUserId,
         displayName: displayName,
         role: role,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ShopMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ShopMember copyWith({
    Object? id = _Undefined,
    int? shopId,
    _isc.UuidValue? authUserId,
    String? displayName,
    _inr72q68.ShopRole? role,
    DateTime? createdAt,
  }) {
    return ShopMember(
      id: id is int? ? id : this.id,
      shopId: shopId ?? this.shopId,
      authUserId: authUserId ?? this.authUserId,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
