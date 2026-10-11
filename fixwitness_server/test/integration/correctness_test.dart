import 'package:fixwitness_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given estimates and a customer link', (sb, endpoints) {
    late RepairJob job;
    late Estimate v1;
    late String token;

    setUp(() async {
      await seedShops(sb, endpoints);
      final owner = as(sb, ownerA);
      job = await endpoints.jobs.create(owner, newOp(), sampleJob());
      v1 = await endpoints.jobs.issueEstimate(
        owner,
        job.id!,
        null,
        lines([('Screen', 1, 400000)]),
        null,
        null,
      );
      token = tokenOf(await endpoints.links.create(owner, job.id!, 7));
    });

    test(
      'when the customer approves a version that has been replaced then it is refused and recorded',
      () async {
        await endpoints.jobs.issueEstimate(
          as(sb, ownerA),
          job.id!,
          1,
          lines([('Screen', 1, 450000)]),
          null,
          'Supplier price rose',
        );
        await expectLater(
          endpoints.customer.approve(
            anonymous(sb),
            token,
            v1.id!,
            1,
            v1.contentHash,
            'Asha',
          ),
          throwsA(
            isA<FwException>()
                .having((e) => e.code, 'code', FwErrorCode.estimateOutdated)
                .having((e) => e.attemptedVersion, 'attempted', 1)
                .having((e) => e.currentVersion, 'current', 2)
                .having((e) => e.message, 'message', contains('v2')),
          ),
        );
        final d = await endpoints.jobs.get(as(sb, ownerA), job.id!);
        expect(d.decisions, isEmpty);
        expect(d.job.authorizedEstimateId, isNull);
        expect(d.events.last.type, JobEventType.approvalRejected);
      },
    );

    test(
      'when the content hash differs from the stored version then nothing is recorded',
      () async {
        await expectLater(
          endpoints.customer.approve(
            anonymous(sb),
            token,
            v1.id!,
            1,
            '0' * 64,
            'Asha',
          ),
          throwsFw(FwErrorCode.estimateOutdated),
        );
        expect(
          (await endpoints.jobs.get(as(sb, ownerA), job.id!)).decisions,
          isEmpty,
        );
      },
    );

    test(
      'when a signed-in shop user calls the customer approval then it is refused',
      () async {
        await expectLater(
          endpoints.customer.approve(
            as(sb, ownerA),
            token,
            v1.id!,
            1,
            v1.contentHash,
            'Asha',
          ),
          throwsFw(FwErrorCode.shopAccountCannotApprove),
        );
      },
    );

    test(
      'when the same version is approved twice then the second is refused',
      () async {
        await endpoints.customer.approve(
          anonymous(sb),
          token,
          v1.id!,
          1,
          v1.contentHash,
          'Asha',
        );
        await expectLater(
          endpoints.customer.approve(
            anonymous(sb),
            token,
            v1.id!,
            1,
            v1.contentHash,
            'Asha',
          ),
          throwsFw(FwErrorCode.invalidTransition),
        );
      },
    );

    test('when the link is revoked or expired then it stops working', () async {
      final session = sb.build();
      final link = (await CustomerLink.db.find(
        session,
        where: (t) => t.jobId.equals(job.id!),
      )).single;
      await CustomerLink.db.updateRow(
        session,
        link.copyWith(
          expiresAt: DateTime.now().toUtc().subtract(
            const Duration(minutes: 1),
          ),
        ),
      );
      await expectLater(
        endpoints.customer.view(anonymous(sb), token),
        throwsFw(FwErrorCode.linkExpired),
      );
      await CustomerLink.db.updateRow(
        session,
        link.copyWith(revokedAt: DateTime.now().toUtc()),
      );
      await expectLater(
        endpoints.customer.view(anonymous(sb), token),
        throwsFw(FwErrorCode.linkRevoked),
      );
      await expectLater(
        endpoints.customer.view(anonymous(sb), 'x' * 43),
        throwsFw(FwErrorCode.linkInvalid),
      );
    });

    test(
      'when only the token hash is stored then the raw token is not in the database',
      () async {
        final link = (await CustomerLink.db.find(
          sb.build(),
          where: (t) => t.jobId.equals(job.id!),
        )).single;
        expect(link.tokenHash, isNot(token));
        expect(link.tokenHash, hasLength(64));
      },
    );
  });

  withServerpod('Given two shops', (sb, endpoints) {
    late RepairJob jobA;
    late EvidencePhoto photo;

    setUp(() async {
      final ids = await seedShops(sb, endpoints);
      jobA = await endpoints.jobs.create(as(sb, ownerA), newOp(), sampleJob());
      final op = newOp();
      final bytes = fakeJpeg();
      await endpoints.evidence.preparePhotoUpload(
        as(sb, ownerA),
        jobA.id!,
        op,
        'image/jpeg',
        bytes.length,
      );
      await simulateUpload(
        sb.build(),
        shopId: ids.shopA,
        jobId: jobA.id!,
        opId: op,
        bytes: bytes,
      );
      photo = await endpoints.evidence.registerPhoto(
        as(sb, ownerA),
        jobA.id!,
        op,
        'image/jpeg',
        sha(bytes),
        PhotoStage.intake,
        null,
        DateTime.now(),
      );
    });

    test(
      'when shop B touches shop A data then every call reports not found',
      () async {
        final b = as(sb, ownerB);
        await expectLater(
          endpoints.jobs.get(b, jobA.id!),
          throwsFw(FwErrorCode.notFound),
        );
        await expectLater(
          endpoints.jobs.addNote(
            b,
            jobA.id!,
            newOp(),
            'x',
            false,
            DateTime.now(),
          ),
          throwsFw(FwErrorCode.notFound),
        );
        await expectLater(
          endpoints.jobs.issueEstimate(
            b,
            jobA.id!,
            null,
            lines([('x', 1, 1)]),
            null,
            null,
          ),
          throwsFw(FwErrorCode.notFound),
        );
        await expectLater(
          endpoints.jobs.startWork(b, jobA.id!),
          throwsFw(FwErrorCode.notFound),
        );
        await expectLater(
          endpoints.links.create(b, jobA.id!, 7),
          throwsFw(FwErrorCode.notFound),
        );
        await expectLater(
          endpoints.evidence.photoUrl(b, photo.id!),
          throwsFw(FwErrorCode.notFound),
        );
        await expectLater(
          endpoints.evidence.preparePhotoUpload(
            b,
            jobA.id!,
            newOp(),
            'image/jpeg',
            100,
          ),
          throwsFw(FwErrorCode.notFound),
        );
        expect(await endpoints.jobs.list(b), isEmpty);
      },
    );

    test('when nobody is signed in then shop endpoints refuse', () async {
      await expectLater(
        endpoints.jobs.list(anonymous(sb)),
        throwsA(isA<ServerpodUnauthenticatedException>()),
      );
      await expectLater(
        endpoints.evidence.photoUrl(anonymous(sb), photo.id!),
        throwsA(isA<ServerpodUnauthenticatedException>()),
      );
    });

    test(
      'when a signed-in user has no shop then shop endpoints refuse',
      () async {
        await expectLater(
          endpoints.jobs.list(as(sb, stranger)),
          throwsFw(FwErrorCode.forbidden),
        );
      },
    );

    test(
      'when a customer link for job A names an estimate of job B then it is refused',
      () async {
        final a = as(sb, ownerA);
        final other = await endpoints.jobs.create(
          a,
          newOp(),
          sampleJob(customer: 'Vikram'),
        );
        final otherEstimate = await endpoints.jobs.issueEstimate(
          a,
          other.id!,
          null,
          lines([('Battery', 1, 150000)]),
          null,
          null,
        );
        await endpoints.jobs.issueEstimate(
          a,
          jobA.id!,
          null,
          lines([('Screen', 1, 400000)]),
          null,
          null,
        );
        final token = tokenOf(await endpoints.links.create(a, jobA.id!, 7));
        await expectLater(
          endpoints.customer.approve(
            anonymous(sb),
            token,
            otherEstimate.id!,
            1,
            otherEstimate.contentHash,
            'Asha',
          ),
          throwsFw(FwErrorCode.notFound),
        );
      },
    );

    test(
      'when photo upload types and sizes are invalid then they are refused',
      () async {
        final a = as(sb, ownerA);
        await expectLater(
          endpoints.evidence.preparePhotoUpload(
            a,
            jobA.id!,
            newOp(),
            'image/gif',
            100,
          ),
          throwsFw(FwErrorCode.uploadRejected),
        );
        await expectLater(
          endpoints.evidence.preparePhotoUpload(
            a,
            jobA.id!,
            newOp(),
            'image/jpeg',
            6 * 1024 * 1024,
          ),
          throwsFw(FwErrorCode.uploadRejected),
        );
      },
    );
  });

  withServerpod('Given retried operations', (sb, endpoints) {
    late int shopA;

    setUp(() async => shopA = (await seedShops(sb, endpoints)).shopA);

    test(
      'when createJob is retried with the same operation id then one job exists',
      () async {
        final op = newOp();
        final first = await endpoints.jobs.create(
          as(sb, ownerA),
          op,
          sampleJob(),
        );
        final again = await endpoints.jobs.create(
          as(sb, techA),
          op,
          sampleJob(),
        );
        expect(again.id, first.id);
        expect(await endpoints.jobs.list(as(sb, ownerA)), hasLength(1));
      },
    );

    test(
      'when another shop replays an operation id then it is refused',
      () async {
        final op = newOp();
        await endpoints.jobs.create(as(sb, ownerA), op, sampleJob());
        await expectLater(
          endpoints.jobs.create(as(sb, ownerB), op, sampleJob()),
          throwsFw(FwErrorCode.forbidden),
        );
      },
    );

    test(
      'when bytes arrived but registration was lost then preparing again reports them stored',
      () async {
        final a = as(sb, ownerA);
        final job = await endpoints.jobs.create(a, newOp(), sampleJob());
        final op = newOp();
        final bytes = fakeJpeg(4096);
        final t1 = await endpoints.evidence.preparePhotoUpload(
          a,
          job.id!,
          op,
          'image/jpeg',
          bytes.length,
        );
        expect(t1.alreadyStored, isFalse);
        await simulateUpload(
          sb.build(),
          shopId: shopA,
          jobId: job.id!,
          opId: op,
          bytes: bytes,
        );
        final t2 = await endpoints.evidence.preparePhotoUpload(
          a,
          job.id!,
          op,
          'image/jpeg',
          bytes.length,
        );
        expect(t2.alreadyStored, isTrue);
        final p1 = await endpoints.evidence.registerPhoto(
          a,
          job.id!,
          op,
          'image/jpeg',
          sha(bytes),
          PhotoStage.intake,
          null,
          DateTime.now(),
        );
        final p2 = await endpoints.evidence.registerPhoto(
          a,
          job.id!,
          op,
          'image/jpeg',
          sha(bytes),
          PhotoStage.intake,
          null,
          DateTime.now(),
        );
        expect(p2.id, p1.id);
        final d = await endpoints.jobs.get(a, job.id!);
        expect(d.photos, hasLength(1));
        expect(
          d.events.where((e) => e.type == JobEventType.photoAdded),
          hasLength(1),
        );
      },
    );

    test(
      'when the stored bytes do not match the device hash then the photo is refused and removed',
      () async {
        final a = as(sb, ownerA);
        final job = await endpoints.jobs.create(a, newOp(), sampleJob());
        final op = newOp();
        final bytes = fakeJpeg();
        await simulateUpload(
          sb.build(),
          shopId: shopA,
          jobId: job.id!,
          opId: op,
          bytes: bytes,
        );
        await expectLater(
          endpoints.evidence.registerPhoto(
            a,
            job.id!,
            op,
            'image/jpeg',
            '0' * 64,
            PhotoStage.intake,
            null,
            DateTime.now(),
          ),
          throwsFw(FwErrorCode.uploadRejected),
        );
        final again = await endpoints.evidence.preparePhotoUpload(
          a,
          job.id!,
          op,
          'image/jpeg',
          bytes.length,
        );
        expect(
          again.alreadyStored,
          isFalse,
          reason: 'the bad file was deleted, so the device uploads again',
        );
      },
    );

    test(
      'when registration comes before any upload then the bytes are reported missing',
      () async {
        final a = as(sb, ownerA);
        final job = await endpoints.jobs.create(a, newOp(), sampleJob());
        await expectLater(
          endpoints.evidence.registerPhoto(
            a,
            job.id!,
            newOp(),
            'image/jpeg',
            '0' * 64,
            PhotoStage.intake,
            null,
            DateTime.now(),
          ),
          throwsFw(FwErrorCode.uploadMissing),
        );
      },
    );
  });

  // These run real concurrent transactions, which the per-test rollback cannot
  // wrap, so rollback is disabled; each withServerpod group has its own
  // database anyway.
  withServerpod('Given concurrent requests', (sb, endpoints) {
    setUpAll(() => seedShops(sb, endpoints));

    test(
      'when two sessions create jobs at the same moment then job numbers are unique',
      () async {
        final jobs = await Future.wait([
          for (var i = 0; i < 10; i++)
            endpoints.jobs.create(
              as(sb, i.isEven ? ownerA : techA),
              newOp(),
              sampleJob(customer: 'Customer $i'),
            ),
        ]);
        expect(jobs.map((j) => j.jobNumber).toSet(), hasLength(10));
        expect(
          jobs.map((j) => j.jobNumber).toList()..sort(),
          List.generate(10, (i) => i + 1),
        );
      },
    );

    test(
      'when the same operation is retried concurrently then exactly one job is created',
      () async {
        final op = newOp();
        final jobs = await Future.wait([
          for (var i = 0; i < 6; i++)
            endpoints.jobs.create(
              as(sb, ownerA),
              op,
              sampleJob(customer: 'Same'),
            ),
        ]);
        expect(jobs.map((j) => j.id).toSet(), hasLength(1));
      },
    );

    test(
      'when approval of v1 races issuing v2 then the result is always one of the two serial orders',
      () async {
        final owner = as(sb, ownerA);
        final tech = as(sb, techA);
        var approvalFirst = 0;
        for (var i = 0; i < 15; i++) {
          final job = await endpoints.jobs.create(
            owner,
            newOp(),
            sampleJob(customer: 'Race $i'),
          );
          final v1 = await endpoints.jobs.issueEstimate(
            owner,
            job.id!,
            null,
            lines([('Part', 1, 10000)]),
            null,
            null,
          );
          final token = tokenOf(
            await endpoints.links.create(owner, job.id!, 1),
          );
          final outcome = await Future.wait([
            endpoints.customer
                .approve(
                  anonymous(sb),
                  token,
                  v1.id!,
                  1,
                  v1.contentHash,
                  'Racer',
                )
                .then(
                  (_) => 'approved',
                  onError: (Object e) => (e as FwException).code.name,
                ),
            endpoints.jobs
                .issueEstimate(
                  tech,
                  job.id!,
                  1,
                  lines([('Part', 1, 20000)]),
                  null,
                  'Price changed',
                )
                .then(
                  (_) => 'issued',
                  onError: (Object e) => (e as FwException).code.name,
                ),
          ]);
          final d = await endpoints.jobs.get(owner, job.id!);
          final status = {
            for (final e in d.estimates) e.versionNumber: e.status,
          };
          if (outcome[0] == 'approved') {
            approvalFirst++;
            expect(status, {
              1: EstimateStatus.approved,
              2: EstimateStatus.issued,
            });
            expect(d.authorization.authorizedVersion, 1);
            expect(d.authorization.revisionPending, isTrue);
          } else {
            expect(outcome[0], 'estimateOutdated');
            expect(status, {
              1: EstimateStatus.superseded,
              2: EstimateStatus.issued,
            });
            expect(d.decisions, isEmpty);
            expect(d.job.authorizedEstimateId, isNull);
          }
          expect(outcome[1], 'issued');
          expect(
            d.events.map((e) => e.seq),
            List.generate(d.events.length, (k) => k + 1),
          );
        }
        // Both orders are legal; print the split so a run shows real contention.
        // ignore: avoid_print
        print('approve-first: $approvalFirst / 15');
      },
    );
  }, rollbackDatabase: RollbackDatabase.disabled);
}
