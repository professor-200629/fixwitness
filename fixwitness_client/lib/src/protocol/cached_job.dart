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

/// Device-side cache of job data so the shop app can show jobs offline.
abstract class CachedJob
    implements _isd.TableRow<int?>, _isc.ProtocolSerialization {
  CachedJob._({
    this.id,
    required this.serverJobId,
    required this.jobNumber,
    required this.summaryJson,
    this.detailJson,
    required this.cachedAt,
  });

  factory CachedJob({
    int? id,
    required int serverJobId,
    required int jobNumber,
    required String summaryJson,
    String? detailJson,
    required DateTime cachedAt,
  }) = _CachedJobImpl;

  factory CachedJob.fromJson(Map<String, dynamic> jsonSerialization) {
    return CachedJob(
      id: jsonSerialization['id'] as int?,
      serverJobId: jsonSerialization['serverJobId'] as int,
      jobNumber: jsonSerialization['jobNumber'] as int,
      summaryJson: jsonSerialization['summaryJson'] as String,
      detailJson: jsonSerialization['detailJson'] as String?,
      cachedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['cachedAt'],
      ),
    );
  }

  static final t = CachedJobTable();

  static const db = CachedJobRepository._();

  @override
  int? id;

  int serverJobId;

  int jobNumber;

  String summaryJson;

  String? detailJson;

  DateTime cachedAt;

  @override
  _isd.Table<int?> get table => t;

  /// Returns a shallow copy of this [CachedJob]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CachedJob copyWith({
    int? id,
    int? serverJobId,
    int? jobNumber,
    String? summaryJson,
    String? detailJson,
    DateTime? cachedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CachedJob',
      if (id != null) 'id': id,
      'serverJobId': serverJobId,
      'jobNumber': jobNumber,
      'summaryJson': summaryJson,
      if (detailJson != null) 'detailJson': detailJson,
      'cachedAt': cachedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CachedJob',
      if (id != null) 'id': id,
      'serverJobId': serverJobId,
      'jobNumber': jobNumber,
      'summaryJson': summaryJson,
      if (detailJson != null) 'detailJson': detailJson,
      'cachedAt': cachedAt.toJson(),
    };
  }

  static CachedJobInclude include() {
    return CachedJobInclude._();
  }

  static CachedJobIncludeList includeList({
    _isd.WhereExpressionBuilder<CachedJobTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<CachedJobTable>? orderBy,
    _isd.OrderByListBuilder<CachedJobTable>? orderByList,
    CachedJobInclude? include,
  }) {
    return CachedJobIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CachedJob.t),
      orderByList: orderByList?.call(CachedJob.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CachedJobImpl extends CachedJob {
  _CachedJobImpl({
    int? id,
    required int serverJobId,
    required int jobNumber,
    required String summaryJson,
    String? detailJson,
    required DateTime cachedAt,
  }) : super._(
         id: id,
         serverJobId: serverJobId,
         jobNumber: jobNumber,
         summaryJson: summaryJson,
         detailJson: detailJson,
         cachedAt: cachedAt,
       );

  /// Returns a shallow copy of this [CachedJob]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CachedJob copyWith({
    Object? id = _Undefined,
    int? serverJobId,
    int? jobNumber,
    String? summaryJson,
    Object? detailJson = _Undefined,
    DateTime? cachedAt,
  }) {
    return CachedJob(
      id: id is int? ? id : this.id,
      serverJobId: serverJobId ?? this.serverJobId,
      jobNumber: jobNumber ?? this.jobNumber,
      summaryJson: summaryJson ?? this.summaryJson,
      detailJson: detailJson is String? ? detailJson : this.detailJson,
      cachedAt: cachedAt ?? this.cachedAt,
    );
  }
}

class CachedJobUpdateTable extends _isd.UpdateTable<CachedJobTable> {
  CachedJobUpdateTable(super.table);

  _isd.ColumnValue<int, int> serverJobId(int value) => _isd.ColumnValue(
    table.serverJobId,
    value,
  );

  _isd.ColumnValue<int, int> jobNumber(int value) => _isd.ColumnValue(
    table.jobNumber,
    value,
  );

