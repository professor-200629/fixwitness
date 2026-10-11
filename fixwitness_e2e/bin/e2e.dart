// End-to-end verification against a running FixWitness server.
//
//   dart run bin/e2e.dart                       # all checks
//   dart run bin/e2e.dart --phase before-restart
//   (restart the server)
//   dart run bin/e2e.dart --phase after-restart
//
// Uses only the generated client over HTTP, the same way the apps do.
// Accounts are registered through the email identity provider; in development
// mode the server writes verification codes to its dev mailbox file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:fixwitness_e2e/harness.dart';

late final String apiUrl;
late final File mailbox;
late final Harness h;
final results = <({String name, bool ok, String detail})>[];

void check(String name, bool ok, [String detail = '']) {
  results.add((name: name, ok: ok, detail: detail));
  stdout.writeln(
    '${ok ? 'PASS' : 'FAIL'}  $name${detail.isEmpty ? '' : '\n      $detail'}',
  );
}

Future<void> expectFw(
  String name,
  Future<Object?> Function() call,
  FwErrorCode code, {
  bool Function(FwException)? also,
}) async {
  try {
    await call();
    check(
      name,
      false,
      'expected FwException(${code.name}) but the call succeeded',
    );
  } on FwException catch (e) {
    final extra = also == null || also(e);
    check(name, e.code == code && extra, '${e.code.name}: ${e.message}');
  } catch (e) {
    check(
      name,
      false,
      'expected FwException(${code.name}), got ${e.runtimeType}: $e',
    );
  }
}

UuidValue op() => const Uuid().v4obj();

NewJobInput intake(String customer, String model) => NewJobInput(
  customerName: customer,
  customerPhone: '+91 98450 ${10000 + customer.length * 7}',
  deviceMake: 'Samsung',
  deviceModel: model,
  reportedFault: 'Cracked screen, touch not responding in the lower half',
  accessories: 'Case',
);

List<EstimateLine> lines(List<(String, int)> l) => [
  for (final (d, p) in l)
    EstimateLine(
      kind: LineKind.sparePart,
      description: d,
      quantity: 1,
      unitPriceMinor: p,
    ),
];

