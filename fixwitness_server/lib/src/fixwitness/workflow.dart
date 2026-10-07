import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../generated/protocol.dart';
import 'errors.dart';
import 'validation.dart';

const _allowed = <JobStatus, Set<JobStatus>>{
  JobStatus.checkedIn: {JobStatus.awaitingApproval},
  JobStatus.awaitingApproval: {
    JobStatus.awaitingApproval,
    JobStatus.approved,
    JobStatus.declined,
  },
  JobStatus.approved: {
    JobStatus.awaitingApproval,
    JobStatus.inProgress,
    JobStatus.completed,
  },
  JobStatus.inProgress: {JobStatus.awaitingApproval, JobStatus.completed},
  // After a declined revision the earlier approval may still authorize work.
  JobStatus.declined: {
    JobStatus.awaitingApproval,
    JobStatus.inProgress,
    JobStatus.completed,
    JobStatus.collected,
  },
  JobStatus.completed: {JobStatus.collected},
  JobStatus.collected: {},
};

String statusLabel(JobStatus status) => switch (status) {
  JobStatus.checkedIn => 'checked in',
  JobStatus.awaitingApproval => 'waiting for customer approval',
  JobStatus.approved => 'approved',
  JobStatus.inProgress => 'in progress',
  JobStatus.declined => 'declined by the customer',
  JobStatus.completed => 'ready for collection',
  JobStatus.collected => 'collected',
};

/// Throws unless [from] -> [to] is a legal transition.
void requireTransition(JobStatus from, JobStatus to, String action) {
  if (!(_allowed[from] ?? const {}).contains(to)) {
    throw badTransition('Cannot $action: the job is ${statusLabel(from)}.');
  }
}

/// Throws unless some estimate is approved and no newer version is waiting
/// for the customer. Work must not continue on unapproved changes.
void requireAuthorizedWork(RepairJob job, Estimate? current, String action) {
  if (job.authorizedEstimateId == null) {
    throw badTransition('Cannot $action: the customer has not approved an estimate.');
  }
  if (current != null && current.status == EstimateStatus.issued) {
    throw badTransition(
      'Cannot $action: estimate v${current.versionNumber} is waiting for the '
      'customer. Changed work is not authorized until it is approved.',
    );
  }
}

/// SHA-256 over the canonical estimate content. The customer approves this
/// exact value; any difference in lines, totals or currency changes it.
String estimateContentHash({
  required int jobId,
  required int versionNumber,
  required List<EstimateLine> lines,
  required int totalMinor,
  required String currency,
  required String? note,
}) {
  final canonical = jsonEncode({
    'jobId': jobId,
    'version': versionNumber,
    'currency': currency,
    'totalMinor': totalMinor,
    'note': note ?? '',
    'lines': [
      for (final l in lines)
        [l.kind.name, l.description, l.quantity, l.unitPriceMinor],
    ],
  });
  return sha256.convert(utf8.encode(canonical)).toString();
}

/// Derives what work is authorized from the stored estimates. Clients render
/// this label instead of deciding authorization themselves.
AuthorizationState authorizationFor(
  RepairJob job,
  List<Estimate> estimates,
  String currency,
) {
  Estimate? byId(int? id) =>
      id == null ? null : estimates.where((e) => e.id == id).firstOrNull;
  final latest = byId(job.currentEstimateId);
  final authorized = byId(job.authorizedEstimateId);
  final pending = latest?.status == EstimateStatus.issued;
  String money(Estimate e) => formatMoney(e.totalMinor, currency);

  final String label;
  if (latest == null) {
    label = 'No estimate issued yet. No work is authorized.';
  } else if (pending && authorized == null) {
    label = 'Estimate v${latest.versionNumber} (${money(latest)}) is waiting '
        'for customer approval. No work is authorized yet.';
  } else if (pending) {
    label = 'Revised estimate v${latest.versionNumber} (${money(latest)}) is '
        'waiting for approval. Only the work in v${authorized!.versionNumber} '
        '(${money(authorized)}) is authorized.';
  } else if (latest.status == EstimateStatus.declined && authorized != null) {
    label = 'The customer declined v${latest.versionNumber}. Only the work in '
        'v${authorized.versionNumber} (${money(authorized)}) is authorized.';
  } else if (latest.status == EstimateStatus.declined) {
    label = 'The customer declined v${latest.versionNumber}. No work is authorized.';
  } else {
    label = 'The customer approved v${authorized!.versionNumber} '
        '(${money(authorized)}). This work is authorized.';
  }
  return AuthorizationState(
    authorizedVersion: authorized?.versionNumber,
    authorizedTotalMinor: authorized?.totalMinor,
    latestVersion: latest?.versionNumber,
    latestTotalMinor: latest?.totalMinor,
    pendingApproval: pending,
    revisionPending: pending && authorized != null,
    label: label,
  );
}

String deviceLabel(RepairJob job) => '${job.deviceMake} ${job.deviceModel}';