  _isd.ColumnValue<String, String> summaryJson(String value) =>
      _isd.ColumnValue(
        table.summaryJson,
        value,
      );

  _isd.ColumnValue<String, String> detailJson(String? value) =>
      _isd.ColumnValue(
        table.detailJson,
        value,
      );

  _isd.ColumnValue<DateTime, DateTime> cachedAt(DateTime value) =>
      _isd.ColumnValue(
        table.cachedAt,
        value,
      );
}

class CachedJobTable extends _isd.Table<int?> {
  CachedJobTable({super.tableRelation}) : super(tableName: 'cached_job') {
    updateTable = CachedJobUpdateTable(this);
    serverJobId = _isd.ColumnInt(
      'serverJobId',
      this,
    );
    jobNumber = _isd.ColumnInt(
      'jobNumber',
      this,
    );
    summaryJson = _isd.ColumnString(
      'summaryJson',
      this,
    );
    detailJson = _isd.ColumnString(
      'detailJson',
      this,
    );
    cachedAt = _isd.ColumnDateTime(
      'cachedAt',
      this,
    );
  }

  late final CachedJobUpdateTable updateTable;

  late final _isd.ColumnInt serverJobId;

  late final _isd.ColumnInt jobNumber;

  late final _isd.ColumnString summaryJson;

  late final _isd.ColumnString detailJson;

  late final _isd.ColumnDateTime cachedAt;

  @override
  List<_isd.Column> get columns => [
    id,
    serverJobId,
    jobNumber,
    summaryJson,
    detailJson,
    cachedAt,
  ];
}

class CachedJobInclude extends _isd.IncludeObject {
  CachedJobInclude._();

  @override
  Map<String, _isd.Include?> get includes => {};

  @override
  _isd.Table<int?> get table => CachedJob.t;
}

class CachedJobIncludeList extends _isd.IncludeList {
  CachedJobIncludeList._({
    _isd.WhereExpressionBuilder<CachedJobTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CachedJob.t);
  }

  @override
  Map<String, _isd.Include?> get includes => include?.includes ?? {};

  @override
  _isd.Table<int?> get table => CachedJob.t;
}

class CachedJobRepository {
  const CachedJobRepository._();

