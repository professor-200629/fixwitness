import 'dart:io';

import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:fixwitness_flutter/sync/job_cache.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

JobSummary summary(int id, int number) => JobSummary(
  id: id,
  jobNumber: number,
  customerName: 'Customer $number',
  deviceLabel: 'Phone $number',
  status: JobStatus.checkedIn,
  rowVersion: 1,
  updatedAt: DateTime.utc(2026, 10, 11, 12, number),
  awaitingCustomer: false,
);

void main() {
  late Directory dir;

  setUp(() async => dir = await Directory.systemTemp.createTemp('fw_cache_'));
  tearDown(() async {
    try {
      await dir.delete(recursive: true);
    } on FileSystemException {
      // SQLite may hold the WAL file briefly on Windows.
    }
  });

  test(
    'when a job disappears from the server list then it leaves the offline cache',
    () async {
      final session = await Client(
        'http://localhost:1/',
      ).createSession(p.join(dir.path, 'c.db'));
      final cache = SqliteJobCache(session);

      await cache.putSummaries([summary(1, 1), summary(2, 2)]);
      expect(
        (await cache.summaries()).map((s) => s.id),
        unorderedEquals([1, 2]),
      );

      // Job 1 was deleted on the server: the next fetch no longer lists it.
      await cache.putSummaries([summary(2, 2)]);
      expect((await cache.summaries()).map((s) => s.id), [2]);
      expect(await cache.detail(1), isNull);

      await session.close();
    },
  );

  test(
    'when the memory cache refreshes then stale details are dropped too',
    () async {
      final cache = MemoryJobCache();
      await cache.putSummaries([summary(1, 1)]);
      await cache.putSummaries([]);
      expect(await cache.summaries(), isEmpty);
    },
  );
}
