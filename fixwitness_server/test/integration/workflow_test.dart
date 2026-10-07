import 'package:fixwitness_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given a shop with a checked-in device', (sb, endpoints) {
    late int shopA;
    late RepairJob job;

    setUp(() async {
      shopA = (await seedShops(sb, endpoints)).shopA;
      job = await endpoints.jobs.create(as(sb, ownerA), newOp(), sampleJob());
    });

    test('when the full repair runs then every step is recorded in order', () async {
      final owner = as(sb, ownerA);
      final tech = as(sb, techA);

      await endpoints.jobs.saveCondition(tech, job.id!, newOp(), [
        ConditionItem(key: 'screen', label: 'Screen', state: ConditionState.damaged, note: 'Crack from top-left'),
        ConditionItem(key: 'camera', label: 'Rear camera', state: ConditionState.ok),
      ], DateTime.now());

      final photoOp = newOp();
      final bytes = fakeJpeg();
      final ticket = await endpoints.evidence.preparePhotoUpload(tech, job.id!, photoOp, 'image/jpeg', bytes.length);
      expect(ticket.alreadyStored, isFalse);
      await simulateUpload(sb.build(), shopId: shopA, jobId: job.id!, opId: photoOp, bytes: bytes);
      await endpoints.evidence.registerPhoto(tech, job.id!, photoOp, 'image/jpeg', sha(bytes), PhotoStage.intake, 'Front', DateTime.now());

      final v1 = await endpoints.jobs.issueEstimate(owner, job.id!, null,
          lines([('Screen assembly', 1, 450000), ('Labour', 1, 50000)]), null, null);
      expect(v1.versionNumber, 1);
      expect(v1.totalMinor, 500000, reason: 'total is computed on the server in minor units');

      final link = await endpoints.links.create(owner, job.id!, 7);
      final token = tokenOf(link);
      final customer = anonymous(sb);

      var view = await endpoints.customer.view(customer, token);
      expect(view.canDecide, isTrue);
      expect(view.photos, hasLength(1));
      expect(view.condition!.items.first.state, ConditionState.damaged);

      await endpoints.customer.approve(customer, token, v1.id!, 1, v1.contentHash, 'Asha Rao');
      await endpoints.jobs.startWork(tech, job.id!);

      final v2 = await endpoints.jobs.issueEstimate(owner, job.id!, 1,
          lines([('Screen assembly', 1, 450000), ('Labour', 1, 50000), ('Battery', 1, 180000)]),
          null, 'Battery swollen once the back cover was opened');
      expect(v2.versionNumber, 2);

      var detail = await endpoints.jobs.get(owner, job.id!);
      expect(detail.job.status, JobStatus.awaitingApproval);
      expect(detail.authorization.authorizedVersion, 1,
          reason: 'only v1 is authorized while v2 waits');
      expect(detail.authorization.revisionPending, isTrue);
      expect(detail.estimates.first.status, EstimateStatus.approved,
          reason: 'an issued version is preserved with its decision');

      await expectLater(endpoints.jobs.completeRepair(tech, job.id!),
          throwsFw(FwErrorCode.invalidTransition));

      await endpoints.customer.approve(customer, token, v2.id!, 2, v2.contentHash, 'Asha Rao');
      await endpoints.jobs.startWork(tech, job.id!);
      await endpoints.jobs.completeRepair(tech, job.id!);
      await endpoints.customer.acknowledgeCollection(customer, token, 'Asha Rao');

      detail = await endpoints.jobs.get(owner, job.id!);
      expect(detail.job.status, JobStatus.collected);
      expect(detail.estimates.map((e) => e.status),
          [EstimateStatus.approved, EstimateStatus.approved]);
      expect(detail.decisions.map((d) => d.versionNumber), [1, 2]);
      expect(detail.events.map((e) => e.seq),
          List.generate(detail.events.length, (i) => i + 1),
          reason: 'history has no gaps');
      expect(detail.events.map((e) => e.type), containsAllInOrder([
        JobEventType.jobCreated,
        JobEventType.conditionRecorded,
        JobEventType.photoAdded,
        JobEventType.estimateIssued,
        JobEventType.estimateApproved,
        JobEventType.workStarted,
        JobEventType.estimateIssued,
        JobEventType.estimateApproved,
        JobEventType.repairCompleted,
        JobEventType.collectionAcknowledged,
      ]));
      expect(detail.job.eventSeq, detail.events.length);
    });

    test('when work is started before any approval then it is refused', () async {
      await expectLater(endpoints.jobs.startWork(as(sb, ownerA), job.id!),
          throwsFw(FwErrorCode.invalidTransition));
    });

    test('when a second version is issued from a stale view then it is refused', () async {
      final owner = as(sb, ownerA);
      await endpoints.jobs.issueEstimate(owner, job.id!, null, lines([('Screen', 1, 1000)]), null, null);
      await expectLater(
        endpoints.jobs.issueEstimate(owner, job.id!, null, lines([('Screen', 1, 2000)]), null, 'x'),
        throwsFw(FwErrorCode.estimateOutdated),
      );
    });

    test('when a revision has no reason then it is refused', () async {
      final owner = as(sb, ownerA);
      await endpoints.jobs.issueEstimate(owner, job.id!, null, lines([('Screen', 1, 1000)]), null, null);
      await expectLater(
        endpoints.jobs.issueEstimate(owner, job.id!, 1, lines([('Screen', 1, 2000)]), null, null),
        throwsFw(FwErrorCode.validation),
      );
    });

    test('when text records a device passcode then it is refused', () async {
      await expectLater(
        endpoints.jobs.addNote(as(sb, techA), job.id!, newOp(), 'Customer passcode 4821', false, DateTime.now()),
        throwsFw(FwErrorCode.sensitiveContent),
      );
      final ok = await endpoints.jobs.addNote(as(sb, techA), job.id!, newOp(), 'PIN connector loose on charging port', false, DateTime.now());
      expect(ok.id, isNotNull);
    });

    test('when estimate lines are out of range then they are refused', () async {
      final owner = as(sb, ownerA);
      await expectLater(endpoints.jobs.issueEstimate(owner, job.id!, null, [], null, null),
          throwsFw(FwErrorCode.validation));
      await expectLater(endpoints.jobs.issueEstimate(owner, job.id!, null, lines([('Screen', 0, 1000)]), null, null),
          throwsFw(FwErrorCode.validation));
      await expectLater(endpoints.jobs.issueEstimate(owner, job.id!, null, lines([('Screen', 1, -5)]), null, null),
          throwsFw(FwErrorCode.validation));
    });
  });
}
