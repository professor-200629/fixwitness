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
import 'job_status.dart' as _iayt1i3u;

abstract class RepairJob
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RepairJob._({
    this.id,
    required this.shopId,
    required this.jobNumber,
    required this.clientOpId,
    required this.customerName,
    required this.customerPhone,
    required this.deviceMake,
    required this.deviceModel,
    this.deviceSerial,
    required this.reportedFault,
    this.accessories,
    required this.status,
    int? rowVersion,
    int? eventSeq,
    this.currentEstimateId,
    this.authorizedEstimateId,
    required this.createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.completedAt,
    this.collectedAt,
  }) : rowVersion = rowVersion ?? 1,
       eventSeq = eventSeq ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory RepairJob({
    int? id,
    required int shopId,
    required int jobNumber,
    required _is.UuidValue clientOpId,
    required String customerName,
    required String customerPhone,
    required String deviceMake,
    required String deviceModel,
    String? deviceSerial,
    required String reportedFault,
    String? accessories,
    required _iayt1i3u.JobStatus status,
    int? rowVersion,
    int? eventSeq,
    int? currentEstimateId,
    int? authorizedEstimateId,
    required _is.UuidValue createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
    DateTime? collectedAt,
  }) = _RepairJobImpl;

  factory RepairJob.fromJson(Map<String, dynamic> jsonSerialization) {
    return RepairJob(
      id: jsonSerialization['id'] as int?,
      shopId: jsonSerialization['shopId'] as int,
      jobNumber: jsonSerialization['jobNumber'] as int,
      clientOpId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['clientOpId'],
      ),
      customerName: jsonSerialization['customerName'] as String,
      customerPhone: jsonSerialization['customerPhone'] as String,
      deviceMake: jsonSerialization['deviceMake'] as String,
      deviceModel: jsonSerialization['deviceModel'] as String,
      deviceSerial: jsonSerialization['deviceSerial'] as String?,
      reportedFault: jsonSerialization['reportedFault'] as String,
      accessories: jsonSerialization['accessories'] as String?,
      status: _iayt1i3u.JobStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      rowVersion: jsonSerialization['rowVersion'] as int?,
      eventSeq: jsonSerialization['eventSeq'] as int?,
      currentEstimateId: jsonSerialization['currentEstimateId'] as int?,
      authorizedEstimateId: jsonSerialization['authorizedEstimateId'] as int?,
      createdByUserId: _is.UuidValueJsonExtension.fromJson(
        jsonSerialization['createdByUserId'],
      ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      collectedAt: jsonSerialization['collectedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['collectedAt'],
            ),
    );
  }

  static final t = RepairJobTable();

  static const db = RepairJobRepository._();

  @override
  int? id;

  int shopId;

  /// Human-facing number, unique within the shop.
  int jobNumber;

  /// Operation id from the device that created the job; makes creation idempotent.
  _is.UuidValue clientOpId;

  String customerName;

  String customerPhone;

  String deviceMake;

  String deviceModel;

  /// IMEI or serial as printed on the device. Never a passcode.
  String? deviceSerial;

  String reportedFault;

  String? accessories;

  _iayt1i3u.JobStatus status;

  /// Incremented by every state change; lets clients detect stale views.
  int rowVersion;

  /// Last JobEvent.seq written for this job.
  int eventSeq;

  /// Latest issued estimate (any status).
  int? currentEstimateId;

  /// Latest estimate the customer approved. Work beyond it is not authorized.
  int? authorizedEstimateId;

  _is.UuidValue createdByUserId;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? completedAt;

  DateTime? collectedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RepairJob]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RepairJob copyWith({
    int? id,
    int? shopId,
    int? jobNumber,
    _is.UuidValue? clientOpId,
    String? customerName,
    String? customerPhone,
    String? deviceMake,
    String? deviceModel,
    String? deviceSerial,
    String? reportedFault,
    String? accessories,
    _iayt1i3u.JobStatus? status,
    int? rowVersion,
    int? eventSeq,
    int? currentEstimateId,
    int? authorizedEstimateId,
    _is.UuidValue? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
    DateTime? collectedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RepairJob',
      if (id != null) 'id': id,
      'shopId': shopId,
      'jobNumber': jobNumber,
      'clientOpId': clientOpId.toJson(),
      'customerName': customerName,
      'customerPhone': customerPhone,
      'deviceMake': deviceMake,
      'deviceModel': deviceModel,
      if (deviceSerial != null) 'deviceSerial': deviceSerial,
      'reportedFault': reportedFault,
      if (accessories != null) 'accessories': accessories,
      'status': status.toJson(),
      'rowVersion': rowVersion,
      'eventSeq': eventSeq,
      if (currentEstimateId != null) 'currentEstimateId': currentEstimateId,
      if (authorizedEstimateId != null)
        'authorizedEstimateId': authorizedEstimateId,
      'createdByUserId': createdByUserId.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (collectedAt != null) 'collectedAt': collectedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RepairJob',
      if (id != null) 'id': id,
      'shopId': shopId,
      'jobNumber': jobNumber,
      'clientOpId': clientOpId.toJson(),
      'customerName': customerName,
      'customerPhone': customerPhone,
      'deviceMake': deviceMake,
      'deviceModel': deviceModel,
      if (deviceSerial != null) 'deviceSerial': deviceSerial,
      'reportedFault': reportedFault,
      if (accessories != null) 'accessories': accessories,
      'status': status.toJson(),
      'rowVersion': rowVersion,
      'eventSeq': eventSeq,
      if (currentEstimateId != null) 'currentEstimateId': currentEstimateId,
      if (authorizedEstimateId != null)
        'authorizedEstimateId': authorizedEstimateId,
      'createdByUserId': createdByUserId.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (collectedAt != null) 'collectedAt': collectedAt?.toJson(),
    };
  }

  static RepairJobInclude include() {
    return RepairJobInclude._();
  }

  static RepairJobIncludeList includeList({
    _is.WhereExpressionBuilder<RepairJobTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RepairJobTable>? orderBy,
    _is.OrderByListBuilder<RepairJobTable>? orderByList,
    RepairJobInclude? include,
  }) {
    return RepairJobIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RepairJob.t),
      orderByList: orderByList?.call(RepairJob.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RepairJobImpl extends RepairJob {
  _RepairJobImpl({
    int? id,
    required int shopId,
    required int jobNumber,
    required _is.UuidValue clientOpId,
    required String customerName,
    required String customerPhone,
    required String deviceMake,
    required String deviceModel,
    String? deviceSerial,
    required String reportedFault,
    String? accessories,
    required _iayt1i3u.JobStatus status,
    int? rowVersion,
    int? eventSeq,
    int? currentEstimateId,
    int? authorizedEstimateId,
    required _is.UuidValue createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
    DateTime? collectedAt,
  }) : super._(
         id: id,
         shopId: shopId,
         jobNumber: jobNumber,
         clientOpId: clientOpId,
         customerName: customerName,
         customerPhone: customerPhone,
         deviceMake: deviceMake,
         deviceModel: deviceModel,
         deviceSerial: deviceSerial,
         reportedFault: reportedFault,
         accessories: accessories,
         status: status,
         rowVersion: rowVersion,
         eventSeq: eventSeq,
         currentEstimateId: currentEstimateId,
         authorizedEstimateId: authorizedEstimateId,
         createdByUserId: createdByUserId,
         createdAt: createdAt,
         updatedAt: updatedAt,
         completedAt: completedAt,
         collectedAt: collectedAt,
       );

  /// Returns a shallow copy of this [RepairJob]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RepairJob copyWith({
    Object? id = _Undefined,
    int? shopId,
    int? jobNumber,
    _is.UuidValue? clientOpId,
    String? customerName,
    String? customerPhone,
    String? deviceMake,
    String? deviceModel,
    Object? deviceSerial = _Undefined,
    String? reportedFault,
    Object? accessories = _Undefined,
    _iayt1i3u.JobStatus? status,
    int? rowVersion,
    int? eventSeq,
    Object? currentEstimateId = _Undefined,
    Object? authorizedEstimateId = _Undefined,
    _is.UuidValue? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? completedAt = _Undefined,
    Object? collectedAt = _Undefined,
  }) {
    return RepairJob(
      id: id is int? ? id : this.id,
      shopId: shopId ?? this.shopId,
      jobNumber: jobNumber ?? this.jobNumber,
      clientOpId: clientOpId ?? this.clientOpId,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      deviceMake: deviceMake ?? this.deviceMake,
      deviceModel: deviceModel ?? this.deviceModel,
      deviceSerial: deviceSerial is String? ? deviceSerial : this.deviceSerial,
      reportedFault: reportedFault ?? this.reportedFault,
      accessories: accessories is String? ? accessories : this.accessories,
      status: status ?? this.status,
      rowVersion: rowVersion ?? this.rowVersion,
      eventSeq: eventSeq ?? this.eventSeq,
      currentEstimateId: currentEstimateId is int?
          ? currentEstimateId
          : this.currentEstimateId,
      authorizedEstimateId: authorizedEstimateId is int?
          ? authorizedEstimateId
          : this.authorizedEstimateId,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      collectedAt: collectedAt is DateTime? ? collectedAt : this.collectedAt,
    );
  }
}

