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

abstract class JobNote
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  JobNote._({
    this.id,
    required this.jobId,
    required this.clientOpId,
    required this.text,
    bool? customerVisible,
    required this.authorUserId,
    required this.authorName,
    required this.writtenAt,
    required this.receivedAt,
  }) : customerVisible = customerVisible ?? false;

  factory JobNote({
    int? id,
    required int jobId,
    required _isc.UuidValue clientOpId,
    required String text,
    bool? customerVisible,
    required _isc.UuidValue authorUserId,
    required String authorName,
    required DateTime writtenAt,
    required DateTime receivedAt,
  }) = _JobNoteImpl;

  factory JobNote.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobNote(
      id: jsonSerialization['id'] as int?,
      jobId: jsonSerialization['jobId'] as int,
      clientOpId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['clientOpId'],
      ),
      text: jsonSerialization['text'] as String,
      customerVisible: jsonSerialization['customerVisible'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['customerVisible'],
            ),
      authorUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authorUserId'],
      ),
      authorName: jsonSerialization['authorName'] as String,
      writtenAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['writtenAt'],
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

  String text;

  bool customerVisible;

  _isc.UuidValue authorUserId;

  String authorName;

  /// Device clock when written (may be offline).
  DateTime writtenAt;

  DateTime receivedAt;

  /// Returns a shallow copy of this [JobNote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  JobNote copyWith({
    int? id,
    int? jobId,
    _isc.UuidValue? clientOpId,
    String? text,
    bool? customerVisible,
    _isc.UuidValue? authorUserId,
    String? authorName,
    DateTime? writtenAt,
    DateTime? receivedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobNote',
      if (id != null) 'id': id,
      'jobId': jobId,
      'clientOpId': clientOpId.toJson(),
      'text': text,
      'customerVisible': customerVisible,
      'authorUserId': authorUserId.toJson(),
      'authorName': authorName,
      'writtenAt': writtenAt.toJson(),
      'receivedAt': receivedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobNote',
      if (id != null) 'id': id,
      'jobId': jobId,
      'clientOpId': clientOpId.toJson(),
      'text': text,
      'customerVisible': customerVisible,
      'authorUserId': authorUserId.toJson(),
      'authorName': authorName,
      'writtenAt': writtenAt.toJson(),
      'receivedAt': receivedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobNoteImpl extends JobNote {
  _JobNoteImpl({
    int? id,
    required int jobId,
    required _isc.UuidValue clientOpId,
    required String text,
    bool? customerVisible,
    required _isc.UuidValue authorUserId,
    required String authorName,
    required DateTime writtenAt,
    required DateTime receivedAt,
  }) : super._(
         id: id,
         jobId: jobId,
         clientOpId: clientOpId,
         text: text,
         customerVisible: customerVisible,
         authorUserId: authorUserId,
         authorName: authorName,
         writtenAt: writtenAt,
         receivedAt: receivedAt,
       );

  /// Returns a shallow copy of this [JobNote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  JobNote copyWith({
    Object? id = _Undefined,
    int? jobId,
    _isc.UuidValue? clientOpId,
    String? text,
    bool? customerVisible,
    _isc.UuidValue? authorUserId,
    String? authorName,
    DateTime? writtenAt,
    DateTime? receivedAt,
  }) {
    return JobNote(
      id: id is int? ? id : this.id,
      jobId: jobId ?? this.jobId,
      clientOpId: clientOpId ?? this.clientOpId,
      text: text ?? this.text,
      customerVisible: customerVisible ?? this.customerVisible,
      authorUserId: authorUserId ?? this.authorUserId,
      authorName: authorName ?? this.authorName,
      writtenAt: writtenAt ?? this.writtenAt,
      receivedAt: receivedAt ?? this.receivedAt,
    );
  }
}
