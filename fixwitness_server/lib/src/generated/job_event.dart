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
import 'actor_kind.dart' as _ijpkiimy;
import 'job_event_type.dart' as _iwt0hck5;

/// Append-only history. Written in the same transaction as the change it records.
abstract class JobEvent
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
      customerVisible: _is.BoolJsonExtension.fromJson(
        jsonSerialization['customerVisible'],
      ),
      estimateVersion: jsonSerialization['estimateVersion'] as int?,
      occurredAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredAt'],
      ),
    );
  }

  static final t = JobEventTable();

  static const db = JobEventRepository._();

  @override
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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [JobEvent]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static JobEventInclude include() {
    return JobEventInclude._();
  }

  static JobEventIncludeList includeList({
    _is.WhereExpressionBuilder<JobEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JobEventTable>? orderBy,
    _is.OrderByListBuilder<JobEventTable>? orderByList,
    JobEventInclude? include,
  }) {
    return JobEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobEvent.t),
      orderByList: orderByList?.call(JobEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class JobEventUpdateTable extends _is.UpdateTable<JobEventTable> {
  JobEventUpdateTable(super.table);

  _is.ColumnValue<int, int> jobId(int value) => _is.ColumnValue(
    table.jobId,
    value,
  );

  _is.ColumnValue<int, int> seq(int value) => _is.ColumnValue(
    table.seq,
    value,
  );

  _is.ColumnValue<_iwt0hck5.JobEventType, _iwt0hck5.JobEventType> type(
    _iwt0hck5.JobEventType value,
  ) => _is.ColumnValue(
    table.type,
    value,
  );

  _is.ColumnValue<_ijpkiimy.ActorKind, _ijpkiimy.ActorKind> actorKind(
    _ijpkiimy.ActorKind value,
  ) => _is.ColumnValue(
    table.actorKind,
    value,
  );

  _is.ColumnValue<String, String> actorLabel(String value) => _is.ColumnValue(
    table.actorLabel,
    value,
  );

  _is.ColumnValue<String, String> summary(String value) => _is.ColumnValue(
    table.summary,
    value,
  );

  _is.ColumnValue<bool, bool> customerVisible(bool value) => _is.ColumnValue(
    table.customerVisible,
    value,
  );

  _is.ColumnValue<int, int> estimateVersion(int? value) => _is.ColumnValue(
    table.estimateVersion,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> occurredAt(DateTime value) =>
      _is.ColumnValue(
        table.occurredAt,
        value,
      );
}

class JobEventTable extends _is.Table<int?> {
  JobEventTable({super.tableRelation}) : super(tableName: 'job_event') {
    updateTable = JobEventUpdateTable(this);
    jobId = _is.ColumnInt(
      'jobId',
      this,
    );
    seq = _is.ColumnInt(
      'seq',
      this,
    );
    type = _is.ColumnEnum(
      'type',
      this,
      _is.EnumSerialization.byName,
    );
    actorKind = _is.ColumnEnum(
      'actorKind',
      this,
      _is.EnumSerialization.byName,
    );
    actorLabel = _is.ColumnString(
      'actorLabel',
      this,
    );
    summary = _is.ColumnString(
      'summary',
      this,
    );
    customerVisible = _is.ColumnBool(
      'customerVisible',
      this,
    );
    estimateVersion = _is.ColumnInt(
      'estimateVersion',
      this,
    );
    occurredAt = _is.ColumnDateTime(
      'occurredAt',
      this,
    );
  }

  late final JobEventUpdateTable updateTable;

  late final _is.ColumnInt jobId;

  late final _is.ColumnInt seq;

  late final _is.ColumnEnum<_iwt0hck5.JobEventType> type;

  late final _is.ColumnEnum<_ijpkiimy.ActorKind> actorKind;

  late final _is.ColumnString actorLabel;

  late final _is.ColumnString summary;

  late final _is.ColumnBool customerVisible;

  late final _is.ColumnInt estimateVersion;

  late final _is.ColumnDateTime occurredAt;

  @override
  List<_is.Column> get columns => [
    id,
    jobId,
    seq,
    type,
    actorKind,
    actorLabel,
    summary,
    customerVisible,
    estimateVersion,
    occurredAt,
  ];
}

class JobEventInclude extends _is.IncludeObject {
  JobEventInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => JobEvent.t;
}

class JobEventIncludeList extends _is.IncludeList {
  JobEventIncludeList._({
    _is.WhereExpressionBuilder<JobEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(JobEvent.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => JobEvent.t;
}

class JobEventRepository {
  const JobEventRepository._();

  /// Returns a list of [JobEvent]s matching the given query parameters.
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
  Future<List<JobEvent>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JobEventTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JobEventTable>? orderBy,
    _is.OrderByListBuilder<JobEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<JobEvent>(
      where: where?.call(JobEvent.t),
      orderBy: orderBy?.call(JobEvent.t),
      orderByList: orderByList?.call(JobEvent.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [JobEvent] matching the given query parameters.
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
  Future<JobEvent?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JobEventTable>? where,
    int? offset,
    _is.OrderByBuilder<JobEventTable>? orderBy,
    _is.OrderByListBuilder<JobEventTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<JobEvent>(
      where: where?.call(JobEvent.t),
      orderBy: orderBy?.call(JobEvent.t),
      orderByList: orderByList?.call(JobEvent.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [JobEvent] by its [id] or null if no such row exists.
  Future<JobEvent?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<JobEvent>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [JobEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [JobEvent]s will have their `id` fields set.
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
  Future<List<JobEvent>> insert(
    _is.DatabaseSession session,
    List<JobEvent> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<JobEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [JobEvent] and returns the inserted row.
  ///
  /// The returned [JobEvent] will have its `id` field set.
  Future<JobEvent> insertRow(
    _is.DatabaseSession session,
    JobEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<JobEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [JobEvent]s in the list and returns the resulting rows.
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
  /// The returned [JobEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<JobEvent>> upsert(
    _is.DatabaseSession session,
    List<JobEvent> rows, {
    required _is.ColumnSelections<JobEventTable> conflictColumns,
    _is.ColumnSelections<JobEventTable>? updateColumns,
    _is.WhereExpressionBuilder<JobEventTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<JobEvent>(
      rows,
      conflictColumns: conflictColumns(JobEvent.t),
      updateColumns: updateColumns?.call(JobEvent.t),
      updateWhere: updateWhere?.call(JobEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [JobEvent] and returns the resulting row.
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
  /// The returned [JobEvent] will have its `id` field set.
  Future<JobEvent?> upsertRow(
    _is.DatabaseSession session,
    JobEvent row, {
    required _is.ColumnSelections<JobEventTable> conflictColumns,
    _is.ColumnSelections<JobEventTable>? updateColumns,
    _is.WhereExpressionBuilder<JobEventTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<JobEvent>(
      row,
      conflictColumns: conflictColumns(JobEvent.t),
      updateColumns: updateColumns?.call(JobEvent.t),
      updateWhere: updateWhere?.call(JobEvent.t),
      transaction: transaction,
    );
  }

  /// Updates all [JobEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<JobEvent>> update(
    _is.DatabaseSession session,
    List<JobEvent> rows, {
    _is.ColumnSelections<JobEventTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<JobEvent>(
      rows,
      columns: columns?.call(JobEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [JobEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<JobEvent> updateRow(
    _is.DatabaseSession session,
    JobEvent row, {
    _is.ColumnSelections<JobEventTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<JobEvent>(
      row,
      columns: columns?.call(JobEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JobEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<JobEvent?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<JobEventUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<JobEvent>(
      id,
      columnValues: columnValues(JobEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [JobEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<JobEvent>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<JobEventUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<JobEventTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JobEventTable>? orderBy,
    _is.OrderByListBuilder<JobEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<JobEvent>(
      columnValues: columnValues(JobEvent.t.updateTable),
      where: where(JobEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JobEvent.t),
      orderByList: orderByList?.call(JobEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [JobEvent]s in the list and returns the deleted rows.
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
  Future<List<JobEvent>> delete(
    _is.DatabaseSession session,
    List<JobEvent> rows, {
    _is.OrderByBuilder<JobEventTable>? orderBy,
    _is.OrderByListBuilder<JobEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<JobEvent>(
      rows,
      orderBy: orderBy?.call(JobEvent.t),
      orderByList: orderByList?.call(JobEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [JobEvent].
  Future<JobEvent> deleteRow(
    _is.DatabaseSession session,
    JobEvent row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<JobEvent>(
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
  Future<List<JobEvent>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<JobEventTable> where,
    _is.OrderByBuilder<JobEventTable>? orderBy,
    _is.OrderByListBuilder<JobEventTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<JobEvent>(
      where: where(JobEvent.t),
      orderBy: orderBy?.call(JobEvent.t),
      orderByList: orderByList?.call(JobEvent.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JobEventTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<JobEvent>(
      where: where?.call(JobEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [JobEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<JobEventTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<JobEvent>(
      where: where(JobEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
