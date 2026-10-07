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
import 'condition_item.dart' as _i5ylibdu;

/// A condition checklist snapshot. Append-only: a later check adds a new row, so
/// the intake record is never overwritten.
abstract class ConditionReport
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ConditionReport._({
    this.id,
    required this.jobId,
    required this.clientOpId,
    required this.items,
    required this.recordedByUserId,
    required this.recordedByName,
    required this.capturedAt,
    required this.receivedAt,
  });

  factory ConditionReport({
    int? id,
    required int jobId,
    required _isc.UuidValue clientOpId,
    required List<_i5ylibdu.ConditionItem> items,
    required _isc.UuidValue recordedByUserId,
    required String recordedByName,
    required DateTime capturedAt,
    required DateTime receivedAt,
  }) = _ConditionReportImpl;

  factory ConditionReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return ConditionReport(
      id: jsonSerialization['id'] as int?,
      jobId: jsonSerialization['jobId'] as int,
      clientOpId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['clientOpId'],
      ),
      items: _i7z9lov6.Protocol().deserialize<List<_i5ylibdu.ConditionItem>>(
        jsonSerialization['items'],
      ),
      recordedByUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['recordedByUserId'],
      ),
      recordedByName: jsonSerialization['recordedByName'] as String,
      capturedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['capturedAt'],
      ),
      receivedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['receivedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int jobId;

  _isc.UuidValue clientOpId;

  List<_i5ylibdu.ConditionItem> items;

  _isc.UuidValue recordedByUserId;

  String recordedByName;

  /// Device clock when the technician saved it (may be offline).
  DateTime capturedAt;

  DateTime receivedAt;

  /// Returns a shallow copy of this [ConditionReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ConditionReport copyWith({
    int? id,
    int? jobId,
    _isc.UuidValue? clientOpId,
    List<_i5ylibdu.ConditionItem>? items,
    _isc.UuidValue? recordedByUserId,
    String? recordedByName,
    DateTime? capturedAt,
    DateTime? receivedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ConditionReport',
      if (id != null) 'id': id,
      'jobId': jobId,
      'clientOpId': clientOpId.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'recordedByUserId': recordedByUserId.toJson(),
      'recordedByName': recordedByName,
      'capturedAt': capturedAt.toJson(),
      'receivedAt': receivedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ConditionReport',
      if (id != null) 'id': id,
      'jobId': jobId,
      'clientOpId': clientOpId.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'recordedByUserId': recordedByUserId.toJson(),
      'recordedByName': recordedByName,
      'capturedAt': capturedAt.toJson(),
      'receivedAt': receivedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConditionReportImpl extends ConditionReport {
  _ConditionReportImpl({
    int? id,
    required int jobId,
    required _isc.UuidValue clientOpId,
    required List<_i5ylibdu.ConditionItem> items,
    required _isc.UuidValue recordedByUserId,
    required String recordedByName,
    required DateTime capturedAt,
    required DateTime receivedAt,
  }) : super._(
         id: id,
         jobId: jobId,
         clientOpId: clientOpId,
         items: items,
         recordedByUserId: recordedByUserId,
         recordedByName: recordedByName,
         capturedAt: capturedAt,
         receivedAt: receivedAt,
       );

  /// Returns a shallow copy of this [ConditionReport]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ConditionReport copyWith({
    Object? id = _Undefined,
    int? jobId,
    _isc.UuidValue? clientOpId,
    List<_i5ylibdu.ConditionItem>? items,
    _isc.UuidValue? recordedByUserId,
    String? recordedByName,
    DateTime? capturedAt,
    DateTime? receivedAt,
  }) {
    return ConditionReport(
      id: id is int? ? id : this.id,
      jobId: jobId ?? this.jobId,
      clientOpId: clientOpId ?? this.clientOpId,
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      recordedByUserId: recordedByUserId ?? this.recordedByUserId,
      recordedByName: recordedByName ?? this.recordedByName,
      capturedAt: capturedAt ?? this.capturedAt,
      receivedAt: receivedAt ?? this.receivedAt,
    );
  }
}
