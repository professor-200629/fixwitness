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
import 'package:fixwitness_client/src/protocol/protocol.dart' as _i7z9lov6;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'shop.dart' as _isgf2ncs;
import 'shop_member.dart' as _ip7etvmn;

/// Who the signed-in user is inside FixWitness.
abstract class ShopContext
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ShopContext._({
    required this.shop,
    required this.member,
  });

  factory ShopContext({
    required _isgf2ncs.Shop shop,
    required _ip7etvmn.ShopMember member,
  }) = _ShopContextImpl;

  factory ShopContext.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShopContext(
      shop: _i7z9lov6.Protocol().deserialize<_isgf2ncs.Shop>(
        jsonSerialization['shop'],
      ),
      member: _i7z9lov6.Protocol().deserialize<_ip7etvmn.ShopMember>(
        jsonSerialization['member'],
      ),
    );
  }

  _isgf2ncs.Shop shop;

  _ip7etvmn.ShopMember member;

  /// Returns a shallow copy of this [ShopContext]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ShopContext copyWith({
    _isgf2ncs.Shop? shop,
    _ip7etvmn.ShopMember? member,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ShopContext',
      'shop': shop.toJson(),
      'member': member.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ShopContext',
      'shop': shop.toJsonForProtocol(),
      'member': member.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _ShopContextImpl extends ShopContext {
  _ShopContextImpl({
    required _isgf2ncs.Shop shop,
    required _ip7etvmn.ShopMember member,
  }) : super._(
         shop: shop,
         member: member,
       );

  /// Returns a shallow copy of this [ShopContext]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ShopContext copyWith({
    _isgf2ncs.Shop? shop,
    _ip7etvmn.ShopMember? member,
  }) {
    return ShopContext(
      shop: shop ?? this.shop.copyWith(),
      member: member ?? this.member.copyWith(),
    );
  }
}
