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
import 'package:fixwitness_client/src/protocol/protocol.dart' as _i7z9lov6;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'authorization_state.dart' as _iw8m4vnd;
import 'condition_report.dart' as _ipz1s64e;
import 'customer_link.dart' as _iwkslo03;
import 'estimate.dart' as _ilvyut6l;
import 'estimate_decision.dart' as _imiq6wyq;
import 'evidence_photo.dart' as _ik1uvvpd;
import 'job_event.dart' as _ixn72kw5;
import 'job_note.dart' as _iaz1asnu;
import 'repair_job.dart' as _ibfrpqb8;

abstract class JobDetail
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  JobDetail._({
    required this.job,
    required this.shopCurrency,
    required this.authorization,
    required this.estimates,
    required this.decisions,
    required this.conditionReports,
    required this.photos,
    required this.notes,
    required this.events,
    required this.links,
  });

  factory JobDetail({
    required _ibfrpqb8.RepairJob job,
    required String shopCurrency,
    required _iw8m4vnd.AuthorizationState authorization,
    required List<_ilvyut6l.Estimate> estimates,
    required List<_imiq6wyq.EstimateDecision> decisions,
    required List<_ipz1s64e.ConditionReport> conditionReports,
    required List<_ik1uvvpd.EvidencePhoto> photos,
    required List<_iaz1asnu.JobNote> notes,
    required List<_ixn72kw5.JobEvent> events,
    required List<_iwkslo03.CustomerLink> links,
  }) = _JobDetailImpl;

  factory JobDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return JobDetail(
      job: _i7z9lov6.Protocol().deserialize<_ibfrpqb8.RepairJob>(
        jsonSerialization['job'],
      ),
      shopCurrency: jsonSerialization['shopCurrency'] as String,
      authorization: _i7z9lov6.Protocol()
          .deserialize<_iw8m4vnd.AuthorizationState>(
            jsonSerialization['authorization'],
          ),
      estimates: _i7z9lov6.Protocol().deserialize<List<_ilvyut6l.Estimate>>(
        jsonSerialization['estimates'],
      ),
      decisions: _i7z9lov6.Protocol()
          .deserialize<List<_imiq6wyq.EstimateDecision>>(
            jsonSerialization['decisions'],
          ),
      conditionReports: _i7z9lov6.Protocol()
          .deserialize<List<_ipz1s64e.ConditionReport>>(
            jsonSerialization['conditionReports'],
          ),
      photos: _i7z9lov6.Protocol().deserialize<List<_ik1uvvpd.EvidencePhoto>>(
        jsonSerialization['photos'],
      ),
      notes: _i7z9lov6.Protocol().deserialize<List<_iaz1asnu.JobNote>>(
        jsonSerialization['notes'],
      ),
      events: _i7z9lov6.Protocol().deserialize<List<_ixn72kw5.JobEvent>>(
        jsonSerialization['events'],
      ),
      links: _i7z9lov6.Protocol().deserialize<List<_iwkslo03.CustomerLink>>(
        jsonSerialization['links'],
      ),
    );
  }

  _ibfrpqb8.RepairJob job;

  String shopCurrency;

  _iw8m4vnd.AuthorizationState authorization;

  List<_ilvyut6l.Estimate> estimates;

  List<_imiq6wyq.EstimateDecision> decisions;

  List<_ipz1s64e.ConditionReport> conditionReports;

  List<_ik1uvvpd.EvidencePhoto> photos;

  List<_iaz1asnu.JobNote> notes;

  List<_ixn72kw5.JobEvent> events;

  List<_iwkslo03.CustomerLink> links;

  /// Returns a shallow copy of this [JobDetail]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  JobDetail copyWith({
    _ibfrpqb8.RepairJob? job,
    String? shopCurrency,
    _iw8m4vnd.AuthorizationState? authorization,
    List<_ilvyut6l.Estimate>? estimates,
    List<_imiq6wyq.EstimateDecision>? decisions,
    List<_ipz1s64e.ConditionReport>? conditionReports,
    List<_ik1uvvpd.EvidencePhoto>? photos,
    List<_iaz1asnu.JobNote>? notes,
    List<_ixn72kw5.JobEvent>? events,
    List<_iwkslo03.CustomerLink>? links,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JobDetail',
      'job': job.toJson(),
      'shopCurrency': shopCurrency,
      'authorization': authorization.toJson(),
      'estimates': estimates.toJson(valueToJson: (v) => v.toJson()),
      'decisions': decisions.toJson(valueToJson: (v) => v.toJson()),
      'conditionReports': conditionReports.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'photos': photos.toJson(valueToJson: (v) => v.toJson()),
      'notes': notes.toJson(valueToJson: (v) => v.toJson()),
      'events': events.toJson(valueToJson: (v) => v.toJson()),
      'links': links.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JobDetail',
      'job': job.toJsonForProtocol(),
      'shopCurrency': shopCurrency,
      'authorization': authorization.toJsonForProtocol(),
      'estimates': estimates.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'decisions': decisions.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'conditionReports': conditionReports.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'photos': photos.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'notes': notes.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'events': events.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'links': links.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _JobDetailImpl extends JobDetail {
  _JobDetailImpl({
    required _ibfrpqb8.RepairJob job,
    required String shopCurrency,
    required _iw8m4vnd.AuthorizationState authorization,
    required List<_ilvyut6l.Estimate> estimates,
    required List<_imiq6wyq.EstimateDecision> decisions,
    required List<_ipz1s64e.ConditionReport> conditionReports,
    required List<_ik1uvvpd.EvidencePhoto> photos,
    required List<_iaz1asnu.JobNote> notes,
    required List<_ixn72kw5.JobEvent> events,
    required List<_iwkslo03.CustomerLink> links,
  }) : super._(
         job: job,
         shopCurrency: shopCurrency,
         authorization: authorization,
         estimates: estimates,
         decisions: decisions,
         conditionReports: conditionReports,
         photos: photos,
         notes: notes,
         events: events,
         links: links,
       );

  /// Returns a shallow copy of this [JobDetail]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  JobDetail copyWith({
    _ibfrpqb8.RepairJob? job,
    String? shopCurrency,
    _iw8m4vnd.AuthorizationState? authorization,
    List<_ilvyut6l.Estimate>? estimates,
    List<_imiq6wyq.EstimateDecision>? decisions,
    List<_ipz1s64e.ConditionReport>? conditionReports,
    List<_ik1uvvpd.EvidencePhoto>? photos,
    List<_iaz1asnu.JobNote>? notes,
    List<_ixn72kw5.JobEvent>? events,
    List<_iwkslo03.CustomerLink>? links,
  }) {
    return JobDetail(
      job: job ?? this.job.copyWith(),
      shopCurrency: shopCurrency ?? this.shopCurrency,
      authorization: authorization ?? this.authorization.copyWith(),
      estimates:
          estimates ?? this.estimates.map((e0) => e0.copyWith()).toList(),
      decisions:
          decisions ?? this.decisions.map((e0) => e0.copyWith()).toList(),
      conditionReports:
          conditionReports ??
          this.conditionReports.map((e0) => e0.copyWith()).toList(),
      photos: photos ?? this.photos.map((e0) => e0.copyWith()).toList(),
      notes: notes ?? this.notes.map((e0) => e0.copyWith()).toList(),
      events: events ?? this.events.map((e0) => e0.copyWith()).toList(),
      links: links ?? this.links.map((e0) => e0.copyWith()).toList(),
    );
  }
}
