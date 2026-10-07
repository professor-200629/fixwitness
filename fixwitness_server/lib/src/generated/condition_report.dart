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
import 'package:fixwitness_server/src/generated/protocol.dart' as _ih76ajaf;
import 'package:serverpod/serverpod.dart' as _is;
import 'condition_item.dart' as _i5ylibdu;

/// A condition checklist snapshot. Append-only: a later check adds a new row, so
/// the intake record is never overwritten.
abstract class ConditionReport
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    required _is.UuidValue clientOpId,
    required List<_i5ylibdu.ConditionItem> items,
    required _is.UuidValue recordedByUserId,
    required String recordedByName,
    required DateTime capturedAt,
    required DateTime receivedAt,
  }) = _ConditionReportImpl;

  factory ConditionReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return ConditionReport(
      id: jsonSerialization['id'] as int?,
      jobId: jsonSerialization['jobId'] as int,
      clientOpId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['clientOpId'],
      ),
      items: _ih76ajaf.Protocol().deserialize<List<_i5ylibdu.ConditionItem>>(
        jsonSerialization['items'],
      ),
      recordedByUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['recordedByUserId'],
      ),
      recordedByName: jsonSerialization['recordedByName'] as String,
      capturedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['capturedAt'],
      ),
      receivedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['receivedAt'],
      ),
    );
  }

  static final t = ConditionReportTable();

  static const db = ConditionReportRepository._();

  @override
  int? id;

  int jobId;

  _is.UuidValue clientOpId;

  List<_i5ylibdu.ConditionItem> items;

  _is.UuidValue recordedByUserId;

  String recordedByName;

  /// Device clock when the technician saved it (may be offline).
  DateTime capturedAt;

  DateTime receivedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ConditionReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ConditionReport copyWith({
    int? id,
    int? jobId,
    _is.UuidValue? clientOpId,
    List<_i5ylibdu.ConditionItem>? items,
    _is.UuidValue? recordedByUserId,
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

  static ConditionReportInclude include() {
    return ConditionReportInclude._();
  }

  static ConditionReportIncludeList includeList({
    _is.WhereExpressionBuilder<ConditionReportTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ConditionReportTable>? orderBy,
    _is.OrderByListBuilder<ConditionReportTable>? orderByList,
    ConditionReportInclude? include,
  }) {
    return ConditionReportIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ConditionReport.t),
      orderByList: orderByList?.call(ConditionReport.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConditionReportImpl extends ConditionReport {
  _ConditionReportImpl({
    int? id,
    required int jobId,
    required _is.UuidValue clientOpId,
    required List<_i5ylibdu.ConditionItem> items,
    required _is.UuidValue recordedByUserId,
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
  @_is.useResult
  @override
  ConditionReport copyWith({
    Object? id = _Undefined,
    int? jobId,
    _is.UuidValue? clientOpId,
    List<_i5ylibdu.ConditionItem>? items,
    _is.UuidValue? recordedByUserId,
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

class ConditionReportUpdateTable extends _is.UpdateTable<ConditionReportTable> {
  ConditionReportUpdateTable(super.table);

  _is.ColumnValue<int, int> jobId(int value) => _is.ColumnValue(
    table.jobId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> clientOpId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.clientOpId,
    value,
  );

  _is.ColumnValue<List<_i5ylibdu.ConditionItem>, List<_i5ylibdu.ConditionItem>>
  items(List<_i5ylibdu.ConditionItem> value) => _is.ColumnValue(
    table.items,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> recordedByUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.recordedByUserId,
    value,
  );

  _is.ColumnValue<String, String> recordedByName(String value) =>
      _is.ColumnValue(
        table.recordedByName,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> capturedAt(DateTime value) =>
      _is.ColumnValue(
        table.capturedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> receivedAt(DateTime value) =>
      _is.ColumnValue(
        table.receivedAt,
        value,
      );
}

class ConditionReportTable extends _is.Table<int?> {
  ConditionReportTable({super.tableRelation})
    : super(tableName: 'condition_report') {
    updateTable = ConditionReportUpdateTable(this);
    jobId = _is.ColumnInt(
      'jobId',
      this,
    );
    clientOpId = _is.ColumnUuid(
      'clientOpId',
      this,
    );
    items = _is.ColumnSerializable<List<_i5ylibdu.ConditionItem>>(
      'items',
      this,
    );
    recordedByUserId = _is.ColumnUuid(
      'recordedByUserId',
      this,
    );
    recordedByName = _is.ColumnString(
      'recordedByName',
      this,
    );
    capturedAt = _is.ColumnDateTime(
      'capturedAt',
      this,
    );
    receivedAt = _is.ColumnDateTime(
      'receivedAt',
      this,
    );
  }

  late final ConditionReportUpdateTable updateTable;

  late final _is.ColumnInt jobId;

  late final _is.ColumnUuid clientOpId;

  late final _is.ColumnSerializable<List<_i5ylibdu.ConditionItem>> items;

  late final _is.ColumnUuid recordedByUserId;

  late final _is.ColumnString recordedByName;

  /// Device clock when the technician saved it (may be offline).
  late final _is.ColumnDateTime capturedAt;

  late final _is.ColumnDateTime receivedAt;

  @override
  List<_is.Column> get columns => [
    id,
    jobId,
    clientOpId,
    items,
    recordedByUserId,
    recordedByName,
    capturedAt,
    receivedAt,
  ];
}

class ConditionReportInclude extends _is.IncludeObject {
  ConditionReportInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ConditionReport.t;
}

class ConditionReportIncludeList extends _is.IncludeList {
  ConditionReportIncludeList._({
    _is.WhereExpressionBuilder<ConditionReportTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ConditionReport.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ConditionReport.t;
}

class ConditionReportRepository {
  const ConditionReportRepository._();

  /// Returns a list of [ConditionReport]s matching the given query parameters.
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
  Future<List<ConditionReport>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ConditionReportTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ConditionReportTable>? orderBy,
    _is.OrderByListBuilder<ConditionReportTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ConditionReport>(
      where: where?.call(ConditionReport.t),
      orderBy: orderBy?.call(ConditionReport.t),
      orderByList: orderByList?.call(ConditionReport.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ConditionReport] matching the given query parameters.
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
  Future<ConditionReport?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ConditionReportTable>? where,
    int? offset,
    _is.OrderByBuilder<ConditionReportTable>? orderBy,
    _is.OrderByListBuilder<ConditionReportTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ConditionReport>(
      where: where?.call(ConditionReport.t),
      orderBy: orderBy?.call(ConditionReport.t),
      orderByList: orderByList?.call(ConditionReport.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ConditionReport] by its [id] or null if no such row exists.
  Future<ConditionReport?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ConditionReport>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ConditionReport]s in the list and returns the inserted rows.
  ///
  /// The returned [ConditionReport]s will have their `id` fields set.
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
  Future<List<ConditionReport>> insert(
    _is.DatabaseSession session,
    List<ConditionReport> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ConditionReport>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ConditionReport] and returns the inserted row.
  ///
  /// The returned [ConditionReport] will have its `id` field set.
  Future<ConditionReport> insertRow(
    _is.DatabaseSession session,
    ConditionReport row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ConditionReport>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ConditionReport]s in the list and returns the resulting rows.
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
  /// The returned [ConditionReport]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ConditionReport>> upsert(
    _is.DatabaseSession session,
    List<ConditionReport> rows, {
    required _is.ColumnSelections<ConditionReportTable> conflictColumns,
    _is.ColumnSelections<ConditionReportTable>? updateColumns,
    _is.WhereExpressionBuilder<ConditionReportTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ConditionReport>(
      rows,
      conflictColumns: conflictColumns(ConditionReport.t),
      updateColumns: updateColumns?.call(ConditionReport.t),
      updateWhere: updateWhere?.call(ConditionReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ConditionReport] and returns the resulting row.
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
  /// The returned [ConditionReport] will have its `id` field set.
  Future<ConditionReport?> upsertRow(
    _is.DatabaseSession session,
    ConditionReport row, {
    required _is.ColumnSelections<ConditionReportTable> conflictColumns,
    _is.ColumnSelections<ConditionReportTable>? updateColumns,
    _is.WhereExpressionBuilder<ConditionReportTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ConditionReport>(
      row,
      conflictColumns: conflictColumns(ConditionReport.t),
      updateColumns: updateColumns?.call(ConditionReport.t),
      updateWhere: updateWhere?.call(ConditionReport.t),
      transaction: transaction,
    );
  }

  /// Updates all [ConditionReport]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ConditionReport>> update(
    _is.DatabaseSession session,
    List<ConditionReport> rows, {
    _is.ColumnSelections<ConditionReportTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ConditionReport>(
      rows,
      columns: columns?.call(ConditionReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ConditionReport]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ConditionReport> updateRow(
    _is.DatabaseSession session,
    ConditionReport row, {
    _is.ColumnSelections<ConditionReportTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ConditionReport>(
      row,
      columns: columns?.call(ConditionReport.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ConditionReport] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ConditionReport?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ConditionReportUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ConditionReport>(
      id,
      columnValues: columnValues(ConditionReport.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ConditionReport]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ConditionReport>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ConditionReportUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ConditionReportTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ConditionReportTable>? orderBy,
    _is.OrderByListBuilder<ConditionReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ConditionReport>(
      columnValues: columnValues(ConditionReport.t.updateTable),
      where: where(ConditionReport.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ConditionReport.t),
      orderByList: orderByList?.call(ConditionReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ConditionReport]s in the list and returns the deleted rows.
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
  Future<List<ConditionReport>> delete(
    _is.DatabaseSession session,
    List<ConditionReport> rows, {
    _is.OrderByBuilder<ConditionReportTable>? orderBy,
    _is.OrderByListBuilder<ConditionReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ConditionReport>(
      rows,
      orderBy: orderBy?.call(ConditionReport.t),
      orderByList: orderByList?.call(ConditionReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ConditionReport].
  Future<ConditionReport> deleteRow(
    _is.DatabaseSession session,
    ConditionReport row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ConditionReport>(
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
  Future<List<ConditionReport>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ConditionReportTable> where,
    _is.OrderByBuilder<ConditionReportTable>? orderBy,
    _is.OrderByListBuilder<ConditionReportTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ConditionReport>(
      where: where(ConditionReport.t),
      orderBy: orderBy?.call(ConditionReport.t),
      orderByList: orderByList?.call(ConditionReport.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ConditionReportTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ConditionReport>(
      where: where?.call(ConditionReport.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ConditionReport] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ConditionReportTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ConditionReport>(
      where: where(ConditionReport.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
