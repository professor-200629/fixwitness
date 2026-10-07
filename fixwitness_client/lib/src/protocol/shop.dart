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

abstract class Shop
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Shop._({
    this.id,
    required this.name,
    String? currency,
    int? nextJobNumber,
    DateTime? createdAt,
  }) : currency = currency ?? 'INR',
       nextJobNumber = nextJobNumber ?? 1,
       createdAt = createdAt ?? DateTime.now();

  factory Shop({
    int? id,
    required String name,
    String? currency,
    int? nextJobNumber,
    DateTime? createdAt,
  }) = _ShopImpl;

  factory Shop.fromJson(Map<String, dynamic> jsonSerialization) {
    return Shop(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      currency: jsonSerialization['currency'] as String?,
      nextJobNumber: jsonSerialization['nextJobNumber'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  /// ISO 4217 code. All money is stored in integer minor units of this currency.
  String currency;

  int nextJobNumber;

  DateTime createdAt;

  /// Returns a shallow copy of this [Shop]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Shop copyWith({
    int? id,
    String? name,
    String? currency,
    int? nextJobNumber,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Shop',
      if (id != null) 'id': id,
      'name': name,
      'currency': currency,
      'nextJobNumber': nextJobNumber,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Shop',
      if (id != null) 'id': id,
      'name': name,
      'currency': currency,
      'nextJobNumber': nextJobNumber,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ShopImpl extends Shop {
  _ShopImpl({
    int? id,
    required String name,
    String? currency,
    int? nextJobNumber,
    DateTime? createdAt,
  }) : super._(
         id: id,
         name: name,
         currency: currency,
         nextJobNumber: nextJobNumber,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Shop]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Shop copyWith({
    Object? id = _Undefined,
    String? name,
    String? currency,
    int? nextJobNumber,
    DateTime? createdAt,
  }) {
    return Shop(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      currency: currency ?? this.currency,
      nextJobNumber: nextJobNumber ?? this.nextJobNumber,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
