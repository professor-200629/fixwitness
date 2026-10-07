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
import 'shop_role.dart' as _inr72q68;

abstract class ShopMember
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ShopMember._({
    this.id,
    required this.shopId,
    required this.authUserId,
    required this.displayName,
    required this.role,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ShopMember({
    int? id,
    required int shopId,
    required _is.UuidValue authUserId,
    required String displayName,
    required _inr72q68.ShopRole role,
    DateTime? createdAt,
  }) = _ShopMemberImpl;

  factory ShopMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return ShopMember(
      id: jsonSerialization['id'] as int?,
      shopId: jsonSerialization['shopId'] as int,
      authUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      displayName: jsonSerialization['displayName'] as String,
      role: _inr72q68.ShopRole.fromJson((jsonSerialization['role'] as String)),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ShopMemberTable();

  static const db = ShopMemberRepository._();

  @override
  int? id;

  int shopId;

  _is.UuidValue authUserId;

  String displayName;

  _inr72q68.ShopRole role;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ShopMember]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ShopMember copyWith({
    int? id,
    int? shopId,
    _is.UuidValue? authUserId,
    String? displayName,
    _inr72q68.ShopRole? role,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ShopMember',
      if (id != null) 'id': id,
      'shopId': shopId,
      'authUserId': authUserId.toJson(),
      'displayName': displayName,
      'role': role.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ShopMember',
      if (id != null) 'id': id,
      'shopId': shopId,
      'authUserId': authUserId.toJson(),
      'displayName': displayName,
      'role': role.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static ShopMemberInclude include() {
    return ShopMemberInclude._();
  }

  static ShopMemberIncludeList includeList({
    _is.WhereExpressionBuilder<ShopMemberTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ShopMemberTable>? orderBy,
    _is.OrderByListBuilder<ShopMemberTable>? orderByList,
    ShopMemberInclude? include,
  }) {
    return ShopMemberIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ShopMember.t),
      orderByList: orderByList?.call(ShopMember.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ShopMemberImpl extends ShopMember {
  _ShopMemberImpl({
    int? id,
    required int shopId,
    required _is.UuidValue authUserId,
    required String displayName,
    required _inr72q68.ShopRole role,
    DateTime? createdAt,
  }) : super._(
         id: id,
         shopId: shopId,
         authUserId: authUserId,
         displayName: displayName,
         role: role,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ShopMember]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ShopMember copyWith({
    Object? id = _Undefined,
    int? shopId,
    _is.UuidValue? authUserId,
    String? displayName,
    _inr72q68.ShopRole? role,
    DateTime? createdAt,
  }) {
    return ShopMember(
      id: id is int? ? id : this.id,
      shopId: shopId ?? this.shopId,
      authUserId: authUserId ?? this.authUserId,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ShopMemberUpdateTable extends _is.UpdateTable<ShopMemberTable> {
  ShopMemberUpdateTable(super.table);

  _is.ColumnValue<int, int> shopId(int value) => _is.ColumnValue(
    table.shopId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.authUserId,
    value,
  );

  _is.ColumnValue<String, String> displayName(String value) => _is.ColumnValue(
    table.displayName,
    value,
  );

  _is.ColumnValue<_inr72q68.ShopRole, _inr72q68.ShopRole> role(
    _inr72q68.ShopRole value,
  ) => _is.ColumnValue(
    table.role,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ShopMemberTable extends _is.Table<int?> {
  ShopMemberTable({super.tableRelation}) : super(tableName: 'shop_member') {
    updateTable = ShopMemberUpdateTable(this);
    shopId = _is.ColumnInt(
      'shopId',
      this,
    );
    authUserId = _is.ColumnUuid(
      'authUserId',
      this,
    );
    displayName = _is.ColumnString(
      'displayName',
      this,
    );
    role = _is.ColumnEnum(
      'role',
      this,
      _is.EnumSerialization.byName,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ShopMemberUpdateTable updateTable;

  late final _is.ColumnInt shopId;

  late final _is.ColumnUuid authUserId;

  late final _is.ColumnString displayName;

  late final _is.ColumnEnum<_inr72q68.ShopRole> role;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    shopId,
    authUserId,
    displayName,
    role,
    createdAt,
  ];
}

class ShopMemberInclude extends _is.IncludeObject {
  ShopMemberInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ShopMember.t;
}

class ShopMemberIncludeList extends _is.IncludeList {
  ShopMemberIncludeList._({
    _is.WhereExpressionBuilder<ShopMemberTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ShopMember.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ShopMember.t;
}

class ShopMemberRepository {
  const ShopMemberRepository._();

  /// Returns a list of [ShopMember]s matching the given query parameters.
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
  Future<List<ShopMember>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ShopMemberTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ShopMemberTable>? orderBy,
    _is.OrderByListBuilder<ShopMemberTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ShopMember>(
      where: where?.call(ShopMember.t),
      orderBy: orderBy?.call(ShopMember.t),
      orderByList: orderByList?.call(ShopMember.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ShopMember] matching the given query parameters.
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
  Future<ShopMember?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ShopMemberTable>? where,
    int? offset,
    _is.OrderByBuilder<ShopMemberTable>? orderBy,
    _is.OrderByListBuilder<ShopMemberTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ShopMember>(
      where: where?.call(ShopMember.t),
      orderBy: orderBy?.call(ShopMember.t),
      orderByList: orderByList?.call(ShopMember.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ShopMember] by its [id] or null if no such row exists.
  Future<ShopMember?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ShopMember>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ShopMember]s in the list and returns the inserted rows.
  ///
  /// The returned [ShopMember]s will have their `id` fields set.
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
  Future<List<ShopMember>> insert(
    _is.DatabaseSession session,
    List<ShopMember> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ShopMember>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ShopMember] and returns the inserted row.
  ///
  /// The returned [ShopMember] will have its `id` field set.
  Future<ShopMember> insertRow(
    _is.DatabaseSession session,
    ShopMember row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ShopMember>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ShopMember]s in the list and returns the resulting rows.
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
  /// The returned [ShopMember]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ShopMember>> upsert(
    _is.DatabaseSession session,
    List<ShopMember> rows, {
    required _is.ColumnSelections<ShopMemberTable> conflictColumns,
    _is.ColumnSelections<ShopMemberTable>? updateColumns,
    _is.WhereExpressionBuilder<ShopMemberTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ShopMember>(
      rows,
      conflictColumns: conflictColumns(ShopMember.t),
      updateColumns: updateColumns?.call(ShopMember.t),
      updateWhere: updateWhere?.call(ShopMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ShopMember] and returns the resulting row.
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
  /// The returned [ShopMember] will have its `id` field set.
  Future<ShopMember?> upsertRow(
    _is.DatabaseSession session,
    ShopMember row, {
    required _is.ColumnSelections<ShopMemberTable> conflictColumns,
    _is.ColumnSelections<ShopMemberTable>? updateColumns,
    _is.WhereExpressionBuilder<ShopMemberTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ShopMember>(
      row,
      conflictColumns: conflictColumns(ShopMember.t),
      updateColumns: updateColumns?.call(ShopMember.t),
      updateWhere: updateWhere?.call(ShopMember.t),
      transaction: transaction,
    );
  }

  /// Updates all [ShopMember]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ShopMember>> update(
    _is.DatabaseSession session,
    List<ShopMember> rows, {
    _is.ColumnSelections<ShopMemberTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ShopMember>(
      rows,
      columns: columns?.call(ShopMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ShopMember]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ShopMember> updateRow(
    _is.DatabaseSession session,
    ShopMember row, {
    _is.ColumnSelections<ShopMemberTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ShopMember>(
      row,
      columns: columns?.call(ShopMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ShopMember] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ShopMember?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ShopMemberUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ShopMember>(
      id,
      columnValues: columnValues(ShopMember.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ShopMember]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ShopMember>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ShopMemberUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ShopMemberTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ShopMemberTable>? orderBy,
    _is.OrderByListBuilder<ShopMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ShopMember>(
      columnValues: columnValues(ShopMember.t.updateTable),
      where: where(ShopMember.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ShopMember.t),
      orderByList: orderByList?.call(ShopMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ShopMember]s in the list and returns the deleted rows.
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
  Future<List<ShopMember>> delete(
    _is.DatabaseSession session,
    List<ShopMember> rows, {
    _is.OrderByBuilder<ShopMemberTable>? orderBy,
    _is.OrderByListBuilder<ShopMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ShopMember>(
      rows,
      orderBy: orderBy?.call(ShopMember.t),
      orderByList: orderByList?.call(ShopMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ShopMember].
  Future<ShopMember> deleteRow(
    _is.DatabaseSession session,
    ShopMember row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ShopMember>(
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
  Future<List<ShopMember>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ShopMemberTable> where,
    _is.OrderByBuilder<ShopMemberTable>? orderBy,
    _is.OrderByListBuilder<ShopMemberTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ShopMember>(
      where: where(ShopMember.t),
      orderBy: orderBy?.call(ShopMember.t),
      orderByList: orderByList?.call(ShopMember.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ShopMemberTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ShopMember>(
      where: where?.call(ShopMember.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ShopMember] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ShopMemberTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ShopMember>(
      where: where(ShopMember.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
