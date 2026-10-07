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

abstract class NewJobInput
    implements _is.SerializableModel, _is.ProtocolSerialization {
  NewJobInput._({
    required this.customerName,
    required this.customerPhone,
    required this.deviceMake,
    required this.deviceModel,
    this.deviceSerial,
    required this.reportedFault,
    this.accessories,
  });

  factory NewJobInput({
    required String customerName,
    required String customerPhone,
    required String deviceMake,
    required String deviceModel,
    String? deviceSerial,
    required String reportedFault,
    String? accessories,
  }) = _NewJobInputImpl;

  factory NewJobInput.fromJson(Map<String, dynamic> jsonSerialization) {
    return NewJobInput(
      customerName: jsonSerialization['customerName'] as String,
      customerPhone: jsonSerialization['customerPhone'] as String,
      deviceMake: jsonSerialization['deviceMake'] as String,
      deviceModel: jsonSerialization['deviceModel'] as String,
      deviceSerial: jsonSerialization['deviceSerial'] as String?,
      reportedFault: jsonSerialization['reportedFault'] as String,
      accessories: jsonSerialization['accessories'] as String?,
    );
  }

  String customerName;

  String customerPhone;

  String deviceMake;

  String deviceModel;

  String? deviceSerial;

  String reportedFault;

  String? accessories;

  /// Returns a shallow copy of this [NewJobInput]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  NewJobInput copyWith({
    String? customerName,
    String? customerPhone,
    String? deviceMake,
    String? deviceModel,
    String? deviceSerial,
    String? reportedFault,
    String? accessories,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NewJobInput',
      'customerName': customerName,
      'customerPhone': customerPhone,
      'deviceMake': deviceMake,
      'deviceModel': deviceModel,
      if (deviceSerial != null) 'deviceSerial': deviceSerial,
      'reportedFault': reportedFault,
      if (accessories != null) 'accessories': accessories,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'NewJobInput',
      'customerName': customerName,
      'customerPhone': customerPhone,
      'deviceMake': deviceMake,
      'deviceModel': deviceModel,
      if (deviceSerial != null) 'deviceSerial': deviceSerial,
      'reportedFault': reportedFault,
      if (accessories != null) 'accessories': accessories,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NewJobInputImpl extends NewJobInput {
  _NewJobInputImpl({
    required String customerName,
    required String customerPhone,
    required String deviceMake,
    required String deviceModel,
    String? deviceSerial,
    required String reportedFault,
    String? accessories,
  }) : super._(
         customerName: customerName,
         customerPhone: customerPhone,
         deviceMake: deviceMake,
         deviceModel: deviceModel,
         deviceSerial: deviceSerial,
         reportedFault: reportedFault,
         accessories: accessories,
       );

  /// Returns a shallow copy of this [NewJobInput]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  NewJobInput copyWith({
    String? customerName,
    String? customerPhone,
    String? deviceMake,
    String? deviceModel,
    Object? deviceSerial = _Undefined,
    String? reportedFault,
    Object? accessories = _Undefined,
  }) {
    return NewJobInput(
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      deviceMake: deviceMake ?? this.deviceMake,
      deviceModel: deviceModel ?? this.deviceModel,
      deviceSerial: deviceSerial is String? ? deviceSerial : this.deviceSerial,
      reportedFault: reportedFault ?? this.reportedFault,
      accessories: accessories is String? ? accessories : this.accessories,
    );
  }
}
