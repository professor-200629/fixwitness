/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fixwitness_client/src/protocol/condition_item.dart'
    as _i0gfe87e;
import 'package:fixwitness_client/src/protocol/estimate_line.dart' as _io8rligr;
import 'package:fixwitness_client/src/protocol/job_summary.dart' as _idiw8vex;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:serverpod_database/serverpod_database.dart' as _isd;
import 'actor_kind.dart' as _ijpkiimy;
import 'authorization_state.dart' as _iw8m4vnd;
import 'cached_job.dart' as _it221bl6;
import 'condition_item.dart' as _i5ylibdu;
import 'condition_report.dart' as _ipz1s64e;
import 'condition_state.dart' as _ikr1mj9r;
import 'created_link.dart' as _icsad0ww;
import 'customer_job_view.dart' as _icgd0pnr;
import 'customer_link.dart' as _iwkslo03;
import 'customer_photo.dart' as _i4ormwf5;
import 'decision_kind.dart' as _i21mg86q;
import 'estimate.dart' as _ilvyut6l;
import 'estimate_decision.dart' as _imiq6wyq;
import 'estimate_line.dart' as _icm2x340;
import 'estimate_status.dart' as _i3t4a52c;
import 'evidence_photo.dart' as _ik1uvvpd;
import 'fw_error_code.dart' as _i49jwhm1;
import 'fw_exception.dart' as _i8jn2jtm;
import 'job_detail.dart' as _ijlfhm28;
import 'job_event.dart' as _ixn72kw5;
import 'job_event_type.dart' as _iwt0hck5;
import 'job_note.dart' as _iaz1asnu;
import 'job_status.dart' as _iayt1i3u;
import 'job_summary.dart' as _ieitn8yx;
import 'line_kind.dart' as _ihrvi1k4;
import 'new_job_input.dart' as _iqofyfch;
import 'op_kind.dart' as _isgnykvt;
import 'op_status.dart' as _icbsweww;
import 'pending_operation.dart' as _igyp3o5l;
import 'photo_stage.dart' as _izmwwpv6;
import 'photo_upload_ticket.dart' as _ivh14x5g;
import 'repair_job.dart' as _ibfrpqb8;
import 'shop.dart' as _isgf2ncs;
import 'shop_context.dart' as _inmn8lg4;
import 'shop_member.dart' as _ip7etvmn;
import 'shop_role.dart' as _inr72q68;
export 'actor_kind.dart';
export 'authorization_state.dart';
export 'cached_job.dart';
export 'condition_item.dart';
export 'condition_report.dart';
export 'condition_state.dart';
export 'created_link.dart';
export 'customer_job_view.dart';
export 'customer_link.dart';
export 'customer_photo.dart';
export 'decision_kind.dart';
export 'estimate.dart';
export 'estimate_decision.dart';
export 'estimate_line.dart';
export 'estimate_status.dart';
export 'evidence_photo.dart';
export 'fw_error_code.dart';
export 'fw_exception.dart';
export 'job_detail.dart';
export 'job_event.dart';
export 'job_event_type.dart';
export 'job_note.dart';
export 'job_status.dart';
export 'job_summary.dart';
export 'line_kind.dart';
export 'new_job_input.dart';
export 'op_kind.dart';
export 'op_status.dart';
export 'pending_operation.dart';
export 'photo_stage.dart';
export 'photo_upload_ticket.dart';
export 'repair_job.dart';
export 'shop.dart';
export 'shop_context.dart';
export 'shop_member.dart';
export 'shop_role.dart';
export 'client.dart';

