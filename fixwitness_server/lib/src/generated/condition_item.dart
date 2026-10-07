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
import 'condition_state.dart' as _ikr1mj9r;

abstract class ConditionItem
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ConditionItem._({
    required this.key,
    required this.label,
    required this.state,
    this.note,
  });

  factory ConditionItem({
    required String key,
    required String label,
    required _ikr1mj9r.ConditionState state,
    String? note,
  }) = _ConditionItemImpl;

  factory ConditionItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return ConditionItem(
      key: jsonSerialization['key'] as String,
      label: jsonSerialization['label'] as String,
      state: _ikr1mj9r.ConditionState.fromJson(
        (jsonSerialization['state'] as String),
      ),
      note: jsonSerialization['note'] as String?,
    );
  }

  String key;

  String label;

  _ikr1mj9r.ConditionState state;

  String? note;

  /// Returns a shallow copy of this [ConditionItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ConditionItem copyWith({
    String? key,
    String? label,
    _ikr1mj9r.ConditionState? state,
    String? note,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ConditionItem',
      'key': key,
      'label': label,
      'state': state.toJson(),
      if (note != null) 'note': note,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ConditionItem',
      'key': key,
      'label': label,
      'state': state.toJson(),
      if (note != null) 'note': note,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConditionItemImpl extends ConditionItem {
  _ConditionItemImpl({
    required String key,
    required String label,
    required _ikr1mj9r.ConditionState state,
    String? note,
  }) : super._(
         key: key,
         label: label,
         state: state,
         note: note,
       );

  /// Returns a shallow copy of this [ConditionItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ConditionItem copyWith({
    String? key,
    String? label,
    _ikr1mj9r.ConditionState? state,
    Object? note = _Undefined,
  }) {
    return ConditionItem(
      key: key ?? this.key,
      label: label ?? this.label,
      state: state ?? this.state,
      note: note is String? ? note : this.note,
    );
  }
}