  /// Returns a list of [CachedJob]s matching the given query parameters.
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
  Future<List<CachedJob>> find(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<CachedJobTable>? where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<CachedJobTable>? orderBy,
    _isd.OrderByListBuilder<CachedJobTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CachedJob>(
      where: where?.call(CachedJob.t),
      orderBy: orderBy?.call(CachedJob.t),
      orderByList: orderByList?.call(CachedJob.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CachedJob] matching the given query parameters.
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
  Future<CachedJob?> findFirstRow(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<CachedJobTable>? where,
    int? offset,
    _isd.OrderByBuilder<CachedJobTable>? orderBy,
    _isd.OrderByListBuilder<CachedJobTable>? orderByList,
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CachedJob>(
      where: where?.call(CachedJob.t),
      orderBy: orderBy?.call(CachedJob.t),
      orderByList: orderByList?.call(CachedJob.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CachedJob] by its [id] or null if no such row exists.
  Future<CachedJob?> findById(
    _isd.DatabaseSession session,
    int id, {
    _isd.Transaction? transaction,
    _isd.LockMode? lockMode,
    _isd.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CachedJob>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CachedJob]s in the list and returns the inserted rows.
  ///
  /// The returned [CachedJob]s will have their `id` fields set.
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
  Future<List<CachedJob>> insert(
    _isd.DatabaseSession session,
    List<CachedJob> rows, {
    _isd.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CachedJob>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CachedJob] and returns the inserted row.
  ///
  /// The returned [CachedJob] will have its `id` field set.
  Future<CachedJob> insertRow(
    _isd.DatabaseSession session,
    CachedJob row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.insertRow<CachedJob>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CachedJob]s in the list and returns the resulting rows.
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
  /// The returned [CachedJob]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CachedJob>> upsert(
    _isd.DatabaseSession session,
    List<CachedJob> rows, {
    required _isd.ColumnSelections<CachedJobTable> conflictColumns,
    _isd.ColumnSelections<CachedJobTable>? updateColumns,
    _isd.WhereExpressionBuilder<CachedJobTable>? updateWhere,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CachedJob>(
      rows,
      conflictColumns: conflictColumns(CachedJob.t),
      updateColumns: updateColumns?.call(CachedJob.t),
      updateWhere: updateWhere?.call(CachedJob.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CachedJob] and returns the resulting row.
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
  /// The returned [CachedJob] will have its `id` field set.
  Future<CachedJob?> upsertRow(
    _isd.DatabaseSession session,
    CachedJob row, {
    required _isd.ColumnSelections<CachedJobTable> conflictColumns,
    _isd.ColumnSelections<CachedJobTable>? updateColumns,
    _isd.WhereExpressionBuilder<CachedJobTable>? updateWhere,
    _isd.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CachedJob>(
      row,
      conflictColumns: conflictColumns(CachedJob.t),
      updateColumns: updateColumns?.call(CachedJob.t),
      updateWhere: updateWhere?.call(CachedJob.t),
      transaction: transaction,
    );
  }

  /// Updates all [CachedJob]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CachedJob>> update(
    _isd.DatabaseSession session,
    List<CachedJob> rows, {
    _isd.ColumnSelections<CachedJobTable>? columns,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CachedJob>(
      rows,
      columns: columns?.call(CachedJob.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CachedJob]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CachedJob> updateRow(
    _isd.DatabaseSession session,
    CachedJob row, {
    _isd.ColumnSelections<CachedJobTable>? columns,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateRow<CachedJob>(
      row,
      columns: columns?.call(CachedJob.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CachedJob] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CachedJob?> updateById(
    _isd.DatabaseSession session,
    int id, {
    required _isd.ColumnValueListBuilder<CachedJobUpdateTable> columnValues,
    _isd.Transaction? transaction,
  }) async {
    return session.db.updateById<CachedJob>(
      id,
      columnValues: columnValues(CachedJob.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CachedJob]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CachedJob>> updateWhere(
    _isd.DatabaseSession session, {
    required _isd.ColumnValueListBuilder<CachedJobUpdateTable> columnValues,
    required _isd.WhereExpressionBuilder<CachedJobTable> where,
    int? limit,
    int? offset,
    _isd.OrderByBuilder<CachedJobTable>? orderBy,
    _isd.OrderByListBuilder<CachedJobTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CachedJob>(
      columnValues: columnValues(CachedJob.t.updateTable),
      where: where(CachedJob.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CachedJob.t),
      orderByList: orderByList?.call(CachedJob.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CachedJob]s in the list and returns the deleted rows.
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
  Future<List<CachedJob>> delete(
    _isd.DatabaseSession session,
    List<CachedJob> rows, {
    _isd.OrderByBuilder<CachedJobTable>? orderBy,
    _isd.OrderByListBuilder<CachedJobTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CachedJob>(
      rows,
      orderBy: orderBy?.call(CachedJob.t),
      orderByList: orderByList?.call(CachedJob.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CachedJob].
  Future<CachedJob> deleteRow(
    _isd.DatabaseSession session,
    CachedJob row, {
    _isd.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CachedJob>(
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
  Future<List<CachedJob>> deleteWhere(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<CachedJobTable> where,
    _isd.OrderByBuilder<CachedJobTable>? orderBy,
    _isd.OrderByListBuilder<CachedJobTable>? orderByList,
    _isd.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CachedJob>(
      where: where(CachedJob.t),
      orderBy: orderBy?.call(CachedJob.t),
      orderByList: orderByList?.call(CachedJob.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _isd.DatabaseSession session, {
    _isd.WhereExpressionBuilder<CachedJobTable>? where,
    int? limit,
    _isd.Transaction? transaction,
  }) async {
    return session.db.count<CachedJob>(
      where: where?.call(CachedJob.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CachedJob] rows matching the [where] expression.
  Future<void> lockRows(
    _isd.DatabaseSession session, {
    required _isd.WhereExpressionBuilder<CachedJobTable> where,
    required _isd.LockMode lockMode,
    required _isd.Transaction transaction,
    _isd.LockBehavior lockBehavior = _isd.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CachedJob>(
      where: where(CachedJob.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
