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

/// What work is authorized right now, derived on the server from estimates and
/// decisions so that no client can show unapproved work as authorized.
abstract class AuthorizationState
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AuthorizationState._({
    this.authorizedVersion,
    this.authorizedTotalMinor,
    this.latestVersion,
    this.latestTotalMinor,
    required this.pendingApproval,
    required this.revisionPending,
    required this.label,
  });

  factory AuthorizationState({
    int? authorizedVersion,
    int? authorizedTotalMinor,
    int? latestVersion,
    int? latestTotalMinor,
    required bool pendingApproval,
    required bool revisionPending,
    required String label,
  }) = _AuthorizationStateImpl;

  factory AuthorizationState.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuthorizationState(
      authorizedVersion: jsonSerialization['authorizedVersion'] as int?,
      authorizedTotalMinor: jsonSerialization['authorizedTotalMinor'] as int?,
      latestVersion: jsonSerialization['latestVersion'] as int?,
      latestTotalMinor: jsonSerialization['latestTotalMinor'] as int?,
      pendingApproval: _is.BoolJsonExtension.fromJson(
        jsonSerialization['pendingApproval'],
      ),
      revisionPending: _is.BoolJsonExtension.fromJson(
        jsonSerialization['revisionPending'],
      ),
      label: jsonSerialization['label'] as String,
    );
  }

  int? authorizedVersion;

  int? authorizedTotalMinor;

  int? latestVersion;

  int? latestTotalMinor;

  /// The latest issued version has no approval yet.
  bool pendingApproval;

  /// A revised version exists that changes work which was already approved.
  bool revisionPending;

  String label;

  /// Returns a shallow copy of this [AuthorizationState]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AuthorizationState copyWith({
    int? authorizedVersion,
    int? authorizedTotalMinor,
    int? latestVersion,
    int? latestTotalMinor,
    bool? pendingApproval,
    bool? revisionPending,
    String? label,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuthorizationState',
      if (authorizedVersion != null) 'authorizedVersion': authorizedVersion,
      if (authorizedTotalMinor != null)
        'authorizedTotalMinor': authorizedTotalMinor,
      if (latestVersion != null) 'latestVersion': latestVersion,
      if (latestTotalMinor != null) 'latestTotalMinor': latestTotalMinor,
      'pendingApproval': pendingApproval,
      'revisionPending': revisionPending,
      'label': label,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AuthorizationState',
      if (authorizedVersion != null) 'authorizedVersion': authorizedVersion,
      if (authorizedTotalMinor != null)
        'authorizedTotalMinor': authorizedTotalMinor,
      if (latestVersion != null) 'latestVersion': latestVersion,
      if (latestTotalMinor != null) 'latestTotalMinor': latestTotalMinor,
      'pendingApproval': pendingApproval,
      'revisionPending': revisionPending,
      'label': label,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuthorizationStateImpl extends AuthorizationState {
  _AuthorizationStateImpl({
    int? authorizedVersion,
    int? authorizedTotalMinor,
    int? latestVersion,
    int? latestTotalMinor,
    required bool pendingApproval,
    required bool revisionPending,
    required String label,
  }) : super._(
         authorizedVersion: authorizedVersion,
         authorizedTotalMinor: authorizedTotalMinor,
         latestVersion: latestVersion,
         latestTotalMinor: latestTotalMinor,
         pendingApproval: pendingApproval,
         revisionPending: revisionPending,
         label: label,
       );

  /// Returns a shallow copy of this [AuthorizationState]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AuthorizationState copyWith({
    Object? authorizedVersion = _Undefined,
    Object? authorizedTotalMinor = _Undefined,
    Object? latestVersion = _Undefined,
    Object? latestTotalMinor = _Undefined,
    bool? pendingApproval,
    bool? revisionPending,
    String? label,
  }) {
    return AuthorizationState(
      authorizedVersion: authorizedVersion is int?
          ? authorizedVersion
          : this.authorizedVersion,
      authorizedTotalMinor: authorizedTotalMinor is int?
          ? authorizedTotalMinor
          : this.authorizedTotalMinor,
      latestVersion: latestVersion is int? ? latestVersion : this.latestVersion,
      latestTotalMinor: latestTotalMinor is int?
          ? latestTotalMinor
          : this.latestTotalMinor,
      pendingApproval: pendingApproval ?? this.pendingApproval,
      revisionPending: revisionPending ?? this.revisionPending,
      label: label ?? this.label,
    );
  }
}
