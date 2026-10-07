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
import 'line_kind.dart' as _ihrvi1k4;

abstract class EstimateLine
    implements _is.SerializableModel, _is.ProtocolSerialization {
  EstimateLine._({
    required this.kind,
    required this.description,
    required this.quantity,
    required this.unitPriceMinor,
  });

  factory EstimateLine({
    required _ihrvi1k4.LineKind kind,
    required String description,
    required int quantity,
    required int unitPriceMinor,
  }) = _EstimateLineImpl;

  factory EstimateLine.fromJson(Map<String, dynamic> jsonSerialization) {
    return EstimateLine(
      kind: _ihrvi1k4.LineKind.fromJson((jsonSerialization['kind'] as String)),
      description: jsonSerialization['description'] as String,
      quantity: jsonSerialization['quantity'] as int,
      unitPriceMinor: jsonSerialization['unitPriceMinor'] as int,
    );
  }

  _ihrvi1k4.LineKind kind;

  String description;

  int quantity;

  /// Integer minor units (paise for INR).
  int unitPriceMinor;

  /// Returns a shallow copy of this [EstimateLine]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EstimateLine copyWith({
    _ihrvi1k4.LineKind? kind,
    String? description,
    int? quantity,
    int? unitPriceMinor,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EstimateLine',
      'kind': kind.toJson(),
      'description': description,
      'quantity': quantity,
      'unitPriceMinor': unitPriceMinor,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EstimateLine',
      'kind': kind.toJson(),
      'description': description,
      'quantity': quantity,
      'unitPriceMinor': unitPriceMinor,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _EstimateLineImpl extends EstimateLine {
  _EstimateLineImpl({
    required _ihrvi1k4.LineKind kind,
    required String description,
    required int quantity,
    required int unitPriceMinor,
  }) : super._(
         kind: kind,
         description: description,
         quantity: quantity,
         unitPriceMinor: unitPriceMinor,
       );

  /// Returns a shallow copy of this [EstimateLine]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EstimateLine copyWith({
    _ihrvi1k4.LineKind? kind,
    String? description,
    int? quantity,
    int? unitPriceMinor,
  }) {
    return EstimateLine(
      kind: kind ?? this.kind,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPriceMinor: unitPriceMinor ?? this.unitPriceMinor,
    );
  }
}
