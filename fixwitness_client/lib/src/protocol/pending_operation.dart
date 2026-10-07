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
import 'package:serverpod_database/serverpod_database.dart' as _isd;
import 'op_kind.dart' as _isgnykvt;
import 'op_status.dart' as _icbsweww;

/// Durable device-side queue of work captured by a technician. Survives restarts.
abstract class PendingOperation
    implements _isd.TableRow<int?>, _isc.ProtocolSerialization {
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
    required _isc.UuidValue opId,
    required _isgnykvt.OpKind kind,
    required _icbsweww.OpStatus status,
    int? serverJobId,
    _isc.UuidValue? parentOpId,
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
      opId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['opId']),
      kind: _isgnykvt.OpKind.fromJson((jsonSerialization['kind'] as String)),
      status: _icbsweww.OpStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      serverJobId: jsonSerialization['serverJobId'] as int?,
      parentOpId: jsonSerialization['parentOpId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['parentOpId'],
            ),
      payloadJson: jsonSerialization['payloadJson'] as String,
      localFilePath: jsonSerialization['localFilePath'] as String?,
      uploadDone: jsonSerialization['uploadDone'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['uploadDone']),
      attempts: jsonSerialization['attempts'] as int?,
      lastError: jsonSerialization['lastError'] as String?,
      resultId: jsonSerialization['resultId'] as int?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = PendingOperationTable();

  static const db = PendingOperationRepository._();

  @override
  int? id;

  _isc.UuidValue opId;

  _isgnykvt.OpKind kind;

  _icbsweww.OpStatus status;

  /// Server job id, or null while the job itself is still queued.
  int? serverJobId;

  /// For work on a job created offline: the opId of that createJob operation.
  _isc.UuidValue? parentOpId;

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

  @override
  _isd.Table<int?> get table => t;

  /// Returns a shallow copy of this [PendingOperation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PendingOperation copyWith({
    int? id,
    _isc.UuidValue? opId,
    _isgnykvt.OpKind? kind,
    _icbsweww.OpStatus? status,
    int? serverJobId,
    _isc.UuidValue? parentOpId,
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

  static PendingOperationInclude include() {
    return PendingOperationInclude._();
  }

  static PendingOperationIncludeList includeList({
    _isd.WhereExpressionBuilder<PendingOperationTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<PendingOperationTable>? orderBy,
    _isd.OrderByListBuilder<PendingOperationTable>? orderByList,
    PendingOperationInclude? include,
  }) {
    return PendingOperationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PendingOperation.t),
      orderByList: orderByList?.call(PendingOperation.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PendingOperationImpl extends PendingOperation {
  _PendingOperationImpl({
    int? id,
    required _isc.UuidValue opId,
    required _isgnykvt.OpKind kind,
    required _icbsweww.OpStatus status,
    int? serverJobId,
    _isc.UuidValue? parentOpId,
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
  @_isc.useResult
  @override
  PendingOperation copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? opId,
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
      parentOpId: parentOpId is _isc.UuidValue? ? parentOpId : this.parentOpId,
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

class PendingOperationUpdateTable
    extends _isd.UpdateTable<PendingOperationTable> {
  PendingOperationUpdateTable(super.table);

  _isd.ColumnValue<_isc.UuidValue, _isc.UuidValue> opId(_isc.UuidValue value) =>
      _isd.ColumnValue(
        table.opId,
        value,
      );

  _isd.ColumnValue<_isgnykvt.OpKind, _isgnykvt.OpKind> kind(
    _isgnykvt.OpKind value,
  ) => _isd.ColumnValue(
    table.kind,
    value,
  );

  _isd.ColumnValue<_icbsweww.OpStatus, _icbsweww.OpStatus> status(
    _icbsweww.OpStatus value,
  ) => _isd.ColumnValue(
    table.status,
    value,
  );

  _isd.ColumnValue<int, int> serverJobId(int? value) => _isd.ColumnValue(
    table.serverJobId,
    value,
  );

  _isd.ColumnValue<_isc.UuidValue, _isc.UuidValue> parentOpId(
    _isc.UuidValue? value,
  ) => _isd.ColumnValue(
    table.parentOpId,
    value,
  );

  _isd.ColumnValue<String, String> payloadJson(String value) =>
      _isd.ColumnValue(
        table.payloadJson,
        value,
      );

  _isd.ColumnValue<String, String> localFilePath(String? value) =>
      _isd.ColumnValue(
        table.localFilePath,
        value,
      );

  _isd.ColumnValue<bool, bool> uploadDone(bool value) => _isd.ColumnValue(
    table.uploadDone,
    value,
  );

  _isd.ColumnValue<int, int> attempts(int value) => _isd.ColumnValue(
    table.attempts,
    value,
  );

  _isd.ColumnValue<String, String> lastError(String? value) => _isd.ColumnValue(
    table.lastError,
    value,
  );

  _isd.ColumnValue<int, int> resultId(int? value) => _isd.ColumnValue(
    table.resultId,
    value,
  );

  _isd.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _isd.ColumnValue(
        table.createdAt,
        value,
      );

  _isd.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _isd.ColumnValue(
        table.updatedAt,
        value,
      );
}

class PendingOperationTable extends _isd.Table<int?> {
  PendingOperationTable({super.tableRelation})
    : super(tableName: 'pending_operation') {
    updateTable = PendingOperationUpdateTable(this);
    opId = _isd.ColumnUuid(
      'opId',
      this,
    );
    kind = _isd.ColumnEnum(
      'kind',
      this,
      _isd.EnumSerialization.byName,
    );
    status = _isd.ColumnEnum(
      'status',
      this,
      _isd.EnumSerialization.byName,
    );
    serverJobId = _isd.ColumnInt(
      'serverJobId',
      this,
    );
    parentOpId = _isd.ColumnUuid(
      'parentOpId',
      this,
    );
    payloadJson = _isd.ColumnString(
      'payloadJson',
      this,
    );
    localFilePath = _isd.ColumnString(
      'localFilePath',
      this,
    );
    uploadDone = _isd.ColumnBool(
      'uploadDone',
      this,
      hasDefault: true,
    );
    attempts = _isd.ColumnInt(
      'attempts',
      this,
      hasDefault: true,
    );
    lastError = _isd.ColumnString(
      'lastError',
      this,
    );
    resultId = _isd.ColumnInt(
      'resultId',
      this,
    );
    createdAt = _isd.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _isd.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final PendingOperationUpdateTable updateTable;

  late final _isd.ColumnUuid opId;

  late final _isd.ColumnEnum<_isgnykvt.OpKind> kind;

  late final _isd.ColumnEnum<_icbsweww.OpStatus> status;

  /// Server job id, or null while the job itself is still queued.
  late final _isd.ColumnInt serverJobId;

  /// For work on a job created offline: the opId of that createJob operation.
  late final _isd.ColumnUuid parentOpId;

  late final _isd.ColumnString payloadJson;

  /// Photo bytes saved on the device until the server confirms them.
  late final _isd.ColumnString localFilePath;

  /// True once the photo bytes are on the server (metadata may still be missing).
  late final _isd.ColumnBool uploadDone;

  late final _isd.ColumnInt attempts;

  late final _isd.ColumnString lastError;

  /// Id the server returned once confirmed (job, note, report, or photo id).
  late final _isd.ColumnInt resultId;

  late final _isd.ColumnDateTime createdAt;

  late final _isd.ColumnDateTime updatedAt;

  @override
  List<_isd.Column> get columns => [
    id,
    opId,
    kind,
    status,
    serverJobId,
    parentOpId,
    payloadJson,
    localFilePath,
    uploadDone,
    attempts,
    lastError,
    resultId,
    createdAt,
    updatedAt,
  ];
}

class PendingOperationInclude extends _isd.IncludeObject {
  PendingOperationInclude._();

  @override
  Map<String, _isd.Include?> get includes => {};

  @override
  _isd.Table<int?> get table => PendingOperation.t;
}

class PendingOperationIncludeList extends _isd.IncludeList {
  PendingOperationIncludeList._({
    _isd.WhereExpressionBuilder<PendingOperationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PendingOperation.t);
  }

  @override
  Map<String, _isd.Include?> get includes => include?.includes ?? {};

  @override
  _isd.Table<int?> get table => PendingOperation.t;
}

class PendingOperationRepository {
  const PendingOperationRepository._();

  /// Returns a list of [PendingOperation]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<PendingOperation>> find(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<PendingOperationTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<PendingOperationTable>? orderBy,
    _isd.OrderByListBuilder<PendingOperationTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PendingOperation>(
      where: where?.call(PendingOperation.t),
      orderBy: orderBy?.call(PendingOperation.t),
      orderByList: orderByList?.call(PendingOperation.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PendingOperation] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<PendingOperation?> findFirstRow(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<PendingOperationTable>? where,
    int? offset,
    _isd.OrderByBuilder<PendingOperationTable>? orderBy,
    _isd.OrderByListBuilder<PendingOperationTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PendingOperation>(
      where: where?.call(PendingOperation.t),
      orderBy: orderBy?.call(PendingOperation.t),
      orderByList: orderByList?.call(PendingOperation.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PendingOperation] by its [id] or null if no such row exists.
  Future<PendingOperation?> findById(
    _isd.DatabaseSession session,
    int id, {
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PendingOperation>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PendingOperation]s in the list and returns the inserted rows.
  ///
  /// The returned [PendingOperation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PendingOperation>> insert(
    _isd.DatabaseSession session,
    List<PendingOperation> rows, {
    _isd.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PendingOperation>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PendingOperation] and returns the inserted row.
  ///
  /// The returned [PendingOperation] will have its `id` field set.
  Future<PendingOperation> insertRow(
    _isd.DatabaseSession session,
    PendingOperation row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.insertRow<PendingOperation>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PendingOperation]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [PendingOperation]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PendingOperation>> upsert(
    _isd.DatabaseSession session,
    List<PendingOperation> rows, {
    required _isd.ColumnSelections<PendingOperationTable> conflictColumns,
    _isd.ColumnSelections<PendingOperationTable>? updateColumns,
    _isd.WhereExpressionBuilder<PendingOperationTable>? updateWhere,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PendingOperation>(
      rows,
      conflictColumns: conflictColumns(PendingOperation.t),
      updateColumns: updateColumns?.call(PendingOperation.t),
      updateWhere: updateWhere?.call(PendingOperation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PendingOperation] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [PendingOperation] will have its `id` field set.
  Future<PendingOperation?> upsertRow(
    _isd.DatabaseSession session,
    PendingOperation row, {
    required _isd.ColumnSelections<PendingOperationTable> conflictColumns,
    _isd.ColumnSelections<PendingOperationTable>? updateColumns,
    _isd.WhereExpressionBuilder<PendingOperationTable>? updateWhere,
    _isd.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PendingOperation>(
      row,
      conflictColumns: conflictColumns(PendingOperation.t),
      updateColumns: updateColumns?.call(PendingOperation.t),
      updateWhere: updateWhere?.call(PendingOperation.t),
      transaction: transaction,
    );
  }

  /// Updates all [PendingOperation]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PendingOperation>> update(
    _isd.DatabaseSession session,
    List<PendingOperation> rows, {
    _isd.ColumnSelections<PendingOperationTable>? columns,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PendingOperation>(
      rows,
      columns: columns?.call(PendingOperation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PendingOperation]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PendingOperation> updateRow(
    _isd.DatabaseSession session,
    PendingOperation row, {
    _isd.ColumnSelections<PendingOperationTable>? columns,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateRow<PendingOperation>(
      row,
      columns: columns?.call(PendingOperation.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PendingOperation] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PendingOperation?> updateById(
    _isd.DatabaseSession session,
    int id, {
    required _isd.ColumnValueListBuilder<PendingOperationUpdateTable>
    columnValues,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateById<PendingOperation>(
      id,
      columnValues: columnValues(PendingOperation.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PendingOperation]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PendingOperation>> updateWhere(
    _isd.DatabaseSession session, {
    required _isd.ColumnValueListBuilder<PendingOperationUpdateTable>
    columnValues,
    required _isd.WhereExpressionBuilder<PendingOperationTable> where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<PendingOperationTable>? orderBy,
    _isd.OrderByListBuilder<PendingOperationTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PendingOperation>(
      columnValues: columnValues(PendingOperation.t.updateTable),
      where: where(PendingOperation.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PendingOperation.t),
      orderByList: orderByList?.call(PendingOperation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PendingOperation]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PendingOperation>> delete(
    _isd.DatabaseSession session,
    List<PendingOperation> rows, {
    _isd.OrderByBuilder<PendingOperationTable>? orderBy,
    _isd.OrderByListBuilder<PendingOperationTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PendingOperation>(
      rows,
      orderBy: orderBy?.call(PendingOperation.t),
      orderByList: orderByList?.call(PendingOperation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PendingOperation].
  Future<PendingOperation> deleteRow(
    _isd.DatabaseSession session,
    PendingOperation row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PendingOperation>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PendingOperation>> deleteWhere(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<PendingOperationTable> where,
    _isd.OrderByBuilder<PendingOperationTable>? orderBy,
    _isd.OrderByListBuilder<PendingOperationTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PendingOperation>(
      where: where(PendingOperation.t),
      orderBy: orderBy?.call(PendingOperation.t),
      orderByList: orderByList?.call(PendingOperation.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<PendingOperationTable>? where,
    int? limit,
    _isd.Transaction? transaction,
  }) async {
    return session.db.count<PendingOperation>(
      where: where?.call(PendingOperation.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PendingOperation] rows matching the [where] expression.
  Future<void> lockRows(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<PendingOperationTable> where,
    required _isd.LockMode lockMode,
    required _isd.Transaction transaction,
    _isd.LockBehavior lockBehavior = _isd.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PendingOperation>(
      where: where(PendingOperation.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
