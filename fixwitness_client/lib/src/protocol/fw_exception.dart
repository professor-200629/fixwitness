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
import 'fw_error_code.dart' as _i49jwhm1;

/// Every expected failure the server reports. `message` is written for the person
/// using the app; `code` lets the app react without parsing text.
abstract class FwException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  FwException._({
    required this.code,
    required this.message,
    this.attemptedVersion,
    this.currentVersion,
  });

  factory FwException({
    required _i49jwhm1.FwErrorCode code,
    required String message,
    int? attemptedVersion,
    int? currentVersion,
  }) = _FwExceptionImpl;

  factory FwException.fromJson(Map<String, dynamic> jsonSerialization) {
    return FwException(
      code: _i49jwhm1.FwErrorCode.fromJson(
        (jsonSerialization['code'] as String),
      ),
      message: jsonSerialization['message'] as String,
      attemptedVersion: jsonSerialization['attemptedVersion'] as int?,
      currentVersion: jsonSerialization['currentVersion'] as int?,
    );
  }

  _i49jwhm1.FwErrorCode code;

  String message;

  /// Set for estimateOutdated: the version the caller tried to act on.
  int? attemptedVersion;

  /// Set for estimateOutdated: the version that is current now.
  int? currentVersion;

  /// Returns a shallow copy of this [FwException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FwException copyWith({
    _i49jwhm1.FwErrorCode? code,
    String? message,
    int? attemptedVersion,
    int? currentVersion,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FwException',
      'code': code.toJson(),
      'message': message,
      if (attemptedVersion != null) 'attemptedVersion': attemptedVersion,
      if (currentVersion != null) 'currentVersion': currentVersion,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FwException',
      'code': code.toJson(),
      'message': message,
      if (attemptedVersion != null) 'attemptedVersion': attemptedVersion,
      if (currentVersion != null) 'currentVersion': currentVersion,
    };
  }

  @override
  String toString() {
    return 'FwException(code: $code, message: $message, attemptedVersion: $attemptedVersion, currentVersion: $currentVersion)';
  }
}

class _Undefined {}

class _FwExceptionImpl extends FwException {
  _FwExceptionImpl({
    required _i49jwhm1.FwErrorCode code,
    required String message,
    int? attemptedVersion,
    int? currentVersion,
  }) : super._(
         code: code,
         message: message,
         attemptedVersion: attemptedVersion,
         currentVersion: currentVersion,
       );

  /// Returns a shallow copy of this [FwException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FwException copyWith({
    _i49jwhm1.FwErrorCode? code,
    String? message,
    Object? attemptedVersion = _Undefined,
    Object? currentVersion = _Undefined,
  }) {
    return FwException(
      code: code ?? this.code,
      message: message ?? this.message,
      attemptedVersion: attemptedVersion is int?
          ? attemptedVersion
          : this.attemptedVersion,
      currentVersion: currentVersion is int?
          ? currentVersion
          : this.currentVersion,
    );
  }
}
