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

/// An upload description handed to a device. Removed when the photo is
/// registered; a recurring task deletes bytes whose grant was never used up.
abstract class UploadGrant
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  UploadGrant._({
    this.id,
    required this.path,
    required this.shopId,
    required this.jobId,
    required this.opId,
    required this.createdAt,
  });

  factory UploadGrant({
    int? id,
    required String path,
    required int shopId,
    required int jobId,
    required _is.UuidValue opId,
    required DateTime createdAt,
  }) = _UploadGrantImpl;

  factory UploadGrant.fromJson(Map<String, dynamic> jsonSerialization) {
    return UploadGrant(
      id: jsonSerialization['id'] as int?,
      path: jsonSerialization['path'] as String,
      shopId: jsonSerialization['shopId'] as int,
      jobId: jsonSerialization['jobId'] as int,
      opId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['opId']),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = UploadGrantTable();

  static const db = UploadGrantRepository._();

  @override
  int? id;

  String path;

  int shopId;

  int jobId;

  _is.UuidValue opId;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [UploadGrant]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  UploadGrant copyWith({
    int? id,
    String? path,
    int? shopId,
    int? jobId,
    _is.UuidValue? opId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UploadGrant',
      if (id != null) 'id': id,
      'path': path,
      'shopId': shopId,
      'jobId': jobId,
      'opId': opId.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static UploadGrantInclude include() {
    return UploadGrantInclude._();
  }

  static UploadGrantIncludeList includeList({
    _is.WhereExpressionBuilder<UploadGrantTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UploadGrantTable>? orderBy,
    _is.OrderByListBuilder<UploadGrantTable>? orderByList,
    UploadGrantInclude? include,
  }) {
    return UploadGrantIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UploadGrant.t),
      orderByList: orderByList?.call(UploadGrant.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UploadGrantImpl extends UploadGrant {
  _UploadGrantImpl({
    int? id,
    required String path,
    required int shopId,
    required int jobId,
    required _is.UuidValue opId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         path: path,
         shopId: shopId,
         jobId: jobId,
         opId: opId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [UploadGrant]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  UploadGrant copyWith({
    Object? id = _Undefined,
    String? path,
    int? shopId,
    int? jobId,
    _is.UuidValue? opId,
    DateTime? createdAt,
  }) {
    return UploadGrant(
      id: id is int? ? id : this.id,
      path: path ?? this.path,
      shopId: shopId ?? this.shopId,
      jobId: jobId ?? this.jobId,
      opId: opId ?? this.opId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class UploadGrantUpdateTable extends _is.UpdateTable<UploadGrantTable> {
  UploadGrantUpdateTable(super.table);

  _is.ColumnValue<String, String> path(String value) => _is.ColumnValue(
    table.path,
    value,
  );

  _is.ColumnValue<int, int> shopId(int value) => _is.ColumnValue(
    table.shopId,
    value,
  );

  _is.ColumnValue<int, int> jobId(int value) => _is.ColumnValue(
    table.jobId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> opId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.opId,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class UploadGrantTable extends _is.Table<int?> {
  UploadGrantTable({super.tableRelation}) : super(tableName: 'upload_grant') {
    updateTable = UploadGrantUpdateTable(this);
    path = _is.ColumnString(
      'path',
      this,
    );
    shopId = _is.ColumnInt(
      'shopId',
      this,
    );
    jobId = _is.ColumnInt(
      'jobId',
      this,
    );
    opId = _is.ColumnUuid(
      'opId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final UploadGrantUpdateTable updateTable;

  late final _is.ColumnString path;

  late final _is.ColumnInt shopId;

  late final _is.ColumnInt jobId;

  late final _is.ColumnUuid opId;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    path,
    shopId,
    jobId,
    opId,
    createdAt,
  ];
}

class UploadGrantInclude extends _is.IncludeObject {
  UploadGrantInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => UploadGrant.t;
}

class UploadGrantIncludeList extends _is.IncludeList {
  UploadGrantIncludeList._({
    _is.WhereExpressionBuilder<UploadGrantTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UploadGrant.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => UploadGrant.t;
}

class UploadGrantRepository {
  const UploadGrantRepository._();

  /// Returns a list of [UploadGrant]s matching the given query parameters.
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
  Future<List<UploadGrant>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UploadGrantTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UploadGrantTable>? orderBy,
    _is.OrderByListBuilder<UploadGrantTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UploadGrant>(
      where: where?.call(UploadGrant.t),
      orderBy: orderBy?.call(UploadGrant.t),
      orderByList: orderByList?.call(UploadGrant.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UploadGrant] matching the given query parameters.
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
  Future<UploadGrant?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UploadGrantTable>? where,
    int? offset,
    _is.OrderByBuilder<UploadGrantTable>? orderBy,
    _is.OrderByListBuilder<UploadGrantTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UploadGrant>(
      where: where?.call(UploadGrant.t),
      orderBy: orderBy?.call(UploadGrant.t),
      orderByList: orderByList?.call(UploadGrant.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UploadGrant] by its [id] or null if no such row exists.
  Future<UploadGrant?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UploadGrant>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UploadGrant]s in the list and returns the inserted rows.
  ///
  /// The returned [UploadGrant]s will have their `id` fields set.
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
  Future<List<UploadGrant>> insert(
    _is.DatabaseSession session,
    List<UploadGrant> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<UploadGrant>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [UploadGrant] and returns the inserted row.
  ///
  /// The returned [UploadGrant] will have its `id` field set.
  Future<UploadGrant> insertRow(
    _is.DatabaseSession session,
    UploadGrant row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<UploadGrant>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [UploadGrant]s in the list and returns the resulting rows.
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
  /// The returned [UploadGrant]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UploadGrant>> upsert(
    _is.DatabaseSession session,
    List<UploadGrant> rows, {
    required _is.ColumnSelections<UploadGrantTable> conflictColumns,
    _is.ColumnSelections<UploadGrantTable>? updateColumns,
    _is.WhereExpressionBuilder<UploadGrantTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<UploadGrant>(
      rows,
      conflictColumns: conflictColumns(UploadGrant.t),
      updateColumns: updateColumns?.call(UploadGrant.t),
      updateWhere: updateWhere?.call(UploadGrant.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [UploadGrant] and returns the resulting row.
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
  /// The returned [UploadGrant] will have its `id` field set.
  Future<UploadGrant?> upsertRow(
    _is.DatabaseSession session,
    UploadGrant row, {
    required _is.ColumnSelections<UploadGrantTable> conflictColumns,
    _is.ColumnSelections<UploadGrantTable>? updateColumns,
    _is.WhereExpressionBuilder<UploadGrantTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<UploadGrant>(
      row,
      conflictColumns: conflictColumns(UploadGrant.t),
      updateColumns: updateColumns?.call(UploadGrant.t),
      updateWhere: updateWhere?.call(UploadGrant.t),
      transaction: transaction,
    );
  }

  /// Updates all [UploadGrant]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UploadGrant>> update(
    _is.DatabaseSession session,
    List<UploadGrant> rows, {
    _is.ColumnSelections<UploadGrantTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<UploadGrant>(
      rows,
      columns: columns?.call(UploadGrant.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [UploadGrant]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UploadGrant> updateRow(
    _is.DatabaseSession session,
    UploadGrant row, {
    _is.ColumnSelections<UploadGrantTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<UploadGrant>(
      row,
      columns: columns?.call(UploadGrant.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UploadGrant] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UploadGrant?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<UploadGrantUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<UploadGrant>(
      id,
      columnValues: columnValues(UploadGrant.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UploadGrant]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<UploadGrant>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<UploadGrantUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<UploadGrantTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<UploadGrantTable>? orderBy,
    _is.OrderByListBuilder<UploadGrantTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<UploadGrant>(
      columnValues: columnValues(UploadGrant.t.updateTable),
      where: where(UploadGrant.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UploadGrant.t),
      orderByList: orderByList?.call(UploadGrant.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [UploadGrant]s in the list and returns the deleted rows.
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
  Future<List<UploadGrant>> delete(
    _is.DatabaseSession session,
    List<UploadGrant> rows, {
    _is.OrderByBuilder<UploadGrantTable>? orderBy,
    _is.OrderByListBuilder<UploadGrantTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<UploadGrant>(
      rows,
      orderBy: orderBy?.call(UploadGrant.t),
      orderByList: orderByList?.call(UploadGrant.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [UploadGrant].
  Future<UploadGrant> deleteRow(
    _is.DatabaseSession session,
    UploadGrant row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UploadGrant>(
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
  Future<List<UploadGrant>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UploadGrantTable> where,
    _is.OrderByBuilder<UploadGrantTable>? orderBy,
    _is.OrderByListBuilder<UploadGrantTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<UploadGrant>(
      where: where(UploadGrant.t),
      orderBy: orderBy?.call(UploadGrant.t),
      orderByList: orderByList?.call(UploadGrant.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<UploadGrantTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<UploadGrant>(
      where: where?.call(UploadGrant.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UploadGrant] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<UploadGrantTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UploadGrant>(
      where: where(UploadGrant.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