class Protocol extends _isd.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isd.TableDefinition> get targetTableDefinitions => [
    _isd.TableDefinition(
      name: 'cached_job',
      dartName: 'CachedJob',
      schema: 'public',
      module: 'fixwitness',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isd.ColumnDefinition(
          name: 'serverJobId',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isd.ColumnDefinition(
          name: 'jobNumber',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isd.ColumnDefinition(
          name: 'summaryJson',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'detailJson',
          columnType: _isd.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isd.ColumnDefinition(
          name: 'cachedAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isd.IndexDefinition(
          indexName: 'cached_job_server_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
              definition: 'serverJobId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isd.TableDefinition(
      name: 'pending_operation',
      dartName: 'PendingOperation',
      schema: 'public',
      module: 'fixwitness',
      columns: [
        _isd.ColumnDefinition(
          name: 'id',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isd.ColumnDefinition(
          name: 'opId',
          columnType: _isd.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isd.ColumnDefinition(
          name: 'kind',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:OpKind',
        ),
        _isd.ColumnDefinition(
          name: 'status',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:OpStatus',
        ),
        _isd.ColumnDefinition(
          name: 'serverJobId',
          columnType: _isd.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isd.ColumnDefinition(
          name: 'parentOpId',
          columnType: _isd.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isd.ColumnDefinition(
          name: 'payloadJson',
          columnType: _isd.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isd.ColumnDefinition(
          name: 'localFilePath',
          columnType: _isd.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isd.ColumnDefinition(
          name: 'uploadDone',
          columnType: _isd.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isd.ColumnDefinition(
          name: 'attempts',
          columnType: _isd.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isd.ColumnDefinition(
          name: 'lastError',
          columnType: _isd.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isd.ColumnDefinition(
          name: 'resultId',
          columnType: _isd.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isd.ColumnDefinition(
          name: 'createdAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isd.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isd.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isd.IndexDefinition(
          indexName: 'pending_operation_op_idx',
          tableSpace: null,
          elements: [
            _isd.IndexElementDefinition(
              type: _isd.IndexElementDefinitionType.column,
              definition: 'opId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iaic.Protocol() is _isd.DatabaseSerializationManager
        ? (_iaic.Protocol() as _isd.DatabaseSerializationManager)
              .getTargetTableDefinitions()
        : [],
    ..._iacc.Protocol() is _isd.DatabaseSerializationManager
        ? (_iacc.Protocol() as _isd.DatabaseSerializationManager)
              .getTargetTableDefinitions()
        : [],
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _ijpkiimy.ActorKind) {
      return _ijpkiimy.ActorKind.fromJson(data) as T;
    }
    if (t == _iw8m4vnd.AuthorizationState) {
      return _iw8m4vnd.AuthorizationState.fromJson(data) as T;
    }
    if (t == _it221bl6.CachedJob) {
      return _it221bl6.CachedJob.fromJson(data) as T;
    }
    if (t == _i5ylibdu.ConditionItem) {
      return _i5ylibdu.ConditionItem.fromJson(data) as T;
    }
    if (t == _ipz1s64e.ConditionReport) {
      return _ipz1s64e.ConditionReport.fromJson(data) as T;
    }
    if (t == _ikr1mj9r.ConditionState) {
      return _ikr1mj9r.ConditionState.fromJson(data) as T;
    }
    if (t == _icsad0ww.CreatedLink) {
      return _icsad0ww.CreatedLink.fromJson(data) as T;
    }
    if (t == _icgd0pnr.CustomerJobView) {
      return _icgd0pnr.CustomerJobView.fromJson(data) as T;
    }
    if (t == _iwkslo03.CustomerLink) {
      return _iwkslo03.CustomerLink.fromJson(data) as T;
    }
    if (t == _i4ormwf5.CustomerPhoto) {
      return _i4ormwf5.CustomerPhoto.fromJson(data) as T;
    }
    if (t == _i21mg86q.DecisionKind) {
      return _i21mg86q.DecisionKind.fromJson(data) as T;
    }
    if (t == _ilvyut6l.Estimate) {
      return _ilvyut6l.Estimate.fromJson(data) as T;
    }
    if (t == _imiq6wyq.EstimateDecision) {
      return _imiq6wyq.EstimateDecision.fromJson(data) as T;
    }
    if (t == _icm2x340.EstimateLine) {
      return _icm2x340.EstimateLine.fromJson(data) as T;
    }
    if (t == _i3t4a52c.EstimateStatus) {
      return _i3t4a52c.EstimateStatus.fromJson(data) as T;
    }
    if (t == _ik1uvvpd.EvidencePhoto) {
      return _ik1uvvpd.EvidencePhoto.fromJson(data) as T;
    }
    if (t == _i49jwhm1.FwErrorCode) {
      return _i49jwhm1.FwErrorCode.fromJson(data) as T;
    }
    if (t == _i8jn2jtm.FwException) {
      return _i8jn2jtm.FwException.fromJson(data) as T;
    }
    if (t == _ijlfhm28.JobDetail) {
      return _ijlfhm28.JobDetail.fromJson(data) as T;
    }
    if (t == _ixn72kw5.JobEvent) {
      return _ixn72kw5.JobEvent.fromJson(data) as T;
    }
    if (t == _iwt0hck5.JobEventType) {
      return _iwt0hck5.JobEventType.fromJson(data) as T;
    }
    if (t == _iaz1asnu.JobNote) {
      return _iaz1asnu.JobNote.fromJson(data) as T;
    }
    if (t == _iayt1i3u.JobStatus) {
      return _iayt1i3u.JobStatus.fromJson(data) as T;
    }
    if (t == _ieitn8yx.JobSummary) {
      return _ieitn8yx.JobSummary.fromJson(data) as T;
    }
    if (t == _ihrvi1k4.LineKind) {
      return _ihrvi1k4.LineKind.fromJson(data) as T;
    }
    if (t == _iqofyfch.NewJobInput) {
      return _iqofyfch.NewJobInput.fromJson(data) as T;
    }
    if (t == _isgnykvt.OpKind) {
      return _isgnykvt.OpKind.fromJson(data) as T;
    }
    if (t == _icbsweww.OpStatus) {
      return _icbsweww.OpStatus.fromJson(data) as T;
    }
    if (t == _igyp3o5l.PendingOperation) {
      return _igyp3o5l.PendingOperation.fromJson(data) as T;
    }
    if (t == _izmwwpv6.PhotoStage) {
      return _izmwwpv6.PhotoStage.fromJson(data) as T;
    }
    if (t == _ivh14x5g.PhotoUploadTicket) {
      return _ivh14x5g.PhotoUploadTicket.fromJson(data) as T;
    }
    if (t == _ibfrpqb8.RepairJob) {
      return _ibfrpqb8.RepairJob.fromJson(data) as T;
    }
    if (t == _isgf2ncs.Shop) {
      return _isgf2ncs.Shop.fromJson(data) as T;
    }
    if (t == _inmn8lg4.ShopContext) {
      return _inmn8lg4.ShopContext.fromJson(data) as T;
    }
    if (t == _ip7etvmn.ShopMember) {
      return _ip7etvmn.ShopMember.fromJson(data) as T;
    }
    if (t == _inr72q68.ShopRole) {
      return _inr72q68.ShopRole.fromJson(data) as T;
    }
    if (t == _isc.getType<_ijpkiimy.ActorKind?>()) {
      return (data != null ? _ijpkiimy.ActorKind.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iw8m4vnd.AuthorizationState?>()) {
      return (data != null ? _iw8m4vnd.AuthorizationState.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_it221bl6.CachedJob?>()) {
      return (data != null ? _it221bl6.CachedJob.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i5ylibdu.ConditionItem?>()) {
      return (data != null ? _i5ylibdu.ConditionItem.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ipz1s64e.ConditionReport?>()) {
      return (data != null ? _ipz1s64e.ConditionReport.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ikr1mj9r.ConditionState?>()) {
      return (data != null ? _ikr1mj9r.ConditionState.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_icsad0ww.CreatedLink?>()) {
      return (data != null ? _icsad0ww.CreatedLink.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_icgd0pnr.CustomerJobView?>()) {
      return (data != null ? _icgd0pnr.CustomerJobView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iwkslo03.CustomerLink?>()) {
      return (data != null ? _iwkslo03.CustomerLink.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i4ormwf5.CustomerPhoto?>()) {
      return (data != null ? _i4ormwf5.CustomerPhoto.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i21mg86q.DecisionKind?>()) {
      return (data != null ? _i21mg86q.DecisionKind.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ilvyut6l.Estimate?>()) {
      return (data != null ? _ilvyut6l.Estimate.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_imiq6wyq.EstimateDecision?>()) {
      return (data != null ? _imiq6wyq.EstimateDecision.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_icm2x340.EstimateLine?>()) {
      return (data != null ? _icm2x340.EstimateLine.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i3t4a52c.EstimateStatus?>()) {
      return (data != null ? _i3t4a52c.EstimateStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ik1uvvpd.EvidencePhoto?>()) {
      return (data != null ? _ik1uvvpd.EvidencePhoto.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i49jwhm1.FwErrorCode?>()) {
      return (data != null ? _i49jwhm1.FwErrorCode.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i8jn2jtm.FwException?>()) {
      return (data != null ? _i8jn2jtm.FwException.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ijlfhm28.JobDetail?>()) {
      return (data != null ? _ijlfhm28.JobDetail.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ixn72kw5.JobEvent?>()) {
      return (data != null ? _ixn72kw5.JobEvent.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iwt0hck5.JobEventType?>()) {
      return (data != null ? _iwt0hck5.JobEventType.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iaz1asnu.JobNote?>()) {
      return (data != null ? _iaz1asnu.JobNote.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iayt1i3u.JobStatus?>()) {
      return (data != null ? _iayt1i3u.JobStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ieitn8yx.JobSummary?>()) {
      return (data != null ? _ieitn8yx.JobSummary.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ihrvi1k4.LineKind?>()) {
      return (data != null ? _ihrvi1k4.LineKind.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iqofyfch.NewJobInput?>()) {
      return (data != null ? _iqofyfch.NewJobInput.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_isgnykvt.OpKind?>()) {
      return (data != null ? _isgnykvt.OpKind.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_icbsweww.OpStatus?>()) {
      return (data != null ? _icbsweww.OpStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_igyp3o5l.PendingOperation?>()) {
      return (data != null ? _igyp3o5l.PendingOperation.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_izmwwpv6.PhotoStage?>()) {
      return (data != null ? _izmwwpv6.PhotoStage.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ivh14x5g.PhotoUploadTicket?>()) {
      return (data != null ? _ivh14x5g.PhotoUploadTicket.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ibfrpqb8.RepairJob?>()) {
      return (data != null ? _ibfrpqb8.RepairJob.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_isgf2ncs.Shop?>()) {
      return (data != null ? _isgf2ncs.Shop.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_inmn8lg4.ShopContext?>()) {
      return (data != null ? _inmn8lg4.ShopContext.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ip7etvmn.ShopMember?>()) {
      return (data != null ? _ip7etvmn.ShopMember.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_inr72q68.ShopRole?>()) {
      return (data != null ? _inr72q68.ShopRole.fromJson(data) : null) as T;
    }
    if (t == List<_i5ylibdu.ConditionItem>) {
      return (data as List)
              .map((e) => deserialize<_i5ylibdu.ConditionItem>(e))
              .toList()
          as T;
    }
    if (t == List<_ilvyut6l.Estimate>) {
      return (data as List)
              .map((e) => deserialize<_ilvyut6l.Estimate>(e))
              .toList()
          as T;
    }
    if (t == List<_imiq6wyq.EstimateDecision>) {
      return (data as List)
              .map((e) => deserialize<_imiq6wyq.EstimateDecision>(e))
              .toList()
          as T;
    }
    if (t == List<_i4ormwf5.CustomerPhoto>) {
      return (data as List)
              .map((e) => deserialize<_i4ormwf5.CustomerPhoto>(e))
              .toList()
          as T;
    }
    if (t == List<_iaz1asnu.JobNote>) {
      return (data as List)
              .map((e) => deserialize<_iaz1asnu.JobNote>(e))
              .toList()
          as T;
    }
    if (t == List<_ixn72kw5.JobEvent>) {
      return (data as List)
              .map((e) => deserialize<_ixn72kw5.JobEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_icm2x340.EstimateLine>) {
      return (data as List)
              .map((e) => deserialize<_icm2x340.EstimateLine>(e))
              .toList()
          as T;
    }
    if (t == List<_ipz1s64e.ConditionReport>) {
      return (data as List)
              .map((e) => deserialize<_ipz1s64e.ConditionReport>(e))
              .toList()
          as T;
    }
    if (t == List<_ik1uvvpd.EvidencePhoto>) {
      return (data as List)
              .map((e) => deserialize<_ik1uvvpd.EvidencePhoto>(e))
              .toList()
          as T;
    }
    if (t == List<_iwkslo03.CustomerLink>) {
      return (data as List)
              .map((e) => deserialize<_iwkslo03.CustomerLink>(e))
              .toList()
          as T;
    }
    if (t == List<_idiw8vex.JobSummary>) {
      return (data as List)
              .map((e) => deserialize<_idiw8vex.JobSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i0gfe87e.ConditionItem>) {
      return (data as List)
              .map((e) => deserialize<_i0gfe87e.ConditionItem>(e))
              .toList()
          as T;
    }
    if (t == List<_io8rligr.EstimateLine>) {
      return (data as List)
              .map((e) => deserialize<_io8rligr.EstimateLine>(e))
              .toList()
          as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _ijpkiimy.ActorKind => 'ActorKind',
      _iw8m4vnd.AuthorizationState => 'AuthorizationState',
      _it221bl6.CachedJob => 'CachedJob',
      _i5ylibdu.ConditionItem => 'ConditionItem',
      _ipz1s64e.ConditionReport => 'ConditionReport',
      _ikr1mj9r.ConditionState => 'ConditionState',
      _icsad0ww.CreatedLink => 'CreatedLink',
      _icgd0pnr.CustomerJobView => 'CustomerJobView',
      _iwkslo03.CustomerLink => 'CustomerLink',
      _i4ormwf5.CustomerPhoto => 'CustomerPhoto',
      _i21mg86q.DecisionKind => 'DecisionKind',
      _ilvyut6l.Estimate => 'Estimate',
      _imiq6wyq.EstimateDecision => 'EstimateDecision',
      _icm2x340.EstimateLine => 'EstimateLine',
      _i3t4a52c.EstimateStatus => 'EstimateStatus',
      _ik1uvvpd.EvidencePhoto => 'EvidencePhoto',
      _i49jwhm1.FwErrorCode => 'FwErrorCode',
      _i8jn2jtm.FwException => 'FwException',
      _ijlfhm28.JobDetail => 'JobDetail',
      _ixn72kw5.JobEvent => 'JobEvent',
      _iwt0hck5.JobEventType => 'JobEventType',
      _iaz1asnu.JobNote => 'JobNote',
      _iayt1i3u.JobStatus => 'JobStatus',
      _ieitn8yx.JobSummary => 'JobSummary',
      _ihrvi1k4.LineKind => 'LineKind',
      _iqofyfch.NewJobInput => 'NewJobInput',
      _isgnykvt.OpKind => 'OpKind',
      _icbsweww.OpStatus => 'OpStatus',
      _igyp3o5l.PendingOperation => 'PendingOperation',
      _izmwwpv6.PhotoStage => 'PhotoStage',
      _ivh14x5g.PhotoUploadTicket => 'PhotoUploadTicket',
      _ibfrpqb8.RepairJob => 'RepairJob',
      _isgf2ncs.Shop => 'Shop',
      _inmn8lg4.ShopContext => 'ShopContext',
      _ip7etvmn.ShopMember => 'ShopMember',
      _inr72q68.ShopRole => 'ShopRole',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('fixwitness.', '');
    }

    switch (data) {
      case _ijpkiimy.ActorKind():
        return 'ActorKind';
      case _iw8m4vnd.AuthorizationState():
        return 'AuthorizationState';
      case _it221bl6.CachedJob():
        return 'CachedJob';
      case _i5ylibdu.ConditionItem():
        return 'ConditionItem';
      case _ipz1s64e.ConditionReport():
        return 'ConditionReport';
      case _ikr1mj9r.ConditionState():
        return 'ConditionState';
      case _icsad0ww.CreatedLink():
        return 'CreatedLink';
      case _icgd0pnr.CustomerJobView():
        return 'CustomerJobView';
      case _iwkslo03.CustomerLink():
        return 'CustomerLink';
      case _i4ormwf5.CustomerPhoto():
        return 'CustomerPhoto';
      case _i21mg86q.DecisionKind():
        return 'DecisionKind';
      case _ilvyut6l.Estimate():
        return 'Estimate';
      case _imiq6wyq.EstimateDecision():
        return 'EstimateDecision';
      case _icm2x340.EstimateLine():
        return 'EstimateLine';
      case _i3t4a52c.EstimateStatus():
        return 'EstimateStatus';
      case _ik1uvvpd.EvidencePhoto():
        return 'EvidencePhoto';
      case _i49jwhm1.FwErrorCode():
        return 'FwErrorCode';
      case _i8jn2jtm.FwException():
        return 'FwException';
      case _ijlfhm28.JobDetail():
        return 'JobDetail';
      case _ixn72kw5.JobEvent():
        return 'JobEvent';
      case _iwt0hck5.JobEventType():
        return 'JobEventType';
      case _iaz1asnu.JobNote():
        return 'JobNote';
      case _iayt1i3u.JobStatus():
        return 'JobStatus';
      case _ieitn8yx.JobSummary():
        return 'JobSummary';
      case _ihrvi1k4.LineKind():
        return 'LineKind';
      case _iqofyfch.NewJobInput():
        return 'NewJobInput';
      case _isgnykvt.OpKind():
        return 'OpKind';
      case _icbsweww.OpStatus():
        return 'OpStatus';
      case _igyp3o5l.PendingOperation():
        return 'PendingOperation';
      case _izmwwpv6.PhotoStage():
        return 'PhotoStage';
      case _ivh14x5g.PhotoUploadTicket():
        return 'PhotoUploadTicket';
      case _ibfrpqb8.RepairJob():
        return 'RepairJob';
      case _isgf2ncs.Shop():
        return 'Shop';
      case _inmn8lg4.ShopContext():
        return 'ShopContext';
      case _ip7etvmn.ShopMember():
        return 'ShopMember';
      case _inr72q68.ShopRole():
        return 'ShopRole';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'ActorKind') {
      return deserialize<_ijpkiimy.ActorKind>(data['data']);
    }
    if (dataClassName == 'AuthorizationState') {
      return deserialize<_iw8m4vnd.AuthorizationState>(data['data']);
    }
    if (dataClassName == 'CachedJob') {
      return deserialize<_it221bl6.CachedJob>(data['data']);
    }
    if (dataClassName == 'ConditionItem') {
      return deserialize<_i5ylibdu.ConditionItem>(data['data']);
    }
    if (dataClassName == 'ConditionReport') {
      return deserialize<_ipz1s64e.ConditionReport>(data['data']);
    }
    if (dataClassName == 'ConditionState') {
      return deserialize<_ikr1mj9r.ConditionState>(data['data']);
    }
    if (dataClassName == 'CreatedLink') {
      return deserialize<_icsad0ww.CreatedLink>(data['data']);
    }
    if (dataClassName == 'CustomerJobView') {
      return deserialize<_icgd0pnr.CustomerJobView>(data['data']);
    }
    if (dataClassName == 'CustomerLink') {
      return deserialize<_iwkslo03.CustomerLink>(data['data']);
    }
    if (dataClassName == 'CustomerPhoto') {
      return deserialize<_i4ormwf5.CustomerPhoto>(data['data']);
    }
    if (dataClassName == 'DecisionKind') {
      return deserialize<_i21mg86q.DecisionKind>(data['data']);
    }
    if (dataClassName == 'Estimate') {
      return deserialize<_ilvyut6l.Estimate>(data['data']);
    }
    if (dataClassName == 'EstimateDecision') {
      return deserialize<_imiq6wyq.EstimateDecision>(data['data']);
    }
    if (dataClassName == 'EstimateLine') {
      return deserialize<_icm2x340.EstimateLine>(data['data']);
    }
    if (dataClassName == 'EstimateStatus') {
      return deserialize<_i3t4a52c.EstimateStatus>(data['data']);
    }
    if (dataClassName == 'EvidencePhoto') {
      return deserialize<_ik1uvvpd.EvidencePhoto>(data['data']);
    }
    if (dataClassName == 'FwErrorCode') {
      return deserialize<_i49jwhm1.FwErrorCode>(data['data']);
    }
    if (dataClassName == 'FwException') {
      return deserialize<_i8jn2jtm.FwException>(data['data']);
    }
    if (dataClassName == 'JobDetail') {
      return deserialize<_ijlfhm28.JobDetail>(data['data']);
    }
    if (dataClassName == 'JobEvent') {
      return deserialize<_ixn72kw5.JobEvent>(data['data']);
    }
    if (dataClassName == 'JobEventType') {
      return deserialize<_iwt0hck5.JobEventType>(data['data']);
    }
    if (dataClassName == 'JobNote') {
      return deserialize<_iaz1asnu.JobNote>(data['data']);
    }
    if (dataClassName == 'JobStatus') {
      return deserialize<_iayt1i3u.JobStatus>(data['data']);
    }
    if (dataClassName == 'JobSummary') {
      return deserialize<_ieitn8yx.JobSummary>(data['data']);
    }
    if (dataClassName == 'LineKind') {
      return deserialize<_ihrvi1k4.LineKind>(data['data']);
    }
    if (dataClassName == 'NewJobInput') {
      return deserialize<_iqofyfch.NewJobInput>(data['data']);
    }
    if (dataClassName == 'OpKind') {
      return deserialize<_isgnykvt.OpKind>(data['data']);
    }
    if (dataClassName == 'OpStatus') {
      return deserialize<_icbsweww.OpStatus>(data['data']);
    }
    if (dataClassName == 'PendingOperation') {
      return deserialize<_igyp3o5l.PendingOperation>(data['data']);
    }
    if (dataClassName == 'PhotoStage') {
      return deserialize<_izmwwpv6.PhotoStage>(data['data']);
    }
    if (dataClassName == 'PhotoUploadTicket') {
      return deserialize<_ivh14x5g.PhotoUploadTicket>(data['data']);
    }
    if (dataClassName == 'RepairJob') {
      return deserialize<_ibfrpqb8.RepairJob>(data['data']);
    }
    if (dataClassName == 'Shop') {
      return deserialize<_isgf2ncs.Shop>(data['data']);
    }
    if (dataClassName == 'ShopContext') {
      return deserialize<_inmn8lg4.ShopContext>(data['data']);
    }
    if (dataClassName == 'ShopMember') {
      return deserialize<_ip7etvmn.ShopMember>(data['data']);
    }
    if (dataClassName == 'ShopRole') {
      return deserialize<_inr72q68.ShopRole>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('fixwitness', this);
    _iacc.Protocol().registerHostProtocol('fixwitness', this);
  }

  @override
  _isd.Table? getTableForType(Type t) {
    {
      var protocol = _iaic.Protocol();
      var table = protocol is _isd.DatabaseSerializationManager
          ? (protocol as _isd.DatabaseSerializationManager).getTableForType(t)
          : null;
      if (table != null) {
        return table;
      }
    }
    {
      var protocol = _iacc.Protocol();
      var table = protocol is _isd.DatabaseSerializationManager
          ? (protocol as _isd.DatabaseSerializationManager).getTableForType(t)
          : null;
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _it221bl6.CachedJob:
        return _it221bl6.CachedJob.t;
      case _igyp3o5l.PendingOperation:
        return _igyp3o5l.PendingOperation.t;
    }
    return null;
  }

  @override
  List<_isd.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'fixwitness';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
