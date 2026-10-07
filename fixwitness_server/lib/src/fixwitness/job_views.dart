import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'workflow.dart';

Future<JobDetail> buildJobDetail(Session session, RepairJob job, Shop shop) async {
  final jobId = job.id!;
  final estimates = await Estimate.db.find(
    session,
    where: (t) => t.jobId.equals(jobId),
    orderBy: (t) => t.versionNumber,
  );
  return JobDetail(
    job: job,
    shopCurrency: shop.currency,
    authorization: authorizationFor(job, estimates, shop.currency),
    estimates: estimates,
    decisions: await EstimateDecision.db.find(
      session,
      where: (t) => t.jobId.equals(jobId),
      orderBy: (t) => t.decidedAt,
    ),
    conditionReports: await ConditionReport.db.find(
      session,
      where: (t) => t.jobId.equals(jobId),
      orderBy: (t) => t.receivedAt,
    ),
    photos: await EvidencePhoto.db.find(
      session,
      where: (t) => t.jobId.equals(jobId),
      orderBy: (t) => t.capturedAt,
    ),
    notes: await JobNote.db.find(
      session,
      where: (t) => t.jobId.equals(jobId),
      orderBy: (t) => t.writtenAt,
    ),
    events: await JobEvent.db.find(
      session,
      where: (t) => t.jobId.equals(jobId),
      orderBy: (t) => t.seq,
    ),
    links: await CustomerLink.db.find(
      session,
      where: (t) => t.jobId.equals(jobId),
      orderBy: (t) => t.createdAt,
    ),
  );
}

JobSummary summaryOf(RepairJob job, {required bool awaitingCustomer}) =>
    JobSummary(
      id: job.id!,
      jobNumber: job.jobNumber,
      customerName: job.customerName,
      deviceLabel: deviceLabel(job),
      status: job.status,
      rowVersion: job.rowVersion,
      updatedAt: job.updatedAt,
      awaitingCustomer: awaitingCustomer,
    );
