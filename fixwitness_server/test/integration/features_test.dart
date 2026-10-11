import 'package:fixwitness_server/src/fixwitness/maintenance.dart';
import 'package:fixwitness_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given a shop device watching for live changes', (
    sb,
    endpoints,
  ) {
    setUpAll(() => seedShops(sb, endpoints));

    test(
      'when the customer approves on their link then the shop is told at once',
      () async {
        final owner = as(sb, ownerA);
        final job = await endpoints.jobs.create(owner, newOp(), sampleJob());
        final v1 = await endpoints.jobs.issueEstimate(
          owner,
          job.id!,
          null,
          lines([('Screen', 1, 400000)]),
          null,
          null,
        );
        final token = tokenOf(await endpoints.links.create(owner, job.id!, 7));

        final changes = <JobChange>[];
        final sub = endpoints.shop.watch(as(sb, techA)).listen(changes.add);
        await flushEventQueue();

        await endpoints.customer.approve(
          anonymous(sb),
          token,
          v1.id!,
          1,
          v1.contentHash,
          'Asha',
        );
        await endpoints.jobs.addNote(
          owner,
          job.id!,
          newOp(),
          'Part ordered',
          false,
          DateTime.now(),
        );
        await flushEventQueue();
        await Future<void>.delayed(const Duration(milliseconds: 200));

        expect(changes.map((c) => c.summary), [
          'Customer approved estimate v1.',
          'Note added by Ravi.',
        ]);
        expect(changes.first.fromCustomer, isTrue);
        expect(changes.first.jobId, job.id);
        await sub.cancel();
      },
    );

    test(
      'when another shop changes a job then this shop hears nothing',
      () async {
        final changes = <JobChange>[];
        final sub = endpoints.shop.watch(as(sb, ownerA)).listen(changes.add);
        await flushEventQueue();
        await endpoints.jobs.create(as(sb, ownerB), newOp(), sampleJob());
        await flushEventQueue();
        await Future<void>.delayed(const Duration(milliseconds: 200));
        expect(changes, isEmpty);
        await sub.cancel();
      },
    );
  }, rollbackDatabase: RollbackDatabase.disabled);

  withServerpod('Given technician invites', (sb, endpoints) {
    const newTech = '55555555-5555-4555-8555-555555555555';
    const another = '66666666-6666-4666-8666-666666666666';

    setUp(() => seedShops(sb, endpoints));

    test(
      'when a technician joins with the owner\'s code then they work in that shop',
      () async {
        final invite = await endpoints.shop.createInvite(as(sb, ownerA));
        expect(invite.code, matches(RegExp(r'^[A-Z2-9]{4}-[A-Z2-9]{4}$')));
        final ctx = await endpoints.shop.joinShop(
          as(sb, newTech),
          invite.code.toLowerCase(),
          'Meera',
        );
        expect(ctx.shop.name, 'Fix Point');
        expect(ctx.member.role, ShopRole.technician);
        final job = await endpoints.jobs.create(
          as(sb, ownerA),
          newOp(),
          sampleJob(),
        );
        expect(
          (await endpoints.jobs.get(as(sb, newTech), job.id!)).job.id,
          job.id,
        );
      },
    );

    test('when a code is used twice then the second use is refused', () async {
      final invite = await endpoints.shop.createInvite(as(sb, ownerA));
      await endpoints.shop.joinShop(as(sb, newTech), invite.code, 'Meera');
      await expectLater(
        endpoints.shop.joinShop(as(sb, another), invite.code, 'Arjun'),
        throwsFw(FwErrorCode.inviteInvalid),
      );
    });

    test(
      'when a code has expired or is made up then joining is refused',
      () async {
        final invite = await endpoints.shop.createInvite(as(sb, ownerA));
        final session = sb.build();
        final row = (await ShopInvite.db.find(session)).single;
        await ShopInvite.db.updateRow(
          session,
          row.copyWith(
            expiresAt: DateTime.now().toUtc().subtract(
              const Duration(minutes: 1),
            ),
          ),
        );
        await expectLater(
          endpoints.shop.joinShop(as(sb, newTech), invite.code, 'Meera'),
          throwsFw(FwErrorCode.inviteInvalid),
        );
        await expectLater(
          endpoints.shop.joinShop(as(sb, newTech), 'ABCD-EFGH', 'Meera'),
          throwsFw(FwErrorCode.inviteInvalid),
        );
      },
    );

    test('when a technician tries to invite then it is refused', () async {
      await expectLater(
        endpoints.shop.createInvite(as(sb, techA)),
        throwsFw(FwErrorCode.forbidden),
      );
    });

    test(
      'when a member of one shop tries to join another then it is refused',
      () async {
        final invite = await endpoints.shop.createInvite(as(sb, ownerA));
        await expectLater(
          endpoints.shop.joinShop(as(sb, ownerB), invite.code, 'Kiran'),
          throwsFw(FwErrorCode.validation),
        );
      },
    );
  });

  withServerpod('Given uploaded photo bytes', (sb, endpoints) {
    late int shopA;
    late RepairJob job;

    setUp(() async {
      shopA = (await seedShops(sb, endpoints)).shopA;
      job = await endpoints.jobs.create(as(sb, ownerA), newOp(), sampleJob());
    });

    Future<UuidValue> upload({required bool register}) async {
      final op = newOp();
      final bytes = fakeJpeg();
      await endpoints.evidence.preparePhotoUpload(
        as(sb, ownerA),
        job.id!,
        op,
        'image/jpeg',
        bytes.length,
      );
      await simulateUpload(
        sb.build(),
        shopId: shopA,
        jobId: job.id!,
        opId: op,
        bytes: bytes,
      );
      if (register) {
        await endpoints.evidence.registerPhoto(
          as(sb, ownerA),
          job.id!,
          op,
          'image/jpeg',
          sha(bytes),
          PhotoStage.intake,
          null,
          DateTime.now(),
        );
      }
      return op;
    }

    String path(UuidValue op) =>
        'shops/$shopA/jobs/${job.id}/photos/${op.uuid}.jpg';

    test(
      'when an upload was never registered then the sweep deletes it after the grace period',
      () async {
        final orphan = await upload(register: false);
        final kept = await upload(register: true);
        final session = sb.build();

        expect(
          await sweepOrphanUploads(session),
          0,
          reason: 'young grants are left alone',
        );
        expect(await sweepOrphanUploads(session, olderThan: Duration.zero), 1);

        expect(
          await session.storage.fileExists(
            storageId: 'private',
            path: path(orphan),
          ),
          isFalse,
        );
        expect(
          await session.storage.fileExists(
            storageId: 'private',
            path: path(kept),
          ),
          isTrue,
          reason: 'registered evidence is never swept',
        );
        expect(await UploadGrant.db.count(session), 0);
      },
    );
  });
}
