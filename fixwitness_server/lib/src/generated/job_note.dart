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

abstract class JobNote
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    required _is.UuidValue clientOpId,
    required String text,
    bool? customerVisible,
    required _is.UuidValue authorUserId,
    required String authorName,
    required DateTime writtenAt,
    required DateTime receivedAt,
  }) = _JobNoteImpl;

  factory JobNote.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobNote(
      id: jsonSerialization['id'] as int?,
      jobId: jsonSerialization['jobId'] as int,
      clientOpId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['clientOpId'],
      ),
      text: jsonSerialization['text'] as String,
      customerVisible: jsonSerialization['customerVisible'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['customerVisible'],
            ),
      authorUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authorUserId'],
      ),
      authorName: jsonSerialization['authorName'] as String,
      writtenAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['writtenAt'],
      ),
      receivedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['receivedAt'],
      ),
    );
  }

  static final t = JobNoteTable();

  static const db = JobNoteRepository._();

  @override
  int? id;

  int jobId;

  _is.UuidValue clientOpId;

  String text;

  bool customerVisible;

  _is.UuidValue authorUserId;

  String authorName;

  /// Device clock when written (may be offline).
  DateTime writtenAt;

  DateTime receivedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [JobNote]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  JobNote copyWith({
    int? id,
    int? jobId,
    _is.UuidValue? clientOpId,
    String? text,
    bool? customerVisible,
    _is.UuidValue? authorUserId,
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

  static JobNoteInclude include() {
    return JobNoteInclude._();
  }

  static JobNoteIncludeList includeList({
    _is.WhereExpressionBuilder<JobNoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JobNoteTable>? orderBy,
    _is.OrderByListBuilder<JobNoteTable>? orderByList,
    JobNoteInclude? include,
  }) {
    return JobNoteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobNote.t),
      orderByList: orderByList?.call(JobNote.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JobNoteImpl extends JobNote {
  _JobNoteImpl({
    int? id,
    required int jobId,
    required _is.UuidValue clientOpId,
    required String text,
    bool? customerVisible,
    required _is.UuidValue authorUserId,
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
  @_is.useResult
  @override
  JobNote copyWith({
    Object? id = _Undefined,
    int? jobId,
    _is.UuidValue? clientOpId,
    String? text,
    bool? customerVisible,
    _is.UuidValue? authorUserId,
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

class JobNoteUpdateTable extends _is.UpdateTable<JobNoteTable> {
  JobNoteUpdateTable(super.table);

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

  _is.ColumnValue<String, String> text(String value) => _is.ColumnValue(
    table.text,
    value,
  );

  _is.ColumnValue<bool, bool> customerVisible(bool value) => _is.ColumnValue(
    table.customerVisible,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authorUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authorUserId,
    value,
  );

  _is.ColumnValue<String, String> authorName(String value) => _is.ColumnValue(
    table.authorName,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> writtenAt(DateTime value) =>
      _is.ColumnValue(
        table.writtenAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> receivedAt(DateTime value) =>
      _is.ColumnValue(
        table.receivedAt,
        value,
      );
}

class JobNoteTable extends _is.Table<int?> {
  JobNoteTable({super.tableRelation}) : super(tableName: 'job_note') {
    updateTable = JobNoteUpdateTable(this);
    jobId = _is.ColumnInt(
      'jobId',
      this,
    );
    clientOpId = _is.ColumnUuid(
      'clientOpId',
      this,
    );
    text = _is.ColumnString(
      'text',
      this,
    );
    customerVisible = _is.ColumnBool(
      'customerVisible',
      this,
      hasDefault: true,
    );
    authorUserId = _is.ColumnUuid(
      'authorUserId',
      this,
    );
    authorName = _is.ColumnString(
      'authorName',
      this,
    );
    writtenAt = _is.ColumnDateTime(
      'writtenAt',
      this,
    );
    receivedAt = _is.ColumnDateTime(
      'receivedAt',
      this,
    );
  }

  late final JobNoteUpdateTable updateTable;

  late final _is.ColumnInt jobId;

  late final _is.ColumnUuid clientOpId;

  late final _is.ColumnString text;

  late final _is.ColumnBool customerVisible;

  late final _is.ColumnUuid authorUserId;

  late final _is.ColumnString authorName;

  /// Device clock when written (may be offline).
  late final _is.ColumnDateTime writtenAt;

  late final _is.ColumnDateTime receivedAt;

  @override
  List<_is.Column> get columns => [
    id,
    jobId,
    clientOpId,
    text,
    customerVisible,
    authorUserId,
    authorName,
    writtenAt,
    receivedAt,
  ];
}

class JobNoteInclude extends _is.IncludeObject {
  JobNoteInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => JobNote.t;
}

class JobNoteIncludeList extends _is.IncludeList {
  JobNoteIncludeList._({
    _is.WhereExpressionBuilder<JobNoteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(JobNote.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => JobNote.t;
}

class JobNoteRepository {
  const JobNoteRepository._();

  /// Returns a list of [JobNote]s matching the given query parameters.
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
  Future<List<JobNote>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JobNoteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JobNoteTable>? orderBy,
    _is.OrderByListBuilder<JobNoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<JobNote>(
      where: where?.call(JobNote.t),
      orderBy: orderBy?.call(JobNote.t),
      orderByList: orderByList?.call(JobNote.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [JobNote] matching the given query parameters.
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
  Future<JobNote?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JobNoteTable>? where,
    int? offset,
    _is.OrderByBuilder<JobNoteTable>? orderBy,
    _is.OrderByListBuilder<JobNoteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<JobNote>(
      where: where?.call(JobNote.t),
      orderBy: orderBy?.call(JobNote.t),
      orderByList: orderByList?.call(JobNote.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [JobNote] by its [id] or null if no such row exists.
  Future<JobNote?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<JobNote>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [JobNote]s in the list and returns the inserted rows.
  ///
  /// The returned [JobNote]s will have their `id` fields set.
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
  Future<List<JobNote>> insert(
    _is.DatabaseSession session,
    List<JobNote> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<JobNote>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [JobNote] and returns the inserted row.
  ///
  /// The returned [JobNote] will have its `id` field set.
  Future<JobNote> insertRow(
    _is.DatabaseSession session,
    JobNote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<JobNote>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [JobNote]s in the list and returns the resulting rows.
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
  /// The returned [JobNote]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<JobNote>> upsert(
    _is.DatabaseSession session,
    List<JobNote> rows, {
    required _is.ColumnSelections<JobNoteTable> conflictColumns,
    _is.ColumnSelections<JobNoteTable>? updateColumns,
    _is.WhereExpressionBuilder<JobNoteTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<JobNote>(
      rows,
      conflictColumns: conflictColumns(JobNote.t),
      updateColumns: updateColumns?.call(JobNote.t),
      updateWhere: updateWhere?.call(JobNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [JobNote] and returns the resulting row.
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
  /// The returned [JobNote] will have its `id` field set.
  Future<JobNote?> upsertRow(
    _is.DatabaseSession session,
    JobNote row, {
    required _is.ColumnSelections<JobNoteTable> conflictColumns,
    _is.ColumnSelections<JobNoteTable>? updateColumns,
    _is.WhereExpressionBuilder<JobNoteTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<JobNote>(
      row,
      conflictColumns: conflictColumns(JobNote.t),
      updateColumns: updateColumns?.call(JobNote.t),
      updateWhere: updateWhere?.call(JobNote.t),
      transaction: transaction,
    );
  }

  /// Updates all [JobNote]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<JobNote>> update(
    _is.DatabaseSession session,
    List<JobNote> rows, {
    _is.ColumnSelections<JobNoteTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<JobNote>(
      rows,
      columns: columns?.call(JobNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [JobNote]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<JobNote> updateRow(
    _is.DatabaseSession session,
    JobNote row, {
    _is.ColumnSelections<JobNoteTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<JobNote>(
      row,
      columns: columns?.call(JobNote.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobNote] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<JobNote?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<JobNoteUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<JobNote>(
      id,
      columnValues: columnValues(JobNote.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [JobNote]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<JobNote>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<JobNoteUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<JobNoteTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JobNoteTable>? orderBy,
    _is.OrderByListBuilder<JobNoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<JobNote>(
      columnValues: columnValues(JobNote.t.updateTable),
      where: where(JobNote.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobNote.t),
      orderByList: orderByList?.call(JobNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [JobNote]s in the list and returns the deleted rows.
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
  Future<List<JobNote>> delete(
    _is.DatabaseSession session,
    List<JobNote> rows, {
    _is.OrderByBuilder<JobNoteTable>? orderBy,
    _is.OrderByListBuilder<JobNoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<JobNote>(
      rows,
      orderBy: orderBy?.call(JobNote.t),
      orderByList: orderByList?.call(JobNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [JobNote].
  Future<JobNote> deleteRow(
    _is.DatabaseSession session,
    JobNote row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<JobNote>(
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
  Future<List<JobNote>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<JobNoteTable> where,
    _is.OrderByBuilder<JobNoteTable>? orderBy,
    _is.OrderByListBuilder<JobNoteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<JobNote>(
      where: where(JobNote.t),
      orderBy: orderBy?.call(JobNote.t),
      orderByList: orderByList?.call(JobNote.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JobNoteTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<JobNote>(
      where: where?.call(JobNote.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [JobNote] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<JobNoteTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<JobNote>(
      where: where(JobNote.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
