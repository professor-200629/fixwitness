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

/// A customer review link for exactly one job. Only the SHA-256 of the token is
/// stored; the token itself is returned once, when the link is created.
abstract class CustomerLink
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CustomerLink._({
    this.id,
    required this.jobId,
    required this.createdByUserId,
    required this.createdAt,
    required this.expiresAt,
    this.revokedAt,
    this.lastOpenedAt,
  });

  factory CustomerLink({
    int? id,
    required int jobId,
    required _isc.UuidValue createdByUserId,
    required DateTime createdAt,
    required DateTime expiresAt,
    DateTime? revokedAt,
    DateTime? lastOpenedAt,
  }) = _CustomerLinkImpl;

  factory CustomerLink.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomerLink(
      id: jsonSerialization['id'] as int?,
      jobId: jsonSerialization['jobId'] as int,
      createdByUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['createdByUserId'],
      ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      expiresAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      revokedAt: jsonSerialization['revokedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['revokedAt']),
      lastOpenedAt: jsonSerialization['lastOpenedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastOpenedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int jobId;

  _isc.UuidValue createdByUserId;

  DateTime createdAt;

  DateTime expiresAt;

  DateTime? revokedAt;

  DateTime? lastOpenedAt;

  /// Returns a shallow copy of this [CustomerLink]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CustomerLink copyWith({
    int? id,
    int? jobId,
    _isc.UuidValue? createdByUserId,
    DateTime? createdAt,
    DateTime? expiresAt,
    DateTime? revokedAt,
    DateTime? lastOpenedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerLink',
      if (id != null) 'id': id,
      'jobId': jobId,
      'createdByUserId': createdByUserId.toJson(),
      'createdAt': createdAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
      if (lastOpenedAt != null) 'lastOpenedAt': lastOpenedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerLink',
      if (id != null) 'id': id,
      'jobId': jobId,
      'createdByUserId': createdByUserId.toJson(),
      'createdAt': createdAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
      if (lastOpenedAt != null) 'lastOpenedAt': lastOpenedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomerLinkImpl extends CustomerLink {
  _CustomerLinkImpl({
    int? id,
    required int jobId,
    required _isc.UuidValue createdByUserId,
    required DateTime createdAt,
    required DateTime expiresAt,
    DateTime? revokedAt,
    DateTime? lastOpenedAt,
  }) : super._(
         id: id,
         jobId: jobId,
         createdByUserId: createdByUserId,
         createdAt: createdAt,
         expiresAt: expiresAt,
         revokedAt: revokedAt,
         lastOpenedAt: lastOpenedAt,
       );

  /// Returns a shallow copy of this [CustomerLink]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CustomerLink copyWith({
    Object? id = _Undefined,
    int? jobId,
    _isc.UuidValue? createdByUserId,
    DateTime? createdAt,
    DateTime? expiresAt,
    Object? revokedAt = _Undefined,
    Object? lastOpenedAt = _Undefined,
  }) {
    return CustomerLink(
      id: id is int? ? id : this.id,
      jobId: jobId ?? this.jobId,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      revokedAt: revokedAt is DateTime? ? revokedAt : this.revokedAt,
      lastOpenedAt: lastOpenedAt is DateTime?
          ? lastOpenedAt
          : this.lastOpenedAt,
    );
  }
}
