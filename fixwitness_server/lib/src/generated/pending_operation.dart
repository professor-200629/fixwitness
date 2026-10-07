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
import 'op_kind.dart' as _isgnykvt;
import 'op_status.dart' as _icbsweww;

/// Durable device-side queue of work captured by a technician. Survives restarts.
abstract class PendingOperation
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PendingOperation._({
    this.id,
    required this.opId,
    required this.kind,
    required this.status,
    this.serverJobId,
    this.parentOpId,
    required this.payloadJson,
    this.localFilePath,
    bool? uploadDone,
    int? attempts,
    this.lastError,
    this.resultId,
    required this.createdAt,
    required this.updatedAt,
  }) : uploadDone = uploadDone ?? false,
       attempts = attempts ?? 0;

  factory PendingOperation({
    int? id,
    required _is.UuidValue opId,
    required _isgnykvt.OpKind kind,
    required _icbsweww.OpStatus status,
    int? serverJobId,
    _is.UuidValue? parentOpId,
    required String payloadJson,
    String? localFilePath,
    bool? uploadDone,
    int? attempts,
    String? lastError,
    int? resultId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PendingOperationImpl;

  factory PendingOperation.fromJson(Map<String, dynamic> jsonSerialization) {
    return PendingOperation(
      id: jsonSerialization['id'] as int?,
      opId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['opId']),
      kind: _isgnykvt.OpKind.fromJson((jsonSerialization['kind'] as String)),
      status: _icbsweww.OpStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      serverJobId: jsonSerialization['serverJobId'] as int?,
      parentOpId: jsonSerialization['parentOpId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['parentOpId'],
            ),
      payloadJson: jsonSerialization['payloadJson'] as String,
      localFilePath: jsonSerialization['localFilePath'] as String?,
      uploadDone: jsonSerialization['uploadDone'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['uploadDone']),
      attempts: jsonSerialization['attempts'] as int?,
      lastError: jsonSerialization['lastError'] as String?,
      resultId: jsonSerialization['resultId'] as int?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _is.UuidValue opId;

  _isgnykvt.OpKind kind;

  _icbsweww.OpStatus status;

  /// Server job id, or null while the job itself is still queued.
  int? serverJobId;

  /// For work on a job created offline: the opId of that createJob operation.
  _is.UuidValue? parentOpId;

  String payloadJson;

  /// Photo bytes saved on the device until the server confirms them.
  String? localFilePath;

  /// True once the photo bytes are on the server (metadata may still be missing).
  bool uploadDone;

  int attempts;

  String? lastError;

  /// Id the server returned once confirmed (job, note, report, or photo id).
  int? resultId;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [PendingOperation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PendingOperation copyWith({
    int? id,
    _is.UuidValue? opId,
    _isgnykvt.OpKind? kind,
    _icbsweww.OpStatus? status,
    int? serverJobId,
    _is.UuidValue? parentOpId,
    String? payloadJson,
    String? localFilePath,
    bool? uploadDone,
    int? attempts,
    String? lastError,
    int? resultId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PendingOperation',
      if (id != null) 'id': id,
      'opId': opId.toJson(),
      'kind': kind.toJson(),
      'status': status.toJson(),
      if (serverJobId != null) 'serverJobId': serverJobId,
      if (parentOpId != null) 'parentOpId': parentOpId?.toJson(),
      'payloadJson': payloadJson,
      if (localFilePath != null) 'localFilePath': localFilePath,
      'uploadDone': uploadDone,
      'attempts': attempts,
      if (lastError != null) 'lastError': lastError,
      if (resultId != null) 'resultId': resultId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PendingOperation',
      if (id != null) 'id': id,
      'opId': opId.toJson(),
      'kind': kind.toJson(),
      'status': status.toJson(),
      if (serverJobId != null) 'serverJobId': serverJobId,
      if (parentOpId != null) 'parentOpId': parentOpId?.toJson(),
      'payloadJson': payloadJson,
      if (localFilePath != null) 'localFilePath': localFilePath,
      'uploadDone': uploadDone,
      'attempts': attempts,
      if (lastError != null) 'lastError': lastError,
      if (resultId != null) 'resultId': resultId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PendingOperationImpl extends PendingOperation {
  _PendingOperationImpl({
    int? id,
    required _is.UuidValue opId,
    required _isgnykvt.OpKind kind,
    required _icbsweww.OpStatus status,
    int? serverJobId,
    _is.UuidValue? parentOpId,
    required String payloadJson,
    String? localFilePath,
    bool? uploadDone,
    int? attempts,
    String? lastError,
    int? resultId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         opId: opId,
         kind: kind,
         status: status,
         serverJobId: serverJobId,
         parentOpId: parentOpId,
         payloadJson: payloadJson,
         localFilePath: localFilePath,
         uploadDone: uploadDone,
         attempts: attempts,
         lastError: lastError,
         resultId: resultId,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [PendingOperation]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PendingOperation copyWith({
    Object? id = _Undefined,
    _is.UuidValue? opId,
    _isgnykvt.OpKind? kind,
    _icbsweww.OpStatus? status,
    Object? serverJobId = _Undefined,
    Object? parentOpId = _Undefined,
    String? payloadJson,
    Object? localFilePath = _Undefined,
    bool? uploadDone,
    int? attempts,
    Object? lastError = _Undefined,
    Object? resultId = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PendingOperation(
      id: id is int? ? id : this.id,
      opId: opId ?? this.opId,
      kind: kind ?? this.kind,
      status: status ?? this.status,
      serverJobId: serverJobId is int? ? serverJobId : this.serverJobId,
      parentOpId: parentOpId is _is.UuidValue? ? parentOpId : this.parentOpId,
      payloadJson: payloadJson ?? this.payloadJson,
      localFilePath: localFilePath is String?
          ? localFilePath
          : this.localFilePath,
      uploadDone: uploadDone ?? this.uploadDone,
      attempts: attempts ?? this.attempts,
      lastError: lastError is String? ? lastError : this.lastError,
      resultId: resultId is int? ? resultId : this.resultId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
