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
import 'decision_kind.dart' as _i21mg86q;

/// The customer decision on one exact estimate version.
abstract class EstimateDecision
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  EstimateDecision._({
    this.id,
    required this.jobId,
    required this.estimateId,
    required this.versionNumber,
    required this.contentHash,
    required this.decision,
    required this.typedName,
    this.declineReason,
    required this.customerLinkId,
    this.ipAddress,
    this.userAgent,
    required this.decidedAt,
  });

  factory EstimateDecision({
    int? id,
    required int jobId,
    required int estimateId,
    required int versionNumber,
    required String contentHash,
    required _i21mg86q.DecisionKind decision,
    required String typedName,
    String? declineReason,
    required int customerLinkId,
    String? ipAddress,
    String? userAgent,
    required DateTime decidedAt,
  }) = _EstimateDecisionImpl;

  factory EstimateDecision.fromJson(Map<String, dynamic> jsonSerialization) {
    return EstimateDecision(
      id: jsonSerialization['id'] as int?,
      jobId: jsonSerialization['jobId'] as int,
      estimateId: jsonSerialization['estimateId'] as int,
      versionNumber: jsonSerialization['versionNumber'] as int,
      contentHash: jsonSerialization['contentHash'] as String,
      decision: _i21mg86q.DecisionKind.fromJson(
        (jsonSerialization['decision'] as String),
      ),
      typedName: jsonSerialization['typedName'] as String,
      declineReason: jsonSerialization['declineReason'] as String?,
      customerLinkId: jsonSerialization['customerLinkId'] as int,
      ipAddress: jsonSerialization['ipAddress'] as String?,
      userAgent: jsonSerialization['userAgent'] as String?,
      decidedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['decidedAt'],
      ),
    );
  }

  static final t = EstimateDecisionTable();

  static const db = EstimateDecisionRepository._();

  @override
  int? id;

  int jobId;

  int estimateId;

  int versionNumber;

  String contentHash;

  _i21mg86q.DecisionKind decision;

  String typedName;

  String? declineReason;

  int customerLinkId;

  String? ipAddress;

  String? userAgent;

  DateTime decidedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [EstimateDecision]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EstimateDecision copyWith({
    int? id,
    int? jobId,
    int? estimateId,
    int? versionNumber,
    String? contentHash,
    _i21mg86q.DecisionKind? decision,
    String? typedName,
    String? declineReason,
    int? customerLinkId,
    String? ipAddress,
    String? userAgent,
    DateTime? decidedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EstimateDecision',
      if (id != null) 'id': id,
      'jobId': jobId,
      'estimateId': estimateId,
      'versionNumber': versionNumber,
      'contentHash': contentHash,
      'decision': decision.toJson(),
      'typedName': typedName,
      if (declineReason != null) 'declineReason': declineReason,
      'customerLinkId': customerLinkId,
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (userAgent != null) 'userAgent': userAgent,
      'decidedAt': decidedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EstimateDecision',
      if (id != null) 'id': id,
      'jobId': jobId,
      'estimateId': estimateId,
      'versionNumber': versionNumber,
      'contentHash': contentHash,
      'decision': decision.toJson(),
      'typedName': typedName,
      if (declineReason != null) 'declineReason': declineReason,
      'customerLinkId': customerLinkId,
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (userAgent != null) 'userAgent': userAgent,
      'decidedAt': decidedAt.toJson(),
    };
  }

  static EstimateDecisionInclude include() {
    return EstimateDecisionInclude._();
  }

  static EstimateDecisionIncludeList includeList({
    _is.WhereExpressionBuilder<EstimateDecisionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EstimateDecisionTable>? orderBy,
    _is.OrderByListBuilder<EstimateDecisionTable>? orderByList,
    EstimateDecisionInclude? include,
  }) {
    return EstimateDecisionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EstimateDecision.t),
      orderByList: orderByList?.call(EstimateDecision.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EstimateDecisionImpl extends EstimateDecision {
  _EstimateDecisionImpl({
    int? id,
    required int jobId,
    required int estimateId,
    required int versionNumber,
    required String contentHash,
    required _i21mg86q.DecisionKind decision,
    required String typedName,
    String? declineReason,
    required int customerLinkId,
    String? ipAddress,
    String? userAgent,
    required DateTime decidedAt,
  }) : super._(
         id: id,
         jobId: jobId,
         estimateId: estimateId,
         versionNumber: versionNumber,
         contentHash: contentHash,
         decision: decision,
         typedName: typedName,
         declineReason: declineReason,
         customerLinkId: customerLinkId,
         ipAddress: ipAddress,
         userAgent: userAgent,
         decidedAt: decidedAt,
       );

  /// Returns a shallow copy of this [EstimateDecision]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EstimateDecision copyWith({
    Object? id = _Undefined,
    int? jobId,
    int? estimateId,
    int? versionNumber,
    String? contentHash,
    _i21mg86q.DecisionKind? decision,
    String? typedName,
    Object? declineReason = _Undefined,
    int? customerLinkId,
    Object? ipAddress = _Undefined,
    Object? userAgent = _Undefined,
    DateTime? decidedAt,
  }) {
    return EstimateDecision(
      id: id is int? ? id : this.id,
      jobId: jobId ?? this.jobId,
      estimateId: estimateId ?? this.estimateId,
      versionNumber: versionNumber ?? this.versionNumber,
      contentHash: contentHash ?? this.contentHash,
      decision: decision ?? this.decision,
      typedName: typedName ?? this.typedName,
      declineReason: declineReason is String?
          ? declineReason
          : this.declineReason,
      customerLinkId: customerLinkId ?? this.customerLinkId,
      ipAddress: ipAddress is String? ? ipAddress : this.ipAddress,
      userAgent: userAgent is String? ? userAgent : this.userAgent,
      decidedAt: decidedAt ?? this.decidedAt,
    );
  }
}

