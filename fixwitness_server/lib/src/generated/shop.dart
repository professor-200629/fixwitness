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

abstract class Shop implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Shop._({
    this.id,
    required this.name,
    String? currency,
    int? nextJobNumber,
    DateTime? createdAt,
  }) : currency = currency ?? 'INR',
       nextJobNumber = nextJobNumber ?? 1,
       createdAt = createdAt ?? DateTime.now();

  factory Shop({
    int? id,
    required String name,
    String? currency,
    int? nextJobNumber,
    DateTime? createdAt,
  }) = _ShopImpl;

  factory Shop.fromJson(Map<String, dynamic> jsonSerialization) {
    return Shop(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      currency: jsonSerialization['currency'] as String?,
      nextJobNumber: jsonSerialization['nextJobNumber'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ShopTable();

  static const db = ShopRepository._();

  @override
  int? id;

  String name;

  /// ISO 4217 code. All money is stored in integer minor units of this currency.
  String currency;

  int nextJobNumber;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Shop]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Shop copyWith({
    int? id,
    String? name,
    String? currency,
    int? nextJobNumber,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Shop',
      if (id != null) 'id': id,
      'name': name,
      'currency': currency,
      'nextJobNumber': nextJobNumber,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Shop',
      if (id != null) 'id': id,
      'name': name,
      'currency': currency,
      'nextJobNumber': nextJobNumber,
      'createdAt': createdAt.toJson(),
    };
  }

  static ShopInclude include() {
    return ShopInclude._();
  }

  static ShopIncludeList includeList({
    _is.WhereExpressionBuilder<ShopTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ShopTable>? orderBy,
    _is.OrderByListBuilder<ShopTable>? orderByList,
    ShopInclude? include,
  }) {
    return ShopIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Shop.t),
      orderByList: orderByList?.call(Shop.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ShopImpl extends Shop {
  _ShopImpl({
    int? id,
    required String name,
    String? currency,
    int? nextJobNumber,
    DateTime? createdAt,
  }) : super._(
         id: id,
         name: name,
         currency: currency,
         nextJobNumber: nextJobNumber,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Shop]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Shop copyWith({
    Object? id = _Undefined,
    String? name,
    String? currency,
    int? nextJobNumber,
    DateTime? createdAt,
  }) {
    return Shop(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      currency: currency ?? this.currency,
      nextJobNumber: nextJobNumber ?? this.nextJobNumber,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ShopUpdateTable extends _is.UpdateTable<ShopTable> {
  ShopUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> currency(String value) => _is.ColumnValue(
    table.currency,
    value,
  );

  _is.ColumnValue<int, int> nextJobNumber(int value) => _is.ColumnValue(
    table.nextJobNumber,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ShopTable extends _is.Table<int?> {
  ShopTable({super.tableRelation}) : super(tableName: 'shop') {
    updateTable = ShopUpdateTable(this);
    name = _is.ColumnString(
      'name',
      this,
    );
    currency = _is.ColumnString(
      'currency',
      this,
      hasDefault: true,
    );
    nextJobNumber = _is.ColumnInt(
      'nextJobNumber',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ShopUpdateTable updateTable;

  late final _is.ColumnString name;

  /// ISO 4217 code. All money is stored in integer minor units of this currency.
  late final _is.ColumnString currency;

  late final _is.ColumnInt nextJobNumber;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    currency,
    nextJobNumber,
    createdAt,
  ];
}

class ShopInclude extends _is.IncludeObject {
  ShopInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Shop.t;
}

class ShopIncludeList extends _is.IncludeList {
  ShopIncludeList._({
    _is.WhereExpressionBuilder<ShopTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Shop.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Shop.t;
}

class ShopRepository {
  const ShopRepository._();

  /// Returns a list of [Shop]s matching the given query parameters.
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
  Future<List<Shop>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ShopTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ShopTable>? orderBy,
    _is.OrderByListBuilder<ShopTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Shop>(
      where: where?.call(Shop.t),
      orderBy: orderBy?.call(Shop.t),
      orderByList: orderByList?.call(Shop.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Shop] matching the given query parameters.
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
  Future<Shop?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ShopTable>? where,
    int? offset,
    _is.OrderByBuilder<ShopTable>? orderBy,
    _is.OrderByListBuilder<ShopTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Shop>(
      where: where?.call(Shop.t),
      orderBy: orderBy?.call(Shop.t),
      orderByList: orderByList?.call(Shop.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Shop] by its [id] or null if no such row exists.
  Future<Shop?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Shop>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Shop]s in the list and returns the inserted rows.
  ///
  /// The returned [Shop]s will have their `id` fields set.
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
  Future<List<Shop>> insert(
    _is.DatabaseSession session,
    List<Shop> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Shop>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Shop] and returns the inserted row.
  ///
  /// The returned [Shop] will have its `id` field set.
  Future<Shop> insertRow(
    _is.DatabaseSession session,
    Shop row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Shop>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Shop]s in the list and returns the resulting rows.
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
  /// The returned [Shop]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Shop>> upsert(
    _is.DatabaseSession session,
    List<Shop> rows, {
    required _is.ColumnSelections<ShopTable> conflictColumns,
    _is.ColumnSelections<ShopTable>? updateColumns,
    _is.WhereExpressionBuilder<ShopTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Shop>(
      rows,
      conflictColumns: conflictColumns(Shop.t),
      updateColumns: updateColumns?.call(Shop.t),
      updateWhere: updateWhere?.call(Shop.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Shop] and returns the resulting row.
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
  /// The returned [Shop] will have its `id` field set.
  Future<Shop?> upsertRow(
    _is.DatabaseSession session,
    Shop row, {
    required _is.ColumnSelections<ShopTable> conflictColumns,
    _is.ColumnSelections<ShopTable>? updateColumns,
    _is.WhereExpressionBuilder<ShopTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Shop>(
      row,
      conflictColumns: conflictColumns(Shop.t),
      updateColumns: updateColumns?.call(Shop.t),
      updateWhere: updateWhere?.call(Shop.t),
      transaction: transaction,
    );
  }

  /// Updates all [Shop]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Shop>> update(
    _is.DatabaseSession session,
    List<Shop> rows, {
    _is.ColumnSelections<ShopTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Shop>(
      rows,
      columns: columns?.call(Shop.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Shop]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Shop> updateRow(
    _is.DatabaseSession session,
    Shop row, {
    _is.ColumnSelections<ShopTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Shop>(
      row,
      columns: columns?.call(Shop.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Shop] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Shop?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ShopUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Shop>(
      id,
      columnValues: columnValues(Shop.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Shop]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Shop>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ShopUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ShopTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ShopTable>? orderBy,
    _is.OrderByListBuilder<ShopTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Shop>(
      columnValues: columnValues(Shop.t.updateTable),
      where: where(Shop.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Shop.t),
      orderByList: orderByList?.call(Shop.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Shop]s in the list and returns the deleted rows.
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
  Future<List<Shop>> delete(
    _is.DatabaseSession session,
    List<Shop> rows, {
    _is.OrderByBuilder<ShopTable>? orderBy,
    _is.OrderByListBuilder<ShopTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Shop>(
      rows,
      orderBy: orderBy?.call(Shop.t),
      orderByList: orderByList?.call(Shop.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Shop].
  Future<Shop> deleteRow(
    _is.DatabaseSession session,
    Shop row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Shop>(
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
  Future<List<Shop>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ShopTable> where,
    _is.OrderByBuilder<ShopTable>? orderBy,
    _is.OrderByListBuilder<ShopTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Shop>(
      where: where(Shop.t),
      orderBy: orderBy?.call(Shop.t),
      orderByList: orderByList?.call(Shop.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ShopTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Shop>(
      where: where?.call(Shop.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Shop] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ShopTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Shop>(
      where: where(Shop.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
