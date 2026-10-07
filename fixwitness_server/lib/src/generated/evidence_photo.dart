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
import 'photo_stage.dart' as _izmwwpv6;

abstract class EvidencePhoto
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  EvidencePhoto._({
    this.id,
    required this.jobId,
    required this.clientOpId,
    required this.stage,
    this.caption,
    this.storagePath,
    required this.contentType,
    required this.sizeBytes,
    required this.sha256,
    required this.capturedAt,
    required this.uploadedByUserId,
    required this.uploadedByName,
    required this.registeredAt,
    bool? customerVisible,
  }) : customerVisible = customerVisible ?? true;

  factory EvidencePhoto({
    int? id,
    required int jobId,
    required _is.UuidValue clientOpId,
    required _izmwwpv6.PhotoStage stage,
    String? caption,
    String? storagePath,
    required String contentType,
    required int sizeBytes,
    required String sha256,
    required DateTime capturedAt,
    required _is.UuidValue uploadedByUserId,
    required String uploadedByName,
    required DateTime registeredAt,
    bool? customerVisible,
  }) = _EvidencePhotoImpl;

  factory EvidencePhoto.fromJson(Map<String, dynamic> jsonSerialization) {
    return EvidencePhoto(
      id: jsonSerialization['id'] as int?,
      jobId: jsonSerialization['jobId'] as int,
      clientOpId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['clientOpId'],
      ),
      stage: _izmwwpv6.PhotoStage.fromJson(
        (jsonSerialization['stage'] as String),
      ),
      caption: jsonSerialization['caption'] as String?,
      storagePath: jsonSerialization['storagePath'] as String?,
      contentType: jsonSerialization['contentType'] as String,
      sizeBytes: jsonSerialization['sizeBytes'] as int,
      sha256: jsonSerialization['sha256'] as String,
      capturedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['capturedAt'],
      ),
      uploadedByUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['uploadedByUserId'],
      ),
      uploadedByName: jsonSerialization['uploadedByName'] as String,
      registeredAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['registeredAt'],
      ),
      customerVisible: jsonSerialization['customerVisible'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['customerVisible'],
            ),
    );
  }

  static final t = EvidencePhotoTable();

  static const db = EvidencePhotoRepository._();

  @override
  int? id;

  int jobId;

  _is.UuidValue clientOpId;

  _izmwwpv6.PhotoStage stage;

  String? caption;

  String? storagePath;

  String contentType;

  int sizeBytes;

  String sha256;

  DateTime capturedAt;

  _is.UuidValue uploadedByUserId;

  String uploadedByName;

  DateTime registeredAt;

  bool customerVisible;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [EvidencePhoto]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EvidencePhoto copyWith({
    int? id,
    int? jobId,
    _is.UuidValue? clientOpId,
    _izmwwpv6.PhotoStage? stage,
    String? caption,
    String? storagePath,
    String? contentType,
    int? sizeBytes,
    String? sha256,
    DateTime? capturedAt,
    _is.UuidValue? uploadedByUserId,
    String? uploadedByName,
    DateTime? registeredAt,
    bool? customerVisible,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EvidencePhoto',
      if (id != null) 'id': id,
      'jobId': jobId,
      'clientOpId': clientOpId.toJson(),
      'stage': stage.toJson(),
      if (caption != null) 'caption': caption,
      if (storagePath != null) 'storagePath': storagePath,
      'contentType': contentType,
      'sizeBytes': sizeBytes,
      'sha256': sha256,
      'capturedAt': capturedAt.toJson(),
      'uploadedByUserId': uploadedByUserId.toJson(),
      'uploadedByName': uploadedByName,
      'registeredAt': registeredAt.toJson(),
      'customerVisible': customerVisible,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EvidencePhoto',
      if (id != null) 'id': id,
      'jobId': jobId,
      'clientOpId': clientOpId.toJson(),
      'stage': stage.toJson(),
      if (caption != null) 'caption': caption,
      'contentType': contentType,
      'sizeBytes': sizeBytes,
      'sha256': sha256,
      'capturedAt': capturedAt.toJson(),
      'uploadedByUserId': uploadedByUserId.toJson(),
      'uploadedByName': uploadedByName,
      'registeredAt': registeredAt.toJson(),
      'customerVisible': customerVisible,
    };
  }

  static EvidencePhotoInclude include() {
    return EvidencePhotoInclude._();
  }

  static EvidencePhotoIncludeList includeList({
    _is.WhereExpressionBuilder<EvidencePhotoTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EvidencePhotoTable>? orderBy,
    _is.OrderByListBuilder<EvidencePhotoTable>? orderByList,
    EvidencePhotoInclude? include,
  }) {
    return EvidencePhotoIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EvidencePhoto.t),
      orderByList: orderByList?.call(EvidencePhoto.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EvidencePhotoImpl extends EvidencePhoto {
  _EvidencePhotoImpl({
    int? id,
    required int jobId,
    required _is.UuidValue clientOpId,
    required _izmwwpv6.PhotoStage stage,
    String? caption,
    String? storagePath,
    required String contentType,
    required int sizeBytes,
    required String sha256,
    required DateTime capturedAt,
    required _is.UuidValue uploadedByUserId,
    required String uploadedByName,
    required DateTime registeredAt,
    bool? customerVisible,
  }) : super._(
         id: id,
         jobId: jobId,
         clientOpId: clientOpId,
         stage: stage,
         caption: caption,
         storagePath: storagePath,
         contentType: contentType,
         sizeBytes: sizeBytes,
         sha256: sha256,
         capturedAt: capturedAt,
         uploadedByUserId: uploadedByUserId,
         uploadedByName: uploadedByName,
         registeredAt: registeredAt,
         customerVisible: customerVisible,
       );

  /// Returns a shallow copy of this [EvidencePhoto]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EvidencePhoto copyWith({
    Object? id = _Undefined,
    int? jobId,
    _is.UuidValue? clientOpId,
    _izmwwpv6.PhotoStage? stage,
    Object? caption = _Undefined,
    Object? storagePath = _Undefined,
    String? contentType,
    int? sizeBytes,
    String? sha256,
    DateTime? capturedAt,
    _is.UuidValue? uploadedByUserId,
    String? uploadedByName,
    DateTime? registeredAt,
    bool? customerVisible,
  }) {
    return EvidencePhoto(
      id: id is int? ? id : this.id,
      jobId: jobId ?? this.jobId,
      clientOpId: clientOpId ?? this.clientOpId,
      stage: stage ?? this.stage,
      caption: caption is String? ? caption : this.caption,
      storagePath: storagePath is String? ? storagePath : this.storagePath,
      contentType: contentType ?? this.contentType,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      sha256: sha256 ?? this.sha256,
      capturedAt: capturedAt ?? this.capturedAt,
      uploadedByUserId: uploadedByUserId ?? this.uploadedByUserId,
      uploadedByName: uploadedByName ?? this.uploadedByName,
      registeredAt: registeredAt ?? this.registeredAt,
      customerVisible: customerVisible ?? this.customerVisible,
    );
  }
}