class EstimateDecisionUpdateTable
    extends _is.UpdateTable<EstimateDecisionTable> {
  EstimateDecisionUpdateTable(super.table);

  _is.ColumnValue<int, int> jobId(int value) => _is.ColumnValue(
    table.jobId,
    value,
  );

  _is.ColumnValue<int, int> estimateId(int value) => _is.ColumnValue(
    table.estimateId,
    value,
  );

  _is.ColumnValue<int, int> versionNumber(int value) => _is.ColumnValue(
    table.versionNumber,
    value,
  );

  _is.ColumnValue<String, String> contentHash(String value) => _is.ColumnValue(
    table.contentHash,
    value,
  );

  _is.ColumnValue<_i21mg86q.DecisionKind, _i21mg86q.DecisionKind> decision(
    _i21mg86q.DecisionKind value,
  ) => _is.ColumnValue(
    table.decision,
    value,
  );

  _is.ColumnValue<String, String> typedName(String value) => _is.ColumnValue(
    table.typedName,
    value,
  );

  _is.ColumnValue<String, String> declineReason(String? value) =>
      _is.ColumnValue(
        table.declineReason,
        value,
      );

  _is.ColumnValue<int, int> customerLinkId(int value) => _is.ColumnValue(
    table.customerLinkId,
    value,
  );

  _is.ColumnValue<String, String> ipAddress(String? value) => _is.ColumnValue(
    table.ipAddress,
    value,
  );

  _is.ColumnValue<String, String> userAgent(String? value) => _is.ColumnValue(
    table.userAgent,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> decidedAt(DateTime value) =>
      _is.ColumnValue(
        table.decidedAt,
        value,
      );
}

class EstimateDecisionTable extends _is.Table<int?> {
  EstimateDecisionTable({super.tableRelation})
    : super(tableName: 'estimate_decision') {
    updateTable = EstimateDecisionUpdateTable(this);
    jobId = _is.ColumnInt(
      'jobId',
      this,
    );
    estimateId = _is.ColumnInt(
      'estimateId',
      this,
    );
    versionNumber = _is.ColumnInt(
      'versionNumber',
      this,
    );
    contentHash = _is.ColumnString(
      'contentHash',
      this,
    );
    decision = _is.ColumnEnum(
      'decision',
      this,
      _is.EnumSerialization.byName,
    );
    typedName = _is.ColumnString(
      'typedName',
      this,
    );
    declineReason = _is.ColumnString(
      'declineReason',
      this,
    );
    customerLinkId = _is.ColumnInt(
      'customerLinkId',
      this,
    );
    ipAddress = _is.ColumnString(
      'ipAddress',
      this,
    );
    userAgent = _is.ColumnString(
      'userAgent',
      this,
    );
    decidedAt = _is.ColumnDateTime(
      'decidedAt',
      this,
    );
  }

  late final EstimateDecisionUpdateTable updateTable;

  late final _is.ColumnInt jobId;

  late final _is.ColumnInt estimateId;

  late final _is.ColumnInt versionNumber;

  late final _is.ColumnString contentHash;

  late final _is.ColumnEnum<_i21mg86q.DecisionKind> decision;

  late final _is.ColumnString typedName;

  late final _is.ColumnString declineReason;

  late final _is.ColumnInt customerLinkId;

  late final _is.ColumnString ipAddress;

  late final _is.ColumnString userAgent;

  late final _is.ColumnDateTime decidedAt;

  @override
  List<_is.Column> get columns => [
    id,
    jobId,
    estimateId,
    versionNumber,
    contentHash,
    decision,
    typedName,
    declineReason,
    customerLinkId,
    ipAddress,
    userAgent,
    decidedAt,
  ];
}

class EstimateDecisionInclude extends _is.IncludeObject {
  EstimateDecisionInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => EstimateDecision.t;
}

class EstimateDecisionIncludeList extends _is.IncludeList {
  EstimateDecisionIncludeList._({
    _is.WhereExpressionBuilder<EstimateDecisionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EstimateDecision.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => EstimateDecision.t;
}

class EstimateDecisionRepository {
  const EstimateDecisionRepository._();

  /// Returns a list of [EstimateDecision]s matching the given query parameters.
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
  Future<List<EstimateDecision>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EstimateDecisionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EstimateDecisionTable>? orderBy,
    _is.OrderByListBuilder<EstimateDecisionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EstimateDecision>(
      where: where?.call(EstimateDecision.t),
      orderBy: orderBy?.call(EstimateDecision.t),
      orderByList: orderByList?.call(EstimateDecision.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EstimateDecision] matching the given query parameters.
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
  Future<EstimateDecision?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EstimateDecisionTable>? where,
    int? offset,
    _is.OrderByBuilder<EstimateDecisionTable>? orderBy,
    _is.OrderByListBuilder<EstimateDecisionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EstimateDecision>(
      where: where?.call(EstimateDecision.t),
      orderBy: orderBy?.call(EstimateDecision.t),
      orderByList: orderByList?.call(EstimateDecision.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EstimateDecision] by its [id] or null if no such row exists.
  Future<EstimateDecision?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EstimateDecision>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EstimateDecision]s in the list and returns the inserted rows.
  ///
  /// The returned [EstimateDecision]s will have their `id` fields set.
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
  Future<List<EstimateDecision>> insert(
    _is.DatabaseSession session,
    List<EstimateDecision> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<EstimateDecision>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [EstimateDecision] and returns the inserted row.
  ///
  /// The returned [EstimateDecision] will have its `id` field set.
  Future<EstimateDecision> insertRow(
    _is.DatabaseSession session,
    EstimateDecision row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<EstimateDecision>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [EstimateDecision]s in the list and returns the resulting rows.
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
  /// The returned [EstimateDecision]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EstimateDecision>> upsert(
    _is.DatabaseSession session,
    List<EstimateDecision> rows, {
    required _is.ColumnSelections<EstimateDecisionTable> conflictColumns,
    _is.ColumnSelections<EstimateDecisionTable>? updateColumns,
    _is.WhereExpressionBuilder<EstimateDecisionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<EstimateDecision>(
      rows,
      conflictColumns: conflictColumns(EstimateDecision.t),
      updateColumns: updateColumns?.call(EstimateDecision.t),
      updateWhere: updateWhere?.call(EstimateDecision.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [EstimateDecision] and returns the resulting row.
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
  /// The returned [EstimateDecision] will have its `id` field set.
  Future<EstimateDecision?> upsertRow(
    _is.DatabaseSession session,
    EstimateDecision row, {
    required _is.ColumnSelections<EstimateDecisionTable> conflictColumns,
    _is.ColumnSelections<EstimateDecisionTable>? updateColumns,
    _is.WhereExpressionBuilder<EstimateDecisionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<EstimateDecision>(
      row,
      conflictColumns: conflictColumns(EstimateDecision.t),
      updateColumns: updateColumns?.call(EstimateDecision.t),
      updateWhere: updateWhere?.call(EstimateDecision.t),
      transaction: transaction,
    );
  }

  /// Updates all [EstimateDecision]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EstimateDecision>> update(
    _is.DatabaseSession session,
    List<EstimateDecision> rows, {
    _is.ColumnSelections<EstimateDecisionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<EstimateDecision>(
      rows,
      columns: columns?.call(EstimateDecision.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [EstimateDecision]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EstimateDecision> updateRow(
    _is.DatabaseSession session,
    EstimateDecision row, {
    _is.ColumnSelections<EstimateDecisionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<EstimateDecision>(
      row,
      columns: columns?.call(EstimateDecision.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EstimateDecision] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EstimateDecision?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<EstimateDecisionUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<EstimateDecision>(
      id,
      columnValues: columnValues(EstimateDecision.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EstimateDecision]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EstimateDecision>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EstimateDecisionUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<EstimateDecisionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EstimateDecisionTable>? orderBy,
    _is.OrderByListBuilder<EstimateDecisionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<EstimateDecision>(
      columnValues: columnValues(EstimateDecision.t.updateTable),
      where: where(EstimateDecision.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EstimateDecision.t),
      orderByList: orderByList?.call(EstimateDecision.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [EstimateDecision]s in the list and returns the deleted rows.
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
  Future<List<EstimateDecision>> delete(
    _is.DatabaseSession session,
    List<EstimateDecision> rows, {
    _is.OrderByBuilder<EstimateDecisionTable>? orderBy,
    _is.OrderByListBuilder<EstimateDecisionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<EstimateDecision>(
      rows,
      orderBy: orderBy?.call(EstimateDecision.t),
      orderByList: orderByList?.call(EstimateDecision.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [EstimateDecision].
  Future<EstimateDecision> deleteRow(
    _is.DatabaseSession session,
    EstimateDecision row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EstimateDecision>(
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
  Future<List<EstimateDecision>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EstimateDecisionTable> where,
    _is.OrderByBuilder<EstimateDecisionTable>? orderBy,
    _is.OrderByListBuilder<EstimateDecisionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<EstimateDecision>(
      where: where(EstimateDecision.t),
      orderBy: orderBy?.call(EstimateDecision.t),
      orderByList: orderByList?.call(EstimateDecision.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EstimateDecisionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<EstimateDecision>(
      where: where?.call(EstimateDecision.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EstimateDecision] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EstimateDecisionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EstimateDecision>(
      where: where(EstimateDecision.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
