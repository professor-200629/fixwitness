import 'dart:convert';

import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:serverpod_database/serverpod_database.dart';

/// Last known server state of jobs, for reading while offline. The cache is
/// never the source of truth: it is replaced by every successful fetch.
abstract class JobCache {
  Future<void> putSummaries(List<JobSummary> jobs);
  Future<List<JobSummary>> summaries();
  Future<void> putDetail(JobDetail detail);
  Future<JobDetail?> detail(int jobId);
  Future<DateTime?> cachedAt();
}

class SqliteJobCache implements JobCache {
  SqliteJobCache(this.session);

  final ClientDatabaseSession session;

  @override
  Future<void> putSummaries(List<JobSummary> jobs) async {
    final now = DateTime.now().toUtc();
    await session.db.transaction((tx) async {
      final existing = {
        for (final c in await CachedJob.db.find(session, transaction: tx)) c.serverJobId: c,
      };
      for (final j in jobs) {
        final row = existing.remove(j.id);
        final json = jsonEncode(j.toJson());
        if (row == null) {
          await CachedJob.db.insertRow(
            session,
            CachedJob(serverJobId: j.id, jobNumber: j.jobNumber, summaryJson: json, cachedAt: now),
            transaction: tx,
          );
        } else {
          await CachedJob.db.updateRow(
            session,
            row.copyWith(summaryJson: json, jobNumber: j.jobNumber, cachedAt: now),
            transaction: tx,
          );
        }
      }
    });
  }

  @override
  Future<List<JobSummary>> summaries() async {
    final rows = await CachedJob.db.find(session, orderBy: (t) => t.jobNumber);
    final list = [
      for (final r in rows)
        JobSummary.fromJson(jsonDecode(r.summaryJson) as Map<String, dynamic>),
    ];
    list.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return list;
  }

  @override
  Future<void> putDetail(JobDetail detail) async {
    final id = detail.job.id!;
    final row = await CachedJob.db.findFirstRow(session, where: (t) => t.serverJobId.equals(id));
    final now = DateTime.now().toUtc();
    final json = jsonEncode(detail.toJson());
    if (row == null) {
      await CachedJob.db.insertRow(
        session,
        CachedJob(
          serverJobId: id,
          jobNumber: detail.job.jobNumber,
          summaryJson: jsonEncode(_summaryOf(detail).toJson()),
          detailJson: json,
          cachedAt: now,
        ),
      );
    } else {
      await CachedJob.db.updateRow(session, row.copyWith(detailJson: json, cachedAt: now));
    }
  }

  @override
  Future<JobDetail?> detail(int jobId) async {
    final row = await CachedJob.db.findFirstRow(session, where: (t) => t.serverJobId.equals(jobId));
    if (row?.detailJson == null) return null;
    return JobDetail.fromJson(jsonDecode(row!.detailJson!) as Map<String, dynamic>);
  }

  @override
  Future<DateTime?> cachedAt() async {
    final row = await CachedJob.db.findFirstRow(session, orderBy: (t) => t.cachedAt.desc());
    return row?.cachedAt;
  }
}

class MemoryJobCache implements JobCache {
  final _summaries = <JobSummary>[];
  final _details = <int, JobDetail>{};
  DateTime? _at;

  @override
  Future<void> putSummaries(List<JobSummary> jobs) async {
    _summaries
      ..clear()
      ..addAll(jobs);
    _at = DateTime.now().toUtc();
  }

  @override
  Future<List<JobSummary>> summaries() async => [..._summaries];

  @override
  Future<void> putDetail(JobDetail detail) async {
    _details[detail.job.id!] = detail;
    _at = DateTime.now().toUtc();
  }

  @override
  Future<JobDetail?> detail(int jobId) async => _details[jobId];

  @override
  Future<DateTime?> cachedAt() async => _at;
}

JobSummary _summaryOf(JobDetail d) => JobSummary(
  id: d.job.id!,
  jobNumber: d.job.jobNumber,
  customerName: d.job.customerName,
  deviceLabel: '${d.job.deviceMake} ${d.job.deviceModel}',
  status: d.job.status,
  rowVersion: d.job.rowVersion,
  updatedAt: d.job.updatedAt,
  awaitingCustomer: d.authorization.pendingApproval,
);
