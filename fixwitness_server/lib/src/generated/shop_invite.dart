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

/// A single-use code an owner gives a technician to join the shop. Only the
/// SHA-256 of the code is stored.
abstract class ShopInvite
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ShopInvite._({
    this.id,
    required this.shopId,
    required this.codeHash,
    required this.createdByUserId,
    required this.createdAt,
    required this.expiresAt,
    this.usedAt,
    this.usedByUserId,
  });

  factory ShopInvite({
    int? id,
    required int shopId,
    required String codeHash,
    required _is.UuidValue createdByUserId,
    required DateTime createdAt,
    required DateTime expiresAt,
    DateTime? usedAt,
    _is.UuidValue? usedByUserId,
  }) = _ShopInviteImpl;

  factory ShopInvite.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShopInvite(
      id: jsonSerialization['id'] as int?,
      shopId: jsonSerialization['shopId'] as int,
      codeHash: jsonSerialization['codeHash'] as String,
      createdByUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['createdByUserId'],
      ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      expiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      usedAt: jsonSerialization['usedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['usedAt']),
      usedByUserId: jsonSerialization['usedByUserId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['usedByUserId'],
            ),
    );
  }

  static final t = ShopInviteTable();

  static const db = ShopInviteRepository._();

  @override
  int? id;

  int shopId;

  String codeHash;

  _is.UuidValue createdByUserId;

  DateTime createdAt;

  DateTime expiresAt;

  DateTime? usedAt;

  _is.UuidValue? usedByUserId;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ShopInvite]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ShopInvite copyWith({
    int? id,
    int? shopId,
    String? codeHash,
    _is.UuidValue? createdByUserId,
    DateTime? createdAt,
    DateTime? expiresAt,
    DateTime? usedAt,
    _is.UuidValue? usedByUserId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ShopInvite',
      if (id != null) 'id': id,
      'shopId': shopId,
      'codeHash': codeHash,
      'createdByUserId': createdByUserId.toJson(),
      'createdAt': createdAt.toJson(),
      'expiresAt': expiresAt.toJson(),
      if (usedAt != null) 'usedAt': usedAt?.toJson(),
      if (usedByUserId != null) 'usedByUserId': usedByUserId?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static ShopInviteInclude include() {
    return ShopInviteInclude._();
  }

  static ShopInviteIncludeList includeList({
    _is.WhereExpressionBuilder<ShopInviteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ShopInviteTable>? orderBy,
    _is.OrderByListBuilder<ShopInviteTable>? orderByList,
    ShopInviteInclude? include,
  }) {
    return ShopInviteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ShopInvite.t),
      orderByList: orderByList?.call(ShopInvite.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ShopInviteImpl extends ShopInvite {
  _ShopInviteImpl({
    int? id,
    required int shopId,
    required String codeHash,
    required _is.UuidValue createdByUserId,
    required DateTime createdAt,
    required DateTime expiresAt,
    DateTime? usedAt,
    _is.UuidValue? usedByUserId,
  }) : super._(
         id: id,
         shopId: shopId,
         codeHash: codeHash,
         createdByUserId: createdByUserId,
         createdAt: createdAt,
         expiresAt: expiresAt,
         usedAt: usedAt,
         usedByUserId: usedByUserId,
       );

  /// Returns a shallow copy of this [ShopInvite]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ShopInvite copyWith({
    Object? id = _Undefined,
    int? shopId,
    String? codeHash,
    _is.UuidValue? createdByUserId,
    DateTime? createdAt,
    DateTime? expiresAt,
    Object? usedAt = _Undefined,
    Object? usedByUserId = _Undefined,
  }) {
    return ShopInvite(
      id: id is int? ? id : this.id,
      shopId: shopId ?? this.shopId,
      codeHash: codeHash ?? this.codeHash,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      usedAt: usedAt is DateTime? ? usedAt : this.usedAt,
      usedByUserId: usedByUserId is _is.UuidValue?
          ? usedByUserId
          : this.usedByUserId,
    );
  }
}

class ShopInviteUpdateTable extends _is.UpdateTable<ShopInviteTable> {
  ShopInviteUpdateTable(super.table);

  _is.ColumnValue<int, int> shopId(int value) => _is.ColumnValue(
    table.shopId,
    value,
  );

  _is.ColumnValue<String, String> codeHash(String value) => _is.ColumnValue(
    table.codeHash,
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

  _is.ColumnValue<DateTime, DateTime> usedAt(DateTime? value) =>
      _is.ColumnValue(
        table.usedAt,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> usedByUserId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.usedByUserId,
    value,
  );
}

class ShopInviteTable extends _is.Table<int?> {
  ShopInviteTable({super.tableRelation}) : super(tableName: 'shop_invite') {
    updateTable = ShopInviteUpdateTable(this);
    shopId = _is.ColumnInt(
      'shopId',
      this,
    );
    codeHash = _is.ColumnString(
      'codeHash',
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
    usedAt = _is.ColumnDateTime(
      'usedAt',
      this,
    );
    usedByUserId = _is.ColumnUuid(
      'usedByUserId',
      this,
    );
  }

  late final ShopInviteUpdateTable updateTable;

  late final _is.ColumnInt shopId;

  late final _is.ColumnString codeHash;

  late final _is.ColumnUuid createdByUserId;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime expiresAt;

  late final _is.ColumnDateTime usedAt;

  late final _is.ColumnUuid usedByUserId;

  @override
  List<_is.Column> get columns => [
    id,
    shopId,
    codeHash,
    createdByUserId,
    createdAt,
    expiresAt,
    usedAt,
    usedByUserId,
  ];
}

class ShopInviteInclude extends _is.IncludeObject {
  ShopInviteInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ShopInvite.t;
}

class ShopInviteIncludeList extends _is.IncludeList {
  ShopInviteIncludeList._({
    _is.WhereExpressionBuilder<ShopInviteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ShopInvite.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ShopInvite.t;
}

class ShopInviteRepository {
  const ShopInviteRepository._();

  /// Returns a list of [ShopInvite]s matching the given query parameters.
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
  Future<List<ShopInvite>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ShopInviteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ShopInviteTable>? orderBy,
    _is.OrderByListBuilder<ShopInviteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ShopInvite>(
      where: where?.call(ShopInvite.t),
      orderBy: orderBy?.call(ShopInvite.t),
      orderByList: orderByList?.call(ShopInvite.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ShopInvite] matching the given query parameters.
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
  Future<ShopInvite?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ShopInviteTable>? where,
    int? offset,
    _is.OrderByBuilder<ShopInviteTable>? orderBy,
    _is.OrderByListBuilder<ShopInviteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ShopInvite>(
      where: where?.call(ShopInvite.t),
      orderBy: orderBy?.call(ShopInvite.t),
      orderByList: orderByList?.call(ShopInvite.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ShopInvite] by its [id] or null if no such row exists.
  Future<ShopInvite?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ShopInvite>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ShopInvite]s in the list and returns the inserted rows.
  ///
  /// The returned [ShopInvite]s will have their `id` fields set.
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
  Future<List<ShopInvite>> insert(
    _is.DatabaseSession session,
    List<ShopInvite> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ShopInvite>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ShopInvite] and returns the inserted row.
  ///
  /// The returned [ShopInvite] will have its `id` field set.
  Future<ShopInvite> insertRow(
    _is.DatabaseSession session,
    ShopInvite row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ShopInvite>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ShopInvite]s in the list and returns the resulting rows.
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
  /// The returned [ShopInvite]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ShopInvite>> upsert(
    _is.DatabaseSession session,
    List<ShopInvite> rows, {
    required _is.ColumnSelections<ShopInviteTable> conflictColumns,
    _is.ColumnSelections<ShopInviteTable>? updateColumns,
    _is.WhereExpressionBuilder<ShopInviteTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ShopInvite>(
      rows,
      conflictColumns: conflictColumns(ShopInvite.t),
      updateColumns: updateColumns?.call(ShopInvite.t),
      updateWhere: updateWhere?.call(ShopInvite.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ShopInvite] and returns the resulting row.
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
  /// The returned [ShopInvite] will have its `id` field set.
  Future<ShopInvite?> upsertRow(
    _is.DatabaseSession session,
    ShopInvite row, {
    required _is.ColumnSelections<ShopInviteTable> conflictColumns,
    _is.ColumnSelections<ShopInviteTable>? updateColumns,
    _is.WhereExpressionBuilder<ShopInviteTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ShopInvite>(
      row,
      conflictColumns: conflictColumns(ShopInvite.t),
      updateColumns: updateColumns?.call(ShopInvite.t),
      updateWhere: updateWhere?.call(ShopInvite.t),
      transaction: transaction,
    );
  }

  /// Updates all [ShopInvite]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ShopInvite>> update(
    _is.DatabaseSession session,
    List<ShopInvite> rows, {
    _is.ColumnSelections<ShopInviteTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ShopInvite>(
      rows,
      columns: columns?.call(ShopInvite.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ShopInvite]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ShopInvite> updateRow(
    _is.DatabaseSession session,
    ShopInvite row, {
    _is.ColumnSelections<ShopInviteTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ShopInvite>(
      row,
      columns: columns?.call(ShopInvite.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ShopInvite] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ShopInvite?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ShopInviteUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ShopInvite>(
      id,
      columnValues: columnValues(ShopInvite.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ShopInvite]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ShopInvite>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ShopInviteUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ShopInviteTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ShopInviteTable>? orderBy,
    _is.OrderByListBuilder<ShopInviteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ShopInvite>(
      columnValues: columnValues(ShopInvite.t.updateTable),
      where: where(ShopInvite.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ShopInvite.t),
      orderByList: orderByList?.call(ShopInvite.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ShopInvite]s in the list and returns the deleted rows.
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
  Future<List<ShopInvite>> delete(
    _is.DatabaseSession session,
    List<ShopInvite> rows, {
    _is.OrderByBuilder<ShopInviteTable>? orderBy,
    _is.OrderByListBuilder<ShopInviteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ShopInvite>(
      rows,
      orderBy: orderBy?.call(ShopInvite.t),
      orderByList: orderByList?.call(ShopInvite.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ShopInvite].
  Future<ShopInvite> deleteRow(
    _is.DatabaseSession session,
    ShopInvite row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ShopInvite>(
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
  Future<List<ShopInvite>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ShopInviteTable> where,
    _is.OrderByBuilder<ShopInviteTable>? orderBy,
    _is.OrderByListBuilder<ShopInviteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ShopInvite>(
      where: where(ShopInvite.t),
      orderBy: orderBy?.call(ShopInvite.t),
      orderByList: orderByList?.call(ShopInvite.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ShopInviteTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ShopInvite>(
      where: where?.call(ShopInvite.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ShopInvite] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ShopInviteTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ShopInvite>(
      where: where(ShopInvite.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
