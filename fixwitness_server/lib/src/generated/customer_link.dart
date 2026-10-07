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

/// A customer review link for exactly one job. Only the SHA-256 of the token is
/// stored; the token itself is returned once, when the link is created.
abstract class CustomerLink
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CustomerLink._({
    this.id,
    required this.jobId,
    this.tokenHash,
    required this.createdByUserId,
    required this.createdAt,
    required this.expiresAt,
    this.revokedAt,
    this.lastOpenedAt,
  });

  factory CustomerLink({
    int? id,
    required int jobId,
    String? tokenHash,
    required _is.UuidValue createdByUserId,
    required DateTime createdAt,
    required DateTime expiresAt,
    DateTime? revokedAt,
    DateTime? lastOpenedAt,
  }) = _CustomerLinkImpl;

  factory CustomerLink.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomerLink(
      id: jsonSerialization['id'] as int?,
      jobId: jsonSerialization['jobId'] as int,
      tokenHash: jsonSerialization['tokenHash'] as String?,
      createdByUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['createdByUserId'],
      ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      revokedAt: jsonSerialization['revokedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['revokedAt']),
      lastOpenedAt: jsonSerialization['lastOpenedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastOpenedAt'],
            ),
    );
  }

  static final t = CustomerLinkTable();

  static const db = CustomerLinkRepository._();

  @override
  int? id;

  int jobId;

  String? tokenHash;

  _is.UuidValue createdByUserId;

  DateTime createdAt;

  DateTime expiresAt;

  DateTime? revokedAt;

  DateTime? lastOpenedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CustomerLink]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CustomerLink copyWith({
    int? id,
    int? jobId,
    String? tokenHash,
    _is.UuidValue? createdByUserId,
    DateTime? createdAt,
    DateTime? expiresAt,
    DateTime? revokedAt,
    DateTime? lastOpenedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerLink',
      if (id != null) 'id': id,
      'jobId': jobId,
      if (tokenHash != null) 'tokenHash': tokenHash,
      'createdByUserId': createdByUserId.toJson(),
      'createdAt': createdAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
      if (lastOpenedAt != null) 'lastOpenedAt': lastOpenedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerLink',
      if (id != null) 'id': id,
      'jobId': jobId,
      'createdByUserId': createdByUserId.toJson(),
      'createdAt': createdAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (revokedAt != null) 'revokedAt': revokedAt?.toJson(),
      if (lastOpenedAt != null) 'lastOpenedAt': lastOpenedAt?.toJson(),
    };
  }

  static CustomerLinkInclude include() {
    return CustomerLinkInclude._();
  }

  static CustomerLinkIncludeList includeList({
    _is.WhereExpressionBuilder<CustomerLinkTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CustomerLinkTable>? orderBy,
    _is.OrderByListBuilder<CustomerLinkTable>? orderByList,
    CustomerLinkInclude? include,
  }) {
    return CustomerLinkIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CustomerLink.t),
      orderByList: orderByList?.call(CustomerLink.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomerLinkImpl extends CustomerLink {
  _CustomerLinkImpl({
    int? id,
    required int jobId,
    String? tokenHash,
    required _is.UuidValue createdByUserId,
    required DateTime createdAt,
    required DateTime expiresAt,
    DateTime? revokedAt,
    DateTime? lastOpenedAt,
  }) : super._(
         id: id,
         jobId: jobId,
         tokenHash: tokenHash,
         createdByUserId: createdByUserId,
         createdAt: createdAt,
         expiresAt: expiresAt,
         revokedAt: revokedAt,
         lastOpenedAt: lastOpenedAt,
       );

  /// Returns a shallow copy of this [CustomerLink]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CustomerLink copyWith({
    Object? id = _Undefined,
    int? jobId,
    Object? tokenHash = _Undefined,
    _is.UuidValue? createdByUserId,
    DateTime? createdAt,
    DateTime? expiresAt,
    Object? revokedAt = _Undefined,
    Object? lastOpenedAt = _Undefined,
  }) {
    return CustomerLink(
      id: id is int? ? id : this.id,
      jobId: jobId ?? this.jobId,
      tokenHash: tokenHash is String? ? tokenHash : this.tokenHash,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      revokedAt: revokedAt is DateTime? ? revokedAt : this.revokedAt,
      lastOpenedAt: lastOpenedAt is DateTime?
          ? lastOpenedAt
          : this.lastOpenedAt,
    );
  }
}