class EvidencePhotoUpdateTable extends _is.UpdateTable<EvidencePhotoTable> {
  EvidencePhotoUpdateTable(super.table);

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

  _is.ColumnValue<_izmwwpv6.PhotoStage, _izmwwpv6.PhotoStage> stage(
    _izmwwpv6.PhotoStage value,
  ) => _is.ColumnValue(
    table.stage,
    value,
  );

  _is.ColumnValue<String, String> caption(String? value) => _is.ColumnValue(
    table.caption,
    value,
  );

  _is.ColumnValue<String, String> storagePath(String? value) => _is.ColumnValue(
    table.storagePath,
    value,
  );

  _is.ColumnValue<String, String> contentType(String value) => _is.ColumnValue(
    table.contentType,
    value,
  );

  _is.ColumnValue<int, int> sizeBytes(int value) => _is.ColumnValue(
    table.sizeBytes,
    value,
  );

  _is.ColumnValue<String, String> sha256(String value) => _is.ColumnValue(
    table.sha256,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> capturedAt(DateTime value) =>
      _is.ColumnValue(
        table.capturedAt,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> uploadedByUserId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.uploadedByUserId,
    value,
  );

  _is.ColumnValue<String, String> uploadedByName(String value) =>
      _is.ColumnValue(
        table.uploadedByName,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> registeredAt(DateTime value) =>
      _is.ColumnValue(
        table.registeredAt,
        value,
      );

  _is.ColumnValue<bool, bool> customerVisible(bool value) => _is.ColumnValue(
    table.customerVisible,
    value,
  );
}

class EvidencePhotoTable extends _is.Table<int?> {
  EvidencePhotoTable({super.tableRelation})
    : super(tableName: 'evidence_photo') {
    updateTable = EvidencePhotoUpdateTable(this);
    jobId = _is.ColumnInt(
      'jobId',
      this,
    );
    clientOpId = _is.ColumnUuid(
      'clientOpId',
      this,
    );
    stage = _is.ColumnEnum(
      'stage',
      this,
      _is.EnumSerialization.byName,
    );
    caption = _is.ColumnString(
      'caption',
      this,
    );
    storagePath = _is.ColumnString(
      'storagePath',
      this,
    );
    contentType = _is.ColumnString(
      'contentType',
      this,
    );
    sizeBytes = _is.ColumnInt(
      'sizeBytes',
      this,
    );
    sha256 = _is.ColumnString(
      'sha256',
      this,
    );
    capturedAt = _is.ColumnDateTime(
      'capturedAt',
      this,
    );
    uploadedByUserId = _is.ColumnUuid(
      'uploadedByUserId',
      this,
    );
    uploadedByName = _is.ColumnString(
      'uploadedByName',
      this,
    );
    registeredAt = _is.ColumnDateTime(
      'registeredAt',
      this,
    );
    customerVisible = _is.ColumnBool(
      'customerVisible',
      this,
      hasDefault: true,
    );
  }

  late final EvidencePhotoUpdateTable updateTable;

  late final _is.ColumnInt jobId;

  late final _is.ColumnUuid clientOpId;

  late final _is.ColumnEnum<_izmwwpv6.PhotoStage> stage;

  late final _is.ColumnString caption;

  late final _is.ColumnString storagePath;

  late final _is.ColumnString contentType;

  late final _is.ColumnInt sizeBytes;

  late final _is.ColumnString sha256;

  late final _is.ColumnDateTime capturedAt;

  late final _is.ColumnUuid uploadedByUserId;

  late final _is.ColumnString uploadedByName;

  late final _is.ColumnDateTime registeredAt;

  late final _is.ColumnBool customerVisible;

  @override
  List<_is.Column> get columns => [
    id,
    jobId,
    clientOpId,
    stage,
    caption,
    storagePath,
    contentType,
    sizeBytes,
    sha256,
    capturedAt,
    uploadedByUserId,
    uploadedByName,
    registeredAt,
    customerVisible,
  ];
}

class EvidencePhotoInclude extends _is.IncludeObject {
  EvidencePhotoInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => EvidencePhoto.t;
}

class EvidencePhotoIncludeList extends _is.IncludeList {
  EvidencePhotoIncludeList._({
    _is.WhereExpressionBuilder<EvidencePhotoTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EvidencePhoto.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => EvidencePhoto.t;
}

class EvidencePhotoRepository {
  const EvidencePhotoRepository._();

  /// Returns a list of [EvidencePhoto]s matching the given query parameters.
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
  Future<List<EvidencePhoto>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EvidencePhotoTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EvidencePhotoTable>? orderBy,
    _is.OrderByListBuilder<EvidencePhotoTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EvidencePhoto>(
      where: where?.call(EvidencePhoto.t),
      orderBy: orderBy?.call(EvidencePhoto.t),
      orderByList: orderByList?.call(EvidencePhoto.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EvidencePhoto] matching the given query parameters.
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
  Future<EvidencePhoto?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EvidencePhotoTable>? where,
    int? offset,
    _is.OrderByBuilder<EvidencePhotoTable>? orderBy,
    _is.OrderByListBuilder<EvidencePhotoTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EvidencePhoto>(
      where: where?.call(EvidencePhoto.t),
      orderBy: orderBy?.call(EvidencePhoto.t),
      orderByList: orderByList?.call(EvidencePhoto.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EvidencePhoto] by its [id] or null if no such row exists.
  Future<EvidencePhoto?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EvidencePhoto>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EvidencePhoto]s in the list and returns the inserted rows.
  ///
  /// The returned [EvidencePhoto]s will have their `id` fields set.
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
  Future<List<EvidencePhoto>> insert(
    _is.DatabaseSession session,
    List<EvidencePhoto> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<EvidencePhoto>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [EvidencePhoto] and returns the inserted row.
  ///
  /// The returned [EvidencePhoto] will have its `id` field set.
  Future<EvidencePhoto> insertRow(
    _is.DatabaseSession session,
    EvidencePhoto row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<EvidencePhoto>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [EvidencePhoto]s in the list and returns the resulting rows.
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
  /// The returned [EvidencePhoto]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EvidencePhoto>> upsert(
    _is.DatabaseSession session,
    List<EvidencePhoto> rows, {
    required _is.ColumnSelections<EvidencePhotoTable> conflictColumns,
    _is.ColumnSelections<EvidencePhotoTable>? updateColumns,
    _is.WhereExpressionBuilder<EvidencePhotoTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<EvidencePhoto>(
      rows,
      conflictColumns: conflictColumns(EvidencePhoto.t),
      updateColumns: updateColumns?.call(EvidencePhoto.t),
      updateWhere: updateWhere?.call(EvidencePhoto.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [EvidencePhoto] and returns the resulting row.
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
  /// The returned [EvidencePhoto] will have its `id` field set.
  Future<EvidencePhoto?> upsertRow(
    _is.DatabaseSession session,
    EvidencePhoto row, {
    required _is.ColumnSelections<EvidencePhotoTable> conflictColumns,
    _is.ColumnSelections<EvidencePhotoTable>? updateColumns,
    _is.WhereExpressionBuilder<EvidencePhotoTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<EvidencePhoto>(
      row,
      conflictColumns: conflictColumns(EvidencePhoto.t),
      updateColumns: updateColumns?.call(EvidencePhoto.t),
      updateWhere: updateWhere?.call(EvidencePhoto.t),
      transaction: transaction,
    );
  }

  /// Updates all [EvidencePhoto]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EvidencePhoto>> update(
    _is.DatabaseSession session,
    List<EvidencePhoto> rows, {
    _is.ColumnSelections<EvidencePhotoTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<EvidencePhoto>(
      rows,
      columns: columns?.call(EvidencePhoto.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [EvidencePhoto]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EvidencePhoto> updateRow(
    _is.DatabaseSession session,
    EvidencePhoto row, {
    _is.ColumnSelections<EvidencePhotoTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<EvidencePhoto>(
      row,
      columns: columns?.call(EvidencePhoto.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EvidencePhoto] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EvidencePhoto?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<EvidencePhotoUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<EvidencePhoto>(
      id,
      columnValues: columnValues(EvidencePhoto.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EvidencePhoto]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<EvidencePhoto>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<EvidencePhotoUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<EvidencePhotoTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<EvidencePhotoTable>? orderBy,
    _is.OrderByListBuilder<EvidencePhotoTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<EvidencePhoto>(
      columnValues: columnValues(EvidencePhoto.t.updateTable),
      where: where(EvidencePhoto.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EvidencePhoto.t),
      orderByList: orderByList?.call(EvidencePhoto.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [EvidencePhoto]s in the list and returns the deleted rows.
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
  Future<List<EvidencePhoto>> delete(
    _is.DatabaseSession session,
    List<EvidencePhoto> rows, {
    _is.OrderByBuilder<EvidencePhotoTable>? orderBy,
    _is.OrderByListBuilder<EvidencePhotoTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<EvidencePhoto>(
      rows,
      orderBy: orderBy?.call(EvidencePhoto.t),
      orderByList: orderByList?.call(EvidencePhoto.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [EvidencePhoto].
  Future<EvidencePhoto> deleteRow(
    _is.DatabaseSession session,
    EvidencePhoto row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EvidencePhoto>(
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
  Future<List<EvidencePhoto>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EvidencePhotoTable> where,
    _is.OrderByBuilder<EvidencePhotoTable>? orderBy,
    _is.OrderByListBuilder<EvidencePhotoTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<EvidencePhoto>(
      where: where(EvidencePhoto.t),
      orderBy: orderBy?.call(EvidencePhoto.t),
      orderByList: orderByList?.call(EvidencePhoto.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<EvidencePhotoTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<EvidencePhoto>(
      where: where?.call(EvidencePhoto.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EvidencePhoto] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<EvidencePhotoTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EvidencePhoto>(
      where: where(EvidencePhoto.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