Future<void> main(List<String> args) async {
  String arg(String name, String fallback) {
    final i = args.indexOf(name);
    return i >= 0 && i + 1 < args.length ? args[i + 1] : fallback;
  }

  apiUrl = arg('--api', 'http://localhost:8080/');
  mailbox = File(
    arg(
      '--mailbox',
      '../fixwitness_server/.serverpod/development/dev_mailbox.jsonl',
    ),
  );
  h = Harness(apiUrl: apiUrl, mailbox: mailbox);
  final phase = arg('--phase', 'all');
  final stateFile = File(arg('--state', '.e2e_state.json'));
  final run = DateTime.now().millisecondsSinceEpoch.toString().substring(7);
  stdout.writeln('FixWitness e2e against $apiUrl (phase: $phase, run $run)\n');

  // Two independent sessions for the same owner, one owner of another shop.
  const pwA = 'E2e-Owner-A-pass1!';
  const pwB = 'E2e-Owner-B-pass1!';
  final ownerEmail = 'e2e.owner.a@example.com';
  final sessionA1 = await h.signIn(ownerEmail, pwA);
  final sessionA2 = await h.signIn(ownerEmail, pwA);
  final ownerB = await h.signIn('e2e.owner.b@example.com', pwB);
  final shopA = await ensureShop(sessionA1, 'E2E Fix Point', 'Ravi');
  await ensureShop(ownerB, 'E2E Other Shop', 'Kiran');
  final customer = h.anonymousClient();

  if (phase == 'after-restart') {
    await _afterRestart(sessionA1, customer, stateFile);
    return _finish();
  }

  // 1. Fresh job creation on two separate sessions, at the same moment.
  final created = await Future.wait([
    sessionA1.jobs.create(op(), intake('Asha $run', 'Galaxy A52')),
    sessionA2.jobs.create(op(), intake('Vikram $run', 'Redmi Note 12')),
  ]);
  check(
    'two sessions create jobs concurrently with distinct job numbers',
    created[0].jobNumber != created[1].jobNumber &&
        created.every((j) => j.shopId == shopA.shop.id),
    'job numbers ${created.map((j) => j.jobNumber).join(' and ')}',
  );
  final listed = await sessionA2.jobs.list();
  check(
    'each session sees both new jobs',
    created.every((j) => listed.any((s) => s.id == j.id)),
  );

  // 2. Duplicate retries of the same operation (job, note, photo).
  final jobOp = op();
  final dupes = await Future.wait([
    for (var i = 0; i < 5; i++)
      sessionA1.jobs.create(jobOp, intake('Retry $run', 'iPhone 12')),
  ]);
  check(
    '5 concurrent retries of one createJob produce one job',
    dupes.map((j) => j.id).toSet().length == 1,
    'job id ${dupes.first.id}',
  );
  final job = created[0];
  final noteOp = op();
  final n1 = await sessionA1.jobs.addNote(
    job.id!,
    noteOp,
    'Screen ordered',
    true,
    DateTime.now(),
  );
  final n2 = await sessionA2.jobs.addNote(
    job.id!,
    noteOp,
    'Screen ordered',
    true,
    DateTime.now(),
  );
  check('retried note returns the same note', n1.id == n2.id);

  // 3. Photo upload; then an interrupted upload whose metadata call failed.
  final png = await File(
    '../fixwitness_flutter/web/icons/Icon-512.png',
  ).readAsBytes();
  final hash = sha256.convert(png).toString();
  final photoOp = op();
  final ticket = await sessionA1.evidence.preparePhotoUpload(
    job.id!,
    photoOp,
    'image/png',
    png.length,
  );
  final uploaded = await FileUploader(
    ticket.uploadDescription!,
  ).uploadByteData(ByteData.sublistView(png));
  check('photo bytes upload to private storage', uploaded);
  // Simulate: the metadata request never reached the server. The device retries.
  final again = await sessionA1.evidence.preparePhotoUpload(
    job.id!,
    photoOp,
    'image/png',
    png.length,
  );
  check(
    'after an upload whose metadata failed, the server reports the bytes as already stored',
    again.alreadyStored && again.uploadDescription == null,
  );
  final p1 = await sessionA1.evidence.registerPhoto(
    job.id!,
    photoOp,
    'image/png',
    hash,
    PhotoStage.intake,
    'Front, cracked',
    DateTime.now(),
  );
  final p2 = await sessionA1.evidence.registerPhoto(
    job.id!,
    photoOp,
    'image/png',
    hash,
    PhotoStage.intake,
    'Front, cracked',
    DateTime.now(),
  );
  check(
    'retried photo registration returns the same photo',
    p1.id == p2.id,
    'photo id ${p1.id}',
  );
  final badOp = op();
  await expectFw(
    'registering a photo whose bytes never arrived is refused',
    () => sessionA1.evidence.registerPhoto(
      job.id!,
      badOp,
      'image/png',
      hash,
      PhotoStage.intake,
      null,
      DateTime.now(),
    ),
    FwErrorCode.uploadMissing,
  );
  // A truncated body against the declared length is refused by storage itself.
  final shortOp = op();
  final t3 = await sessionA1.evidence.preparePhotoUpload(
    job.id!,
    shortOp,
    'image/png',
    png.length,
  );
  final shortOk = await FileUploader(t3.uploadDescription!).uploadByteData(
    ByteData.sublistView(Uint8List.fromList(png.sublist(0, 400))),
  );
  check('storage refuses a body shorter than the declared length', !shortOk);
  await expectFw(
    'registering after a refused upload reports the bytes missing',
    () => sessionA1.evidence.registerPhoto(
      job.id!,
      shortOp,
      'image/png',
      hash,
      PhotoStage.intake,
      null,
      DateTime.now(),
    ),
    FwErrorCode.uploadMissing,
  );
  // Bytes that arrive intact in size but differ from what the device hashed.
  final corruptOp = op();
  final damaged = Uint8List.fromList(png)..[png.length - 1] ^= 0xFF;
  final t5 = await sessionA1.evidence.preparePhotoUpload(
    job.id!,
    corruptOp,
    'image/png',
    png.length,
  );
  await FileUploader(
    t5.uploadDescription!,
  ).uploadByteData(ByteData.sublistView(damaged));
  await expectFw(
    'bytes that do not match the device hash are rejected and removed',
    () => sessionA1.evidence.registerPhoto(
      job.id!,
      corruptOp,
      'image/png',
      hash,
      PhotoStage.intake,
      null,
      DateTime.now(),
    ),
    FwErrorCode.uploadRejected,
  );
  final t4 = await sessionA1.evidence.preparePhotoUpload(
    job.id!,
    corruptOp,
    'image/png',
    png.length,
  );
  check(
    'after a rejected upload the device gets a fresh upload description',
    !t4.alreadyStored,
  );
  await expectFw(
    'non-image content types are refused',
    () => sessionA1.evidence.preparePhotoUpload(
      job.id!,
      op(),
      'application/pdf',
      1000,
    ),
    FwErrorCode.uploadRejected,
  );

  // 4. Estimates, outdated approval rejection, exact-version approval.
  await sessionA1.jobs.saveCondition(job.id!, op(), [
    ConditionItem(
      key: 'screen',
      label: 'Screen / display',
      state: ConditionState.damaged,
      note: 'Crack from top-left corner',
    ),
    ConditionItem(
      key: 'rearCamera',
      label: 'Rear camera',
      state: ConditionState.ok,
    ),
  ], DateTime.now());
  final v1 = await sessionA1.jobs.issueEstimate(
    job.id!,
    null,
    lines([('Screen assembly', 450000), ('Labour', 50000)]),
    null,
    null,
  );
  final link = await sessionA1.links.create(job.id!, 7);
  final token = tokenOf(link);
  final view = await customer.customer.view(token);
  check(
    'customer sees v1 and may decide',
    view.canDecide && view.currentEstimate?.versionNumber == 1,
  );
  check(
    'customer sees intake photo via a signed URL',
    view.photos.length == 1 && view.photos.first.url.contains('temporaryFile'),
  );
  final photoResp = await HttpClient()
      .getUrl(Uri.parse(view.photos.first.url))
      .then((r) => r.close());
  final photoBytes = await photoResp.fold<List<int>>(
    [],
    (a, b) => a..addAll(b),
  );
  check(
    'signed photo URL serves the exact uploaded bytes',
    sha256.convert(photoBytes).toString() == hash,
    'HTTP ${photoResp.statusCode}, ${photoBytes.length} bytes',
  );

  final v2 = await sessionA1.jobs.issueEstimate(
    job.id!,
    1,
    lines([
      ('Screen assembly', 450000),
      ('Labour', 50000),
      ('Battery', 180000),
    ]),
    null,
    'Battery found swollen',
  );
  await expectFw(
    'approving outdated v1 after v2 was issued is rejected with an explanation',
    () => customer.customer.approve(token, v1.id!, 1, v1.contentHash, 'Asha'),
    FwErrorCode.estimateOutdated,
    also: (e) =>
        e.attemptedVersion == 1 &&
        e.currentVersion == 2 &&
        e.message.contains('v2'),
  );
  await expectFw(
    'approving v2 with a tampered content hash is rejected',
    () => customer.customer.approve(token, v2.id!, 2, 'deadbeef', 'Asha'),
    FwErrorCode.estimateOutdated,
  );
  await expectFw(
    'a signed-in shop account cannot approve on the customer link',
    () => sessionA1.customer.approve(token, v2.id!, 2, v2.contentHash, 'Asha'),
    FwErrorCode.shopAccountCannotApprove,
  );
  await customer.customer.approve(token, v2.id!, 2, v2.contentHash, 'Asha Rao');
  var detail = await sessionA1.jobs.get(job.id!);
  check(
    'approval references the exact version and hash',
    detail.decisions.single.versionNumber == 2 &&
        detail.decisions.single.contentHash == v2.contentHash,
  );
  check(
    'issued versions are preserved (v1 superseded, v2 approved)',
    detail.estimates
            .map((e) => '${e.versionNumber}:${e.status.name}')
            .join(',') ==
        '1:superseded,2:approved',
  );
  check(
    'refused approval attempt is in the history',
    detail.events.any((e) => e.type == JobEventType.approvalRejected),
  );

  // Revised work is not authorized until approved.
  await sessionA1.jobs.startWork(job.id!);
  await sessionA1.jobs.issueEstimate(
    job.id!,
    2,
    lines([
      ('Screen assembly', 450000),
      ('Labour', 50000),
      ('Battery', 180000),
      ('Charging port', 90000),
    ]),
    null,
    'Charging port loose',
  );
  detail = await sessionA1.jobs.get(job.id!);
  check(
    'revision v3 shows only v2 as authorized',
    detail.authorization.authorizedVersion == 2 &&
        detail.authorization.revisionPending,
    detail.authorization.label,
  );
  await expectFw(
    'completing while v3 awaits approval is refused',
    () => sessionA1.jobs.completeRepair(job.id!),
    FwErrorCode.invalidTransition,
  );

  // 5. Concurrent estimate change and approval (10 jobs, raced).
  var consistent = 0;
  var approvalsWon = 0;
  const races = 10;
  for (var i = 0; i < races; i++) {
    final j = await sessionA1.jobs.create(
      op(),
      intake('Race $i $run', 'Pixel 7'),
    );
    final e1 = await sessionA1.jobs.issueEstimate(
      j.id!,
      null,
      lines([('Part', 10000)]),
      null,
      null,
    );
    final tk = tokenOf(await sessionA1.links.create(j.id!, 1));
    final outcomes = await Future.wait([
      customer.customer
          .approve(tk, e1.id!, 1, e1.contentHash, 'Racer')
          .then(
            (_) => 'approved',
            onError: (Object e) => e is FwException ? e.code.name : '$e',
          ),
      sessionA2.jobs
          .issueEstimate(
            j.id!,
            1,
            lines([('Part', 20000)]),
            null,
            'Price changed',
          )
          .then(
            (_) => 'issued',
            onError: (Object e) => e is FwException ? e.code.name : '$e',
          ),
    ]);
    final d = await sessionA1.jobs.get(j.id!);
    final ver = {for (final e in d.estimates) e.versionNumber: e.status};
    final approvedFirst =
        outcomes[0] == 'approved' &&
        outcomes[1] == 'issued' &&
        ver[1] == EstimateStatus.approved &&
        ver[2] == EstimateStatus.issued &&
        d.authorization.authorizedVersion == 1 &&
        d.authorization.revisionPending &&
        d.job.status == JobStatus.awaitingApproval;
    final revisedFirst =
        outcomes[0] == 'estimateOutdated' &&
        outcomes[1] == 'issued' &&
        ver[1] == EstimateStatus.superseded &&
        ver[2] == EstimateStatus.issued &&
        d.authorization.authorizedVersion == null &&
        d.decisions.isEmpty;
    if (approvedFirst) approvalsWon++;
    if (approvedFirst || revisedFirst) consistent++;
    if (!approvedFirst && !revisedFirst)
      stdout.writeln(
        '      race $i inconsistent: $outcomes $ver ${d.authorization.label}',
      );
  }
  check(
    'concurrent approve(v1) vs issue(v2): every outcome is one of the two serial orders',
    consistent == races,
    '$consistent/$races consistent; approval committed first in $approvalsWon, revision first in ${races - approvalsWon}',
  );

  // 5b. Live updates over the websocket, and technician invites.
  final liveJob = await sessionA1.jobs.create(
    op(),
    intake('Live $run', 'Pixel 7'),
  );
  final liveV1 = await sessionA1.jobs.issueEstimate(
    liveJob.id!,
    null,
    lines([('Battery', 180000)]),
    null,
    null,
  );
  final liveToken = tokenOf(await sessionA1.links.create(liveJob.id!, 1));
  final heard = <JobChange>[];
  final otherShopHeard = <JobChange>[];
  final watchA = sessionA2.shop.watch().listen(heard.add);
  final watchB = ownerB.shop.watch().listen(otherShopHeard.add);
  await Future<void>.delayed(const Duration(seconds: 2));
  final approvedAt = DateTime.now();
  await customer.customer.approve(
    liveToken,
    liveV1.id!,
    1,
    liveV1.contentHash,
    'Live $run',
  );
  final deadline = DateTime.now().add(const Duration(seconds: 10));
  while (!heard.any((c) => c.jobId == liveJob.id && c.fromCustomer) &&
      DateTime.now().isBefore(deadline)) {
    await Future<void>.delayed(const Duration(milliseconds: 50));
  }
  final approvalHeard = heard
      .where((c) => c.jobId == liveJob.id && c.fromCustomer)
      .firstOrNull;
  check(
    'another shop device hears the customer approval over the websocket',
    approvalHeard?.summary == 'Customer approved estimate v1.',
    approvalHeard == null
        ? 'nothing received in 10 s (${heard.length} other changes)'
        : '"${approvalHeard.summary}" after '
              '${DateTime.now().difference(approvedAt).inMilliseconds} ms',
  );
  check(
    'a different shop hears nothing about it',
    !otherShopHeard.any((c) => c.jobId == liveJob.id),
  );
  await watchA.cancel();
  await watchB.cancel();

  final tech = await h.signIn('e2e.tech.a@example.com', 'E2e-Tech-A-pass1!');
  final techShop = await tech.shop.myShop();
  if (techShop == null) {
    final invite = await sessionA1.shop.createInvite();
    final joined = await tech.shop.joinShop(invite.code.toLowerCase(), 'Meena');
    check(
      'a new account joins the shop with the owner\'s invite code',
      joined.shop.id == shopA.shop.id &&
          joined.member.role == ShopRole.technician,
      'role ${joined.member.role.name}',
    );
  } else {
    check(
      'the invited technician is still a member of the shop',
      techShop.shop.id == shopA.shop.id &&
          techShop.member.role == ShopRole.technician,
      'joined on an earlier run',
    );
  }
  check(
    'the technician sees the shop\'s jobs',
    (await tech.jobs.list()).any((s) => s.id == liveJob.id),
  );
  await expectFw(
    'a technician cannot create invites',
    () => tech.shop.createInvite(),
    FwErrorCode.forbidden,
  );

  // 6. Unauthorized access.
  await expectFw(
    'another shop cannot read this job',
    () => ownerB.jobs.get(job.id!),
    FwErrorCode.notFound,
  );
  await expectFw(
    'another shop cannot add a note',
    () => ownerB.jobs.addNote(job.id!, op(), 'x', false, DateTime.now()),
    FwErrorCode.notFound,
  );
  await expectFw(
    'another shop cannot fetch a photo URL',
    () => ownerB.evidence.photoUrl(p1.id!),
    FwErrorCode.notFound,
  );
  await expectFw(
    'another shop cannot create a customer link',
    () => ownerB.links.create(job.id!, 7),
    FwErrorCode.notFound,
  );
  try {
    await customer.jobs.list();
    check('unauthenticated client cannot list jobs', false, 'call succeeded');
  } on ServerpodClientException catch (e) {
    check('unauthenticated client cannot list jobs', true, '${e.runtimeType}');
  }
  final other = created[1];
  final otherEst = await sessionA1.jobs.issueEstimate(
    other.id!,
    null,
    lines([('Battery', 150000)]),
    null,
    null,
  );
  await expectFw(
    "a customer link cannot act on another job's estimate",
    () => customer.customer.approve(
      token,
      otherEst.id!,
      1,
      otherEst.contentHash,
      'Asha',
    ),
    FwErrorCode.notFound,
  );
  await expectFw(
    'a made-up token is refused',
    () => customer.customer.view('A' * 43),
    FwErrorCode.linkInvalid,
  );
  final revocable = await sessionA1.links.create(other.id!, 7);
  await sessionA1.links.revoke(revocable.link.id!);
  await expectFw(
    'a revoked link stops working',
    () => customer.customer.view(tokenOf(revocable)),
    FwErrorCode.linkRevoked,
  );
  await expectFw(
    'device passcodes are refused in notes',
    () => sessionA1.jobs.addNote(
      job.id!,
      op(),
      'Customer passcode 4821',
      false,
      DateTime.now(),
    ),
    FwErrorCode.sensitiveContent,
  );

  // 7. State for the persistence check across a server restart.
  final snapshot = await sessionA1.jobs.get(job.id!);
  await stateFile.writeAsString(
    jsonEncode({
      'jobId': job.id,
      'token': token,
      'rowVersion': snapshot.job.rowVersion,
      'events': snapshot.events.length,
      'estimates': [
        for (final e in snapshot.estimates)
          '${e.versionNumber}:${e.status.name}:${e.contentHash}',
      ],
      'photoHash': hash,
    }),
  );
  check('saved state for the restart check', true, stateFile.path);
  if (phase == 'all')
    await _afterRestart(
      sessionA1,
      customer,
      stateFile,
      label: '(same process)',
    );
  _finish();
}