class RepairJobUpdateTable extends _is.UpdateTable<RepairJobTable> {
  RepairJobUpdateTable(super.table);

  _is.ColumnValue<int, int> shopId(int value) => _is.ColumnValue(
    table.shopId,
    value,
  );

  _is.ColumnValue<int, int> jobNumber(int value) => _is.ColumnValue(
    table.jobNumber,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> clientOpId(
    _is.UuidValue value,
  ) => _is.ColumnValue(
    table.clientOpId,
    value,
  );

  _is.ColumnValue<String, String> customerName(String value) => _is.ColumnValue(
    table.customerName,
    value,
  );

  _is.ColumnValue<String, String> customerPhone(String value) =>
      _is.ColumnValue(
        table.customerPhone,
        value,
      );

  _is.ColumnValue<String, String> deviceMake(String value) => _is.ColumnValue(
    table.deviceMake,
    value,
  );

  _is.ColumnValue<String, String> deviceModel(String value) => _is.ColumnValue(
    table.deviceModel,
    value,
  );

  _is.ColumnValue<String, String> deviceSerial(String? value) =>
      _is.ColumnValue(
        table.deviceSerial,
        value,
      );

  _is.ColumnValue<String, String> reportedFault(String value) =>
      _is.ColumnValue(
        table.reportedFault,
        value,
      );

  _is.ColumnValue<String, String> accessories(String? value) => _is.ColumnValue(
    table.accessories,
    value,
  );

  _is.ColumnValue<_iayt1i3u.JobStatus, _iayt1i3u.JobStatus> status(
    _iayt1i3u.JobStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<int, int> rowVersion(int value) => _is.ColumnValue(
    table.rowVersion,
    value,
  );

  _is.ColumnValue<int, int> eventSeq(int value) => _is.ColumnValue(
    table.eventSeq,
    value,
  );

  _is.ColumnValue<int, int> currentEstimateId(int? value) => _is.ColumnValue(
    table.currentEstimateId,
    value,
  );

  _is.ColumnValue<int, int> authorizedEstimateId(int? value) => _is.ColumnValue(
    table.authorizedEstimateId,
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

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _is.ColumnValue(
        table.completedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> collectedAt(DateTime? value) =>
      _is.ColumnValue(
        table.collectedAt,
        value,
      );
}

class RepairJobTable extends _is.Table<int?> {
  RepairJobTable({super.tableRelation}) : super(tableName: 'repair_job') {
    updateTable = RepairJobUpdateTable(this);
    shopId = _is.ColumnInt(
      'shopId',
      this,
    );
    jobNumber = _is.ColumnInt(
      'jobNumber',
      this,
    );
    clientOpId = _is.ColumnUuid(
      'clientOpId',
      this,
    );
    customerName = _is.ColumnString(
      'customerName',
      this,
    );
    customerPhone = _is.ColumnString(
      'customerPhone',
      this,
    );
    deviceMake = _is.ColumnString(
      'deviceMake',
      this,
    );
    deviceModel = _is.ColumnString(
      'deviceModel',
      this,
    );
    deviceSerial = _is.ColumnString(
      'deviceSerial',
      this,
    );
    reportedFault = _is.ColumnString(
      'reportedFault',
      this,
    );
    accessories = _is.ColumnString(
      'accessories',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    rowVersion = _is.ColumnInt(
      'rowVersion',
      this,
      hasDefault: true,
    );
    eventSeq = _is.ColumnInt(
      'eventSeq',
      this,
      hasDefault: true,
    );
    currentEstimateId = _is.ColumnInt(
      'currentEstimateId',
      this,
    );
    authorizedEstimateId = _is.ColumnInt(
      'authorizedEstimateId',
      this,
    );
    createdByUserId = _is.ColumnUuid(
      'createdByUserId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
    completedAt = _is.ColumnDateTime(
      'completedAt',
      this,
    );
    collectedAt = _is.ColumnDateTime(
      'collectedAt',
      this,
    );
  }

  late final RepairJobUpdateTable updateTable;

  late final _is.ColumnInt shopId;

  /// Human-facing number, unique within the shop.
  late final _is.ColumnInt jobNumber;

  /// Operation id from the device that created the job; makes creation idempotent.
  late final _is.ColumnUuid clientOpId;

  late final _is.ColumnString customerName;

  late final _is.ColumnString customerPhone;

  late final _is.ColumnString deviceMake;

  late final _is.ColumnString deviceModel;

  /// IMEI or serial as printed on the device. Never a passcode.
  late final _is.ColumnString deviceSerial;

  late final _is.ColumnString reportedFault;

  late final _is.ColumnString accessories;

  late final _is.ColumnEnum<_iayt1i3u.JobStatus> status;

  /// Incremented by every state change; lets clients detect stale views.
  late final _is.ColumnInt rowVersion;

  /// Last JobEvent.seq written for this job.
  late final _is.ColumnInt eventSeq;

  /// Latest issued estimate (any status).
  late final _is.ColumnInt currentEstimateId;

  /// Latest estimate the customer approved. Work beyond it is not authorized.
  late final _is.ColumnInt authorizedEstimateId;

  late final _is.ColumnUuid createdByUserId;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnDateTime completedAt;

  late final _is.ColumnDateTime collectedAt;

  @override
  List<_is.Column> get columns => [
    id,
    shopId,
    jobNumber,
    clientOpId,
    customerName,
    customerPhone,
    deviceMake,
    deviceModel,
    deviceSerial,
    reportedFault,
    accessories,
    status,
    rowVersion,
    eventSeq,
    currentEstimateId,
    authorizedEstimateId,
    createdByUserId,
    createdAt,
    updatedAt,
    completedAt,
    collectedAt,
  ];
}

class RepairJobInclude extends _is.IncludeObject {
  RepairJobInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RepairJob.t;
}

class RepairJobIncludeList extends _is.IncludeList {
  RepairJobIncludeList._({
    _is.WhereExpressionBuilder<RepairJobTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RepairJob.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RepairJob.t;
}

class RepairJobRepository {
  const RepairJobRepository._();

  /// Returns a list of [RepairJob]s matching the given query parameters.
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
  Future<List<RepairJob>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RepairJobTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RepairJobTable>? orderBy,
    _is.OrderByListBuilder<RepairJobTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RepairJob>(
      where: where?.call(RepairJob.t),
      orderBy: orderBy?.call(RepairJob.t),
      orderByList: orderByList?.call(RepairJob.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [RepairJob] matching the given query parameters.
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
  Future<RepairJob?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RepairJobTable>? where,
    int? offset,
    _is.OrderByBuilder<RepairJobTable>? orderBy,
    _is.OrderByListBuilder<RepairJobTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RepairJob>(
      where: where?.call(RepairJob.t),
      orderBy: orderBy?.call(RepairJob.t),
      orderByList: orderByList?.call(RepairJob.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RepairJob] by its [id] or null if no such row exists.
  Future<RepairJob?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RepairJob>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RepairJob]s in the list and returns the inserted rows.
  ///
  /// The returned [RepairJob]s will have their `id` fields set.
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
  Future<List<RepairJob>> insert(
    _is.DatabaseSession session,
    List<RepairJob> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RepairJob>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RepairJob] and returns the inserted row.
  ///
  /// The returned [RepairJob] will have its `id` field set.
  Future<RepairJob> insertRow(
    _is.DatabaseSession session,
    RepairJob row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RepairJob>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RepairJob]s in the list and returns the resulting rows.
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
  /// The returned [RepairJob]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RepairJob>> upsert(
    _is.DatabaseSession session,
    List<RepairJob> rows, {
    required _is.ColumnSelections<RepairJobTable> conflictColumns,
    _is.ColumnSelections<RepairJobTable>? updateColumns,
    _is.WhereExpressionBuilder<RepairJobTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RepairJob>(
      rows,
      conflictColumns: conflictColumns(RepairJob.t),
      updateColumns: updateColumns?.call(RepairJob.t),
      updateWhere: updateWhere?.call(RepairJob.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RepairJob] and returns the resulting row.
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
  /// The returned [RepairJob] will have its `id` field set.
  Future<RepairJob?> upsertRow(
    _is.DatabaseSession session,
    RepairJob row, {
    required _is.ColumnSelections<RepairJobTable> conflictColumns,
    _is.ColumnSelections<RepairJobTable>? updateColumns,
    _is.WhereExpressionBuilder<RepairJobTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RepairJob>(
      row,
      conflictColumns: conflictColumns(RepairJob.t),
      updateColumns: updateColumns?.call(RepairJob.t),
      updateWhere: updateWhere?.call(RepairJob.t),
      transaction: transaction,
    );
  }

  /// Updates all [RepairJob]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RepairJob>> update(
    _is.DatabaseSession session,
    List<RepairJob> rows, {
    _is.ColumnSelections<RepairJobTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RepairJob>(
      rows,
      columns: columns?.call(RepairJob.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RepairJob]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RepairJob> updateRow(
    _is.DatabaseSession session,
    RepairJob row, {
    _is.ColumnSelections<RepairJobTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RepairJob>(
      row,
      columns: columns?.call(RepairJob.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RepairJob] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RepairJob?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RepairJobUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RepairJob>(
      id,
      columnValues: columnValues(RepairJob.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RepairJob]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RepairJob>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RepairJobUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RepairJobTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RepairJobTable>? orderBy,
    _is.OrderByListBuilder<RepairJobTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RepairJob>(
      columnValues: columnValues(RepairJob.t.updateTable),
      where: where(RepairJob.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RepairJob.t),
      orderByList: orderByList?.call(RepairJob.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RepairJob]s in the list and returns the deleted rows.
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
  Future<List<RepairJob>> delete(
    _is.DatabaseSession session,
    List<RepairJob> rows, {
    _is.OrderByBuilder<RepairJobTable>? orderBy,
    _is.OrderByListBuilder<RepairJobTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RepairJob>(
      rows,
      orderBy: orderBy?.call(RepairJob.t),
      orderByList: orderByList?.call(RepairJob.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RepairJob].
  Future<RepairJob> deleteRow(
    _is.DatabaseSession session,
    RepairJob row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RepairJob>(
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
  Future<List<RepairJob>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RepairJobTable> where,
    _is.OrderByBuilder<RepairJobTable>? orderBy,
    _is.OrderByListBuilder<RepairJobTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RepairJob>(
      where: where(RepairJob.t),
      orderBy: orderBy?.call(RepairJob.t),
      orderByList: orderByList?.call(RepairJob.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RepairJobTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RepairJob>(
      where: where?.call(RepairJob.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RepairJob] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RepairJobTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RepairJob>(
      where: where(RepairJob.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