class CustomerLinkUpdateTable extends _is.UpdateTable<CustomerLinkTable> {
  CustomerLinkUpdateTable(super.table);

  _is.ColumnValue<int, int> jobId(int value) => _is.ColumnValue(
    table.jobId,
    value,
  );

  _is.ColumnValue<String, String> tokenHash(String? value) => _is.ColumnValue(
    table.tokenHash,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> createdByUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.createdByUserId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _is.ColumnValue(
        table.expiresAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> revokedAt(DateTime? value) =>
      _is.ColumnValue(
        table.revokedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> lastOpenedAt(DateTime? value) =>
      _is.ColumnValue(
        table.lastOpenedAt,
        value,
      );
}

class CustomerLinkTable extends _is.Table<int?> {
  CustomerLinkTable({super.tableRelation}) : super(tableName: 'customer_link') {
    updateTable = CustomerLinkUpdateTable(this);
    jobId = _is.ColumnInt(
      'jobId',
      this,
    );
    tokenHash = _is.ColumnString(
      'tokenHash',
      this,
    );
    createdByUserId = _is.ColumnUuid(
      'createdByUserId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    expiresAt = _is.ColumnDateTime(
      'expiresAt',
      this,
    );
    revokedAt = _is.ColumnDateTime(
      'revokedAt',
      this,
    );
    lastOpenedAt = _is.ColumnDateTime(
      'lastOpenedAt',
      this,
    );
  }

  late final CustomerLinkUpdateTable updateTable;

  late final _is.ColumnInt jobId;

  late final _is.ColumnString tokenHash;

  late final _is.ColumnUuid createdByUserId;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime expiresAt;

  late final _is.ColumnDateTime revokedAt;

  late final _is.ColumnDateTime lastOpenedAt;

  @override
  List<_is.Column> get columns => [
    id,
    jobId,
    tokenHash,
    createdByUserId,
    createdAt,
    expiresAt,
    revokedAt,
    lastOpenedAt,
  ];
}

class CustomerLinkInclude extends _is.IncludeObject {
  CustomerLinkInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => CustomerLink.t;
}

class CustomerLinkIncludeList extends _is.IncludeList {
  CustomerLinkIncludeList._({
    _is.WhereExpressionBuilder<CustomerLinkTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CustomerLink.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CustomerLink.t;
}

class CustomerLinkRepository {
  const CustomerLinkRepository._();

  /// Returns a list of [CustomerLink]s matching the given query parameters.
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
  Future<List<CustomerLink>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CustomerLinkTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CustomerLinkTable>? orderBy,
    _is.OrderByListBuilder<CustomerLinkTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CustomerLink>(
      where: where?.call(CustomerLink.t),
      orderBy: orderBy?.call(CustomerLink.t),
      orderByList: orderByList?.call(CustomerLink.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CustomerLink] matching the given query parameters.
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
  Future<CustomerLink?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CustomerLinkTable>? where,
    int? offset,
    _is.OrderByBuilder<CustomerLinkTable>? orderBy,
    _is.OrderByListBuilder<CustomerLinkTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CustomerLink>(
      where: where?.call(CustomerLink.t),
      orderBy: orderBy?.call(CustomerLink.t),
      orderByList: orderByList?.call(CustomerLink.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CustomerLink] by its [id] or null if no such row exists.
  Future<CustomerLink?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CustomerLink>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CustomerLink]s in the list and returns the inserted rows.
  ///
  /// The returned [CustomerLink]s will have their `id` fields set.
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
  Future<List<CustomerLink>> insert(
    _is.DatabaseSession session,
    List<CustomerLink> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CustomerLink>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CustomerLink] and returns the inserted row.
  ///
  /// The returned [CustomerLink] will have its `id` field set.
  Future<CustomerLink> insertRow(
    _is.DatabaseSession session,
    CustomerLink row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CustomerLink>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [CustomerLink]s in the list and returns the resulting rows.
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
  /// The returned [CustomerLink]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CustomerLink>> upsert(
    _is.DatabaseSession session,
    List<CustomerLink> rows, {
    required _is.ColumnSelections<CustomerLinkTable> conflictColumns,
    _is.ColumnSelections<CustomerLinkTable>? updateColumns,
    _is.WhereExpressionBuilder<CustomerLinkTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CustomerLink>(
      rows,
      conflictColumns: conflictColumns(CustomerLink.t),
      updateColumns: updateColumns?.call(CustomerLink.t),
      updateWhere: updateWhere?.call(CustomerLink.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CustomerLink] and returns the resulting row.
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
  /// The returned [CustomerLink] will have its `id` field set.
  Future<CustomerLink?> upsertRow(
    _is.DatabaseSession session,
    CustomerLink row, {
    required _is.ColumnSelections<CustomerLinkTable> conflictColumns,
    _is.ColumnSelections<CustomerLinkTable>? updateColumns,
    _is.WhereExpressionBuilder<CustomerLinkTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CustomerLink>(
      row,
      conflictColumns: conflictColumns(CustomerLink.t),
      updateColumns: updateColumns?.call(CustomerLink.t),
      updateWhere: updateWhere?.call(CustomerLink.t),
      transaction: transaction,
    );
  }

  /// Updates all [CustomerLink]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CustomerLink>> update(
    _is.DatabaseSession session,
    List<CustomerLink> rows, {
    _is.ColumnSelections<CustomerLinkTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CustomerLink>(
      rows,
      columns: columns?.call(CustomerLink.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CustomerLink]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CustomerLink> updateRow(
    _is.DatabaseSession session,
    CustomerLink row, {
    _is.ColumnSelections<CustomerLinkTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CustomerLink>(
      row,
      columns: columns?.call(CustomerLink.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CustomerLink] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CustomerLink?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CustomerLinkUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CustomerLink>(
      id,
      columnValues: columnValues(CustomerLink.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CustomerLink]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CustomerLink>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CustomerLinkUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<CustomerLinkTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CustomerLinkTable>? orderBy,
    _is.OrderByListBuilder<CustomerLinkTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CustomerLink>(
      columnValues: columnValues(CustomerLink.t.updateTable),
      where: where(CustomerLink.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CustomerLink.t),
      orderByList: orderByList?.call(CustomerLink.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CustomerLink]s in the list and returns the deleted rows.
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
  Future<List<CustomerLink>> delete(
    _is.DatabaseSession session,
    List<CustomerLink> rows, {
    _is.OrderByBuilder<CustomerLinkTable>? orderBy,
    _is.OrderByListBuilder<CustomerLinkTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CustomerLink>(
      rows,
      orderBy: orderBy?.call(CustomerLink.t),
      orderByList: orderByList?.call(CustomerLink.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CustomerLink].
  Future<CustomerLink> deleteRow(
    _is.DatabaseSession session,
    CustomerLink row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CustomerLink>(
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
  Future<List<CustomerLink>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CustomerLinkTable> where,
    _is.OrderByBuilder<CustomerLinkTable>? orderBy,
    _is.OrderByListBuilder<CustomerLinkTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CustomerLink>(
      where: where(CustomerLink.t),
      orderBy: orderBy?.call(CustomerLink.t),
      orderByList: orderByList?.call(CustomerLink.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CustomerLinkTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CustomerLink>(
      where: where?.call(CustomerLink.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CustomerLink] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CustomerLinkTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CustomerLink>(
      where: where(CustomerLink.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