Future<void> _afterRestart(
  Client shop,
  Client customer,
  File stateFile, {
  String label = 'after server restart',
}) async {
  final s = jsonDecode(await stateFile.readAsString()) as Map<String, dynamic>;
  final d = await shop.jobs.get(s['jobId'] as int);
  check(
    'job, estimates and history persist $label',
    d.job.rowVersion == s['rowVersion'] &&
        d.events.length == s['events'] &&
        d.estimates
                .map(
                  (e) => '${e.versionNumber}:${e.status.name}:${e.contentHash}',
                )
                .join('|') ==
            (s['estimates'] as List).join('|'),
    'rowVersion ${d.job.rowVersion}, ${d.events.length} events, ${d.estimates.length} estimates',
  );
  final v = await customer.customer.view(s['token'] as String);
  final resp = await HttpClient()
      .getUrl(Uri.parse(v.photos.first.url))
      .then((r) => r.close());
  final bytes = await resp.fold<List<int>>([], (a, b) => a..addAll(b));
  check(
    'customer link and stored photo still work $label',
    sha256.convert(bytes).toString() == s['photoHash'],
  );
}

void _finish() {
  final failed = results.where((r) => !r.ok).length;
  stdout.writeln(
    '\n${results.length - failed}/${results.length} checks passed.',
  );
  final report = File('e2e_report.json');
  report.writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert([
      for (final r in results)
        {'check': r.name, 'ok': r.ok, 'detail': r.detail},
    ]),
  );
  exit(failed == 0 ? 0 : 1);
}
