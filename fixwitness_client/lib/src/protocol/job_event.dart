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
import 'actor_kind.dart' as _ijpkiimy;
import 'job_event_type.dart' as _iwt0hck5;

/// Append-only history. Written in the same transaction as the change it records.
abstract class JobEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  JobEvent._({
    this.id,
    required this.jobId,
    required this.seq,
    required this.type,
    required this.actorKind,
    required this.actorLabel,
    required this.summary,
    required this.customerVisible,
    this.estimateVersion,
    required this.occurredAt,
  });

  factory JobEvent({
    int? id,
    required int jobId,
    required int seq,
    required _iwt0hck5.JobEventType type,
    required _ijpkiimy.ActorKind actorKind,
    required String actorLabel,
    required String summary,
    required bool customerVisible,
    int? estimateVersion,
    required DateTime occurredAt,
  }) = _JobEventImpl;

  factory JobEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobEvent(
      id: jsonSerialization['id'] as int?,
      jobId: jsonSerialization['jobId'] as int,
      seq: jsonSerialization['seq'] as int,
      type: _iwt0hck5.JobEventType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      actorKind: _ijpkiimy.ActorKind.fromJson(
        (jsonSerialization['actorKind'] as String),
      ),
      actorLabel: jsonSerialization['actorLabel'] as String,
      summary: jsonSerialization['summary'] as String,
      customerVisible: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['customerVisible'],
      ),
      estimateVersion: jsonSerialization['estimateVersion'] as int?,
      occurredAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int jobId;

  int seq;

  _iwt0hck5.JobEventType type;

  _ijpkiimy.ActorKind actorKind;

  String actorLabel;

  String summary;

  bool customerVisible;

  int? estimateVersion;

  DateTime occurredAt;

  /// Returns a shallow copy of this [JobEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  JobEvent copyWith({
    int? id,
    int? jobId,
    int? seq,
    _iwt0hck5.JobEventType? type,
    _ijpkiimy.ActorKind? actorKind,
    String? actorLabel,
    String? summary,
    bool? customerVisible,
    int? estimateVersion,
    DateTime? occurredAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobEvent',
      if (id != null) 'id': id,
      'jobId': jobId,
      'seq': seq,
      'type': type.toJson(),
      'actorKind': actorKind.toJson(),
      'actorLabel': actorLabel,
      'summary': summary,
      'customerVisible': customerVisible,
      if (estimateVersion != null) 'estimateVersion': estimateVersion,
      'occurredAt': occurredAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobEvent',
      if (id != null) 'id': id,
      'jobId': jobId,
      'seq': seq,
      'type': type.toJson(),
      'actorKind': actorKind.toJson(),
      'actorLabel': actorLabel,
      'summary': summary,
      'customerVisible': customerVisible,
      if (estimateVersion != null) 'estimateVersion': estimateVersion,
      'occurredAt': occurredAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobEventImpl extends JobEvent {
  _JobEventImpl({
    int? id,
    required int jobId,
    required int seq,
    required _iwt0hck5.JobEventType type,
    required _ijpkiimy.ActorKind actorKind,
    required String actorLabel,
    required String summary,
    required bool customerVisible,
    int? estimateVersion,
    required DateTime occurredAt,
  }) : super._(
         id: id,
         jobId: jobId,
         seq: seq,
         type: type,
         actorKind: actorKind,
         actorLabel: actorLabel,
         summary: summary,
         customerVisible: customerVisible,
         estimateVersion: estimateVersion,
         occurredAt: occurredAt,
       );

  /// Returns a shallow copy of this [JobEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  JobEvent copyWith({
    Object? id = _Undefined,
    int? jobId,
    int? seq,
    _iwt0hck5.JobEventType? type,
    _ijpkiimy.ActorKind? actorKind,
    String? actorLabel,
    String? summary,
    bool? customerVisible,
    Object? estimateVersion = _Undefined,
    DateTime? occurredAt,
  }) {
    return JobEvent(
      id: id is int? ? id : this.id,
      jobId: jobId ?? this.jobId,
      seq: seq ?? this.seq,
      type: type ?? this.type,
      actorKind: actorKind ?? this.actorKind,
      actorLabel: actorLabel ?? this.actorLabel,
      summary: summary ?? this.summary,
      customerVisible: customerVisible ?? this.customerVisible,
      estimateVersion: estimateVersion is int?
          ? estimateVersion
          : this.estimateVersion,
      occurredAt: occurredAt ?? this.occurredAt,
    );
  }
}
