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
import 'estimate_line.dart' as _icm2x340;
import 'estimate_status.dart' as _i3t4a52c;

/// One issued estimate version. Rows are inserted once; afterwards only status and
/// decidedAt change. Lines and totals are never edited.
abstract class Estimate
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Estimate._({
    this.id,
    required this.jobId,
    required this.versionNumber,
    required this.status,
    required this.lines,
    required this.totalMinor,
    required this.currency,
    this.note,
    this.reasonForRevision,
    required this.contentHash,
    required this.issuedAt,
    required this.issuedByUserId,
    required this.issuedByName,
    this.decidedAt,
  });

  factory Estimate({
    int? id,
    required int jobId,
    required int versionNumber,
    required _i3t4a52c.EstimateStatus status,
    required List<_icm2x340.EstimateLine> lines,
    required int totalMinor,
    required String currency,
    String? note,
    String? reasonForRevision,
    required String contentHash,
    required DateTime issuedAt,
    required _is.UuidValue issuedByUserId,
    required String issuedByName,
    DateTime? decidedAt,
  }) = _EstimateImpl;

  factory Estimate.fromJson(Map<String, dynamic> jsonSerialization) {
    return Estimate(
      id: jsonSerialization['id'] as int?,
      jobId: jsonSerialization['jobId'] as int,
      versionNumber: jsonSerialization['versionNumber'] as int,
      status: _i3t4a52c.EstimateStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      lines: _ih76ajaf.Protocol().deserialize<List<_icm2x340.EstimateLine>>(
        jsonSerialization['lines'],
      ),
      totalMinor: jsonSerialization['totalMinor'] as int,
      currency: jsonSerialization['currency'] as String,
      note: jsonSerialization['note'] as String?,
      reasonForRevision: jsonSerialization['reasonForRevision'] as String?,
      contentHash: jsonSerialization['contentHash'] as String,
      issuedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['issuedAt'],
      ),
      issuedByUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['issuedByUserId'],
      ),
      issuedByName: jsonSerialization['issuedByName'] as String,
      decidedAt: jsonSerialization['decidedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['decidedAt']),
    );
  }

  static final t = EstimateTable();

  static const db = EstimateRepository._();

  @override
  int? id;

  int jobId;

  int versionNumber;

  _i3t4a52c.EstimateStatus status;

  List<_icm2x340.EstimateLine> lines;

  int totalMinor;

  String currency;

  String? note;

  /// Why the shop issued a new version (required from version 2 on).
  String? reasonForRevision;

  /// SHA-256 over the canonical content; the customer approves this exact hash.
  String contentHash;

  DateTime issuedAt;

  _is.UuidValue issuedByUserId;

  String issuedByName;

  DateTime? decidedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Estimate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Estimate copyWith({
    int? id,
    int? jobId,
    int? versionNumber,
    _i3t4a52c.EstimateStatus? status,
    List<_icm2x340.EstimateLine>? lines,
    int? totalMinor,
    String? currency,
    String? note,
    String? reasonForRevision,
    String? contentHash,
    DateTime? issuedAt,
    _is.UuidValue? issuedByUserId,
    String? issuedByName,
    DateTime? decidedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Estimate',
      if (id != null) 'id': id,
      'jobId': jobId,
      'versionNumber': versionNumber,
      'status': status.toJson(),
      'lines': lines.toJson(valueToJson: (v) => v.toJson()),
      'totalMinor': totalMinor,
      'currency': currency,
      if (note != null) 'note': note,
      if (reasonForRevision != null) 'reasonForRevision': reasonForRevision,
      'contentHash': contentHash,
      'issuedAt': issuedAt.toJson(),
      'issuedByUserId': issuedByUserId.toJson(),
      'issuedByName': issuedByName,
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Estimate',
      if (id != null) 'id': id,
      'jobId': jobId,
      'versionNumber': versionNumber,
      'status': status.toJson(),
      'lines': lines.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'totalMinor': totalMinor,
      'currency': currency,
      if (note != null) 'note': note,
      if (reasonForRevision != null) 'reasonForRevision': reasonForRevision,
      'contentHash': contentHash,
      'issuedAt': issuedAt.toJson(),
      'issuedByUserId': issuedByUserId.toJson(),
      'issuedByName': issuedByName,
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  static EstimateInclude include() {
    return EstimateInclude._();
  }

  static EstimateIncludeList includeList({
    _is.WhereExpressionBuilder<EstimateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EstimateTable>? orderBy,
    _is.OrderByListBuilder<EstimateTable>? orderByList,
    EstimateInclude? include,
  }) {
    return EstimateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Estimate.t),
      orderByList: orderByList?.call(Estimate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EstimateImpl extends Estimate {
  _EstimateImpl({
    int? id,
    required int jobId,
    required int versionNumber,
    required _i3t4a52c.EstimateStatus status,
    required List<_icm2x340.EstimateLine> lines,
    required int totalMinor,
    required String currency,
    String? note,
    String? reasonForRevision,
    required String contentHash,
    required DateTime issuedAt,
    required _is.UuidValue issuedByUserId,
    required String issuedByName,
    DateTime? decidedAt,
  }) : super._(
         id: id,
         jobId: jobId,
         versionNumber: versionNumber,
         status: status,
         lines: lines,
         totalMinor: totalMinor,
         currency: currency,
         note: note,
         reasonForRevision: reasonForRevision,
         contentHash: contentHash,
         issuedAt: issuedAt,
         issuedByUserId: issuedByUserId,
         issuedByName: issuedByName,
         decidedAt: decidedAt,
       );

  /// Returns a shallow copy of this [Estimate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Estimate copyWith({
    Object? id = _Undefined,
    int? jobId,
    int? versionNumber,
    _i3t4a52c.EstimateStatus? status,
    List<_icm2x340.EstimateLine>? lines,
    int? totalMinor,
    String? currency,
    Object? note = _Undefined,
    Object? reasonForRevision = _Undefined,
    String? contentHash,
    DateTime? issuedAt,
    _is.UuidValue? issuedByUserId,
    String? issuedByName,
    Object? decidedAt = _Undefined,
  }) {
    return Estimate(
      id: id is int? ? id : this.id,
      jobId: jobId ?? this.jobId,
      versionNumber: versionNumber ?? this.versionNumber,
      status: status ?? this.status,
      lines: lines ?? this.lines.map((e0) => e0.copyWith()).toList(),
      totalMinor: totalMinor ?? this.totalMinor,
      currency: currency ?? this.currency,
      note: note is String? ? note : this.note,
      reasonForRevision: reasonForRevision is String?
          ? reasonForRevision
          : this.reasonForRevision,
      contentHash: contentHash ?? this.contentHash,
      issuedAt: issuedAt ?? this.issuedAt,
      issuedByUserId: issuedByUserId ?? this.issuedByUserId,
      issuedByName: issuedByName ?? this.issuedByName,
      decidedAt: decidedAt is DateTime? ? decidedAt : this.decidedAt,
    );
  }
}

class EstimateUpdateTable extends _is.UpdateTable<EstimateTable> {
  EstimateUpdateTable(super.table);

  _is.ColumnValue<int, int> jobId(int value) => _is.ColumnValue(
    table.jobId,
    value,
  );

  _is.ColumnValue<int, int> versionNumber(int value) => _is.ColumnValue(
    table.versionNumber,
    value,
  );

  _is.ColumnValue<_i3t4a52c.EstimateStatus, _i3t4a52c.EstimateStatus> status(
    _i3t4a52c.EstimateStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<List<_icm2x340.EstimateLine>, List<_icm2x340.EstimateLine>>
  lines(List<_icm2x340.EstimateLine> value) => _is.ColumnValue(
    table.lines,
    value,
  );

  _is.ColumnValue<int, int> totalMinor(int value) => _is.ColumnValue(
    table.totalMinor,
    value,
  );

  _is.ColumnValue<String, String> currency(String value) => _is.ColumnValue(
    table.currency,
    value,
  );

  _is.ColumnValue<String, String> note(String? value) => _is.ColumnValue(
    table.note,
    value,
  );

  _is.ColumnValue<String, String> reasonForRevision(String? value) =>
      _is.ColumnValue(
        table.reasonForRevision,
        value,
      );

  _is.ColumnValue<String, String> contentHash(String value) => _is.ColumnValue(
    table.contentHash,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> issuedAt(DateTime value) =>
      _is.ColumnValue(
        table.issuedAt,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> issuedByUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.issuedByUserId,
    value,
  );

  _is.ColumnValue<String, String> issuedByName(String value) => _is.ColumnValue(
    table.issuedByName,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> decidedAt(DateTime? value) =>
      _is.ColumnValue(
        table.decidedAt,
        value,
      );
}

class EstimateTable extends _is.Table<int?> {
  EstimateTable({super.tableRelation}) : super(tableName: 'estimate') {
    updateTable = EstimateUpdateTable(this);
    jobId = _is.ColumnInt(
      'jobId',
      this,
    );
    versionNumber = _is.ColumnInt(
      'versionNumber',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    lines = _is.ColumnSerializable<List<_icm2x340.EstimateLine>>(
      'lines',
      this,
    );
    totalMinor = _is.ColumnInt(
      'totalMinor',
      this,
    );
    currency = _is.ColumnString(
      'currency',
      this,
    );
    note = _is.ColumnString(
      'note',
      this,
    );
    reasonForRevision = _is.ColumnString(
      'reasonForRevision',
      this,
    );
    contentHash = _is.ColumnString(
      'contentHash',
      this,
    );
    issuedAt = _is.ColumnDateTime(
      'issuedAt',
      this,
    );
    issuedByUserId = _is.ColumnUuid(
      'issuedByUserId',
      this,
    );
    issuedByName = _is.ColumnString(
      'issuedByName',
      this,
    );
    decidedAt = _is.ColumnDateTime(
      'decidedAt',
      this,
    );
  }

  late final EstimateUpdateTable updateTable;

  late final _is.ColumnInt jobId;

  late final _is.ColumnInt versionNumber;

  late final _is.ColumnEnum<_i3t4a52c.EstimateStatus> status;

  late final _is.ColumnSerializable<List<_icm2x340.EstimateLine>> lines;

  late final _is.ColumnInt totalMinor;

  late final _is.ColumnString currency;

  late final _is.ColumnString note;

  /// Why the shop issued a new version (required from version 2 on).
  late final _is.ColumnString reasonForRevision;

  /// SHA-256 over the canonical content; the customer approves this exact hash.
  late final _is.ColumnString contentHash;

  late final _is.ColumnDateTime issuedAt;

  late final _is.ColumnUuid issuedByUserId;

  late final _is.ColumnString issuedByName;

  late final _is.ColumnDateTime decidedAt;

  @override
  List<_is.Column> get columns => [
    id,
    jobId,
    versionNumber,
    status,
    lines,
    totalMinor,
    currency,
    note,
    reasonForRevision,
    contentHash,
    issuedAt,
    issuedByUserId,
    issuedByName,
    decidedAt,
  ];
}

class EstimateInclude extends _is.IncludeObject {
  EstimateInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Estimate.t;
}

class EstimateIncludeList extends _is.IncludeList {
  EstimateIncludeList._({
    _is.WhereExpressionBuilder<EstimateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Estimate.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Estimate.t;
}

class EstimateRepository {
  const EstimateRepository._();

  /// Returns a list of [Estimate]s matching the given query parameters.
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
  Future<List<Estimate>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EstimateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EstimateTable>? orderBy,
    _is.OrderByListBuilder<EstimateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Estimate>(
      where: where?.call(Estimate.t),
      orderBy: orderBy?.call(Estimate.t),
      orderByList: orderByList?.call(Estimate.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Estimate] matching the given query parameters.
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
  Future<Estimate?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EstimateTable>? where,
    int? offset,
    _is.OrderByBuilder<EstimateTable>? orderBy,
    _is.OrderByListBuilder<EstimateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Estimate>(
      where: where?.call(Estimate.t),
      orderBy: orderBy?.call(Estimate.t),
      orderByList: orderByList?.call(Estimate.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Estimate] by its [id] or null if no such row exists.
  Future<Estimate?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Estimate>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Estimate]s in the list and returns the inserted rows.
  ///
  /// The returned [Estimate]s will have their `id` fields set.
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
  Future<List<Estimate>> insert(
    _is.DatabaseSession session,
    List<Estimate> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Estimate>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Estimate] and returns the inserted row.
  ///
  /// The returned [Estimate] will have its `id` field set.
  Future<Estimate> insertRow(
    _is.DatabaseSession session,
    Estimate row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Estimate>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Estimate]s in the list and returns the resulting rows.
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
  /// The returned [Estimate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Estimate>> upsert(
    _is.DatabaseSession session,
    List<Estimate> rows, {
    required _is.ColumnSelections<EstimateTable> conflictColumns,
    _is.ColumnSelections<EstimateTable>? updateColumns,
    _is.WhereExpressionBuilder<EstimateTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Estimate>(
      rows,
      conflictColumns: conflictColumns(Estimate.t),
      updateColumns: updateColumns?.call(Estimate.t),
      updateWhere: updateWhere?.call(Estimate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Estimate] and returns the resulting row.
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
  /// The returned [Estimate] will have its `id` field set.
  Future<Estimate?> upsertRow(
    _is.DatabaseSession session,
    Estimate row, {
    required _is.ColumnSelections<EstimateTable> conflictColumns,
    _is.ColumnSelections<EstimateTable>? updateColumns,
    _is.WhereExpressionBuilder<EstimateTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Estimate>(
      row,
      conflictColumns: conflictColumns(Estimate.t),
      updateColumns: updateColumns?.call(Estimate.t),
      updateWhere: updateWhere?.call(Estimate.t),
      transaction: transaction,
    );
  }

  /// Updates all [Estimate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Estimate>> update(
    _is.DatabaseSession session,
    List<Estimate> rows, {
    _is.ColumnSelections<EstimateTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Estimate>(
      rows,
      columns: columns?.call(Estimate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Estimate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Estimate> updateRow(
    _is.DatabaseSession session,
    Estimate row, {
    _is.ColumnSelections<EstimateTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Estimate>(
      row,
      columns: columns?.call(Estimate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Estimate] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Estimate?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<EstimateUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Estimate>(
      id,
      columnValues: columnValues(Estimate.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Estimate]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Estimate>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EstimateUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<EstimateTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EstimateTable>? orderBy,
    _is.OrderByListBuilder<EstimateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Estimate>(
      columnValues: columnValues(Estimate.t.updateTable),
      where: where(Estimate.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Estimate.t),
      orderByList: orderByList?.call(Estimate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Estimate]s in the list and returns the deleted rows.
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
  Future<List<Estimate>> delete(
    _is.DatabaseSession session,
    List<Estimate> rows, {
    _is.OrderByBuilder<EstimateTable>? orderBy,
    _is.OrderByListBuilder<EstimateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Estimate>(
      rows,
      orderBy: orderBy?.call(Estimate.t),
      orderByList: orderByList?.call(Estimate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Estimate].
  Future<Estimate> deleteRow(
    _is.DatabaseSession session,
    Estimate row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Estimate>(
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
  Future<List<Estimate>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EstimateTable> where,
    _is.OrderByBuilder<EstimateTable>? orderBy,
    _is.OrderByListBuilder<EstimateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Estimate>(
      where: where(Estimate.t),
      orderBy: orderBy?.call(Estimate.t),
      orderByList: orderByList?.call(Estimate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EstimateTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Estimate>(
      where: where?.call(Estimate.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Estimate] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EstimateTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Estimate>(
      where: where(Estimate.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
