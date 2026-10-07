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
import 'authorization_state.dart' as _iw8m4vnd;
import 'condition_report.dart' as _ipz1s64e;
import 'customer_photo.dart' as _i4ormwf5;
import 'estimate.dart' as _ilvyut6l;
import 'estimate_decision.dart' as _imiq6wyq;
import 'job_event.dart' as _ixn72kw5;
import 'job_note.dart' as _iaz1asnu;
import 'job_status.dart' as _iayt1i3u;

/// Everything a customer sees through their link. Built on the server from
/// customer-visible records only.
abstract class CustomerJobView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CustomerJobView._({
    required this.shopName,
    required this.jobNumber,
    required this.deviceLabel,
    required this.customerName,
    required this.reportedFault,
    required this.status,
    required this.currency,
    required this.authorization,
    this.currentEstimate,
    required this.estimates,
    required this.decisions,
    this.condition,
    required this.photos,
    required this.notes,
    required this.history,
    required this.linkExpiresAt,
    required this.canDecide,
    required this.canAcknowledgeCollection,
  });

  factory CustomerJobView({
    required String shopName,
    required int jobNumber,
    required String deviceLabel,
    required String customerName,
    required String reportedFault,
    required _iayt1i3u.JobStatus status,
    required String currency,
    required _iw8m4vnd.AuthorizationState authorization,
    _ilvyut6l.Estimate? currentEstimate,
    required List<_ilvyut6l.Estimate> estimates,
    required List<_imiq6wyq.EstimateDecision> decisions,
    _ipz1s64e.ConditionReport? condition,
    required List<_i4ormwf5.CustomerPhoto> photos,
    required List<_iaz1asnu.JobNote> notes,
    required List<_ixn72kw5.JobEvent> history,
    required DateTime linkExpiresAt,
    required bool canDecide,
    required bool canAcknowledgeCollection,
  }) = _CustomerJobViewImpl;

  factory CustomerJobView.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomerJobView(
      shopName: jsonSerialization['shopName'] as String,
      jobNumber: jsonSerialization['jobNumber'] as int,
      deviceLabel: jsonSerialization['deviceLabel'] as String,
      customerName: jsonSerialization['customerName'] as String,
      reportedFault: jsonSerialization['reportedFault'] as String,
      status: _iayt1i3u.JobStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      currency: jsonSerialization['currency'] as String,
      authorization: _ih76ajaf.Protocol()
          .deserialize<_iw8m4vnd.AuthorizationState>(
            jsonSerialization['authorization'],
          ),
      currentEstimate: jsonSerialization['currentEstimate'] == null
          ? null
          : _ih76ajaf.Protocol().deserialize<_ilvyut6l.Estimate>(
              jsonSerialization['currentEstimate'],
            ),
      estimates: _ih76ajaf.Protocol().deserialize<List<_ilvyut6l.Estimate>>(
        jsonSerialization['estimates'],
      ),
      decisions: _ih76ajaf.Protocol()
          .deserialize<List<_imiq6wyq.EstimateDecision>>(
            jsonSerialization['decisions'],
          ),
      condition: jsonSerialization['condition'] == null
          ? null
          : _ih76ajaf.Protocol().deserialize<_ipz1s64e.ConditionReport>(
              jsonSerialization['condition'],
            ),
      photos: _ih76ajaf.Protocol().deserialize<List<_i4ormwf5.CustomerPhoto>>(
        jsonSerialization['photos'],
      ),
      notes: _ih76ajaf.Protocol().deserialize<List<_iaz1asnu.JobNote>>(
        jsonSerialization['notes'],
      ),
      history: _ih76ajaf.Protocol().deserialize<List<_ixn72kw5.JobEvent>>(
        jsonSerialization['history'],
      ),
      linkExpiresAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['linkExpiresAt'],
      ),
      canDecide: _is.BoolJsonExtension.fromJson(jsonSerialization['canDecide']),
      canAcknowledgeCollection: _is.BoolJsonExtension.fromJson(
        jsonSerialization['canAcknowledgeCollection'],
      ),
    );
  }

  String shopName;

  int jobNumber;

  String deviceLabel;

  String customerName;

  String reportedFault;

  _iayt1i3u.JobStatus status;

  String currency;

  _iw8m4vnd.AuthorizationState authorization;

  _ilvyut6l.Estimate? currentEstimate;

  List<_ilvyut6l.Estimate> estimates;

  List<_imiq6wyq.EstimateDecision> decisions;

  _ipz1s64e.ConditionReport? condition;

  List<_i4ormwf5.CustomerPhoto> photos;

  List<_iaz1asnu.JobNote> notes;

  List<_ixn72kw5.JobEvent> history;

  DateTime linkExpiresAt;

  bool canDecide;

  bool canAcknowledgeCollection;

  /// Returns a shallow copy of this [CustomerJobView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CustomerJobView copyWith({
    String? shopName,
    int? jobNumber,
    String? deviceLabel,
    String? customerName,
    String? reportedFault,
    _iayt1i3u.JobStatus? status,
    String? currency,
    _iw8m4vnd.AuthorizationState? authorization,
    _ilvyut6l.Estimate? currentEstimate,
    List<_ilvyut6l.Estimate>? estimates,
    List<_imiq6wyq.EstimateDecision>? decisions,
    _ipz1s64e.ConditionReport? condition,
    List<_i4ormwf5.CustomerPhoto>? photos,
    List<_iaz1asnu.JobNote>? notes,
    List<_ixn72kw5.JobEvent>? history,
    DateTime? linkExpiresAt,
    bool? canDecide,
    bool? canAcknowledgeCollection,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerJobView',
      'shopName': shopName,
      'jobNumber': jobNumber,
      'deviceLabel': deviceLabel,
      'customerName': customerName,
      'reportedFault': reportedFault,
      'status': status.toJson(),
      'currency': currency,
      'authorization': authorization.toJson(),
      if (currentEstimate != null) 'currentEstimate': currentEstimate?.toJson(),
      'estimates': estimates.toJson(valueToJson: (v) => v.toJson()),
      'decisions': decisions.toJson(valueToJson: (v) => v.toJson()),
      if (condition != null) 'condition': condition?.toJson(),
      'photos': photos.toJson(valueToJson: (v) => v.toJson()),
      'notes': notes.toJson(valueToJson: (v) => v.toJson()),
      'history': history.toJson(valueToJson: (v) => v.toJson()),
      'linkExpiresAt': linkExpiresAt.toJson(),
      'canDecide': canDecide,
      'canAcknowledgeCollection': canAcknowledgeCollection,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerJobView',
      'shopName': shopName,
      'jobNumber': jobNumber,
      'deviceLabel': deviceLabel,
      'customerName': customerName,
      'reportedFault': reportedFault,
      'status': status.toJson(),
      'currency': currency,
      'authorization': authorization.toJsonForProtocol(),
      if (currentEstimate != null)
        'currentEstimate': currentEstimate?.toJsonForProtocol(),
      'estimates': estimates.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'decisions': decisions.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (condition != null) 'condition': condition?.toJsonForProtocol(),
      'photos': photos.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'notes': notes.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'history': history.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'linkExpiresAt': linkExpiresAt.toJson(),
      'canDecide': canDecide,
      'canAcknowledgeCollection': canAcknowledgeCollection,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomerJobViewImpl extends CustomerJobView {
  _CustomerJobViewImpl({
    required String shopName,
    required int jobNumber,
    required String deviceLabel,
    required String customerName,
    required String reportedFault,
    required _iayt1i3u.JobStatus status,
    required String currency,
    required _iw8m4vnd.AuthorizationState authorization,
    _ilvyut6l.Estimate? currentEstimate,
    required List<_ilvyut6l.Estimate> estimates,
    required List<_imiq6wyq.EstimateDecision> decisions,
    _ipz1s64e.ConditionReport? condition,
    required List<_i4ormwf5.CustomerPhoto> photos,
    required List<_iaz1asnu.JobNote> notes,
    required List<_ixn72kw5.JobEvent> history,
    required DateTime linkExpiresAt,
    required bool canDecide,
    required bool canAcknowledgeCollection,
  }) : super._(
         shopName: shopName,
         jobNumber: jobNumber,
         deviceLabel: deviceLabel,
         customerName: customerName,
         reportedFault: reportedFault,
         status: status,
         currency: currency,
         authorization: authorization,
         currentEstimate: currentEstimate,
         estimates: estimates,
         decisions: decisions,
         condition: condition,
         photos: photos,
         notes: notes,
         history: history,
         linkExpiresAt: linkExpiresAt,
         canDecide: canDecide,
         canAcknowledgeCollection: canAcknowledgeCollection,
       );

  /// Returns a shallow copy of this [CustomerJobView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CustomerJobView copyWith({
    String? shopName,
    int? jobNumber,
    String? deviceLabel,
    String? customerName,
    String? reportedFault,
    _iayt1i3u.JobStatus? status,
    String? currency,
    _iw8m4vnd.AuthorizationState? authorization,
    Object? currentEstimate = _Undefined,
    List<_ilvyut6l.Estimate>? estimates,
    List<_imiq6wyq.EstimateDecision>? decisions,
    Object? condition = _Undefined,
    List<_i4ormwf5.CustomerPhoto>? photos,
    List<_iaz1asnu.JobNote>? notes,
    List<_ixn72kw5.JobEvent>? history,
    DateTime? linkExpiresAt,
    bool? canDecide,
    bool? canAcknowledgeCollection,
  }) {
    return CustomerJobView(
      shopName: shopName ?? this.shopName,
      jobNumber: jobNumber ?? this.jobNumber,
      deviceLabel: deviceLabel ?? this.deviceLabel,
      customerName: customerName ?? this.customerName,
      reportedFault: reportedFault ?? this.reportedFault,
      status: status ?? this.status,
      currency: currency ?? this.currency,
      authorization: authorization ?? this.authorization.copyWith(),
      currentEstimate: currentEstimate is _ilvyut6l.Estimate?
          ? currentEstimate
          : this.currentEstimate?.copyWith(),
      estimates:
          estimates ?? this.estimates.map((e0) => e0.copyWith()).toList(),
      decisions:
          decisions ?? this.decisions.map((e0) => e0.copyWith()).toList(),
      condition: condition is _ipz1s64e.ConditionReport?
          ? condition
          : this.condition?.copyWith(),
      photos: photos ?? this.photos.map((e0) => e0.copyWith()).toList(),
      notes: notes ?? this.notes.map((e0) => e0.copyWith()).toList(),
      history: history ?? this.history.map((e0) => e0.copyWith()).toList(),
      linkExpiresAt: linkExpiresAt ?? this.linkExpiresAt,
      canDecide: canDecide ?? this.canDecide,
      canAcknowledgeCollection:
          canAcknowledgeCollection ?? this.canAcknowledgeCollection,
    );
  }
}
