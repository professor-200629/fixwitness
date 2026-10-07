// Demo helper for a running development server.
//
//   set FW_DEMO_PASSWORD=<a password of your choice>
//   dart run bin/demo.dart seed          # demo shop + one job ready for review
//   dart run bin/demo.dart revise <job>  # shop issues the next estimate version
//   dart run bin/demo.dart status <job>  # what the server says about the job
//
// The demo account is registered on first use through the email provider
// (development mode writes the verification code to the dev mailbox).

import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:fixwitness_e2e/harness.dart';

const demoEmail = 'demo.shop@example.com';

Future<void> main(List<String> args) async {
  final password = Platform.environment['FW_DEMO_PASSWORD'];
  if (password == null || password.length < 12) {
    stderr.writeln(
      'Set FW_DEMO_PASSWORD (12+ characters, upper, lower, digit, symbol).',
    );
    exit(2);
  }
  final h = Harness(
    apiUrl: Platform.environment['FW_API'] ?? 'http://localhost:8080/',
    mailbox: File(
      '../fixwitness_server/.serverpod/development/dev_mailbox.jsonl',
    ),
  );
  final shop = await h.signIn(demoEmail, password);
  await ensureShop(shop, 'Fix Point Mobiles', 'Ravi');

  switch (args.firstOrNull) {
    case 'seed':
      await _seed(shop);
    case 'revise':
      await _revise(shop, int.parse(args[1]));
    case 'status':
      final d = await shop.jobs.get(int.parse(args[1]));
      stdout.writeln(
        '#${d.job.jobNumber} ${d.job.status.name} · ${d.authorization.label}',
      );
      for (final e in d.events) {
        stdout.writeln('  ${e.seq}. ${e.summary}');
      }
    default:
      stderr.writeln('usage: demo.dart seed | revise <jobId> | status <jobId>');
      exit(2);
  }
  exit(0);
}

Future<void> _seed(Client shop) async {
  final job = await shop.jobs.create(
    const Uuid().v4obj(),
    NewJobInput(
      customerName: 'Asha Rao',
      customerPhone: '+91 98450 12345',
      deviceMake: 'Samsung',
      deviceModel: 'Galaxy A52',
      deviceSerial: '356938035643809',
      reportedFault:
          'Dropped yesterday. Screen cracked, touch dead in the lower half.',
      accessories: 'Blue silicone case',
    ),
  );
  await shop.jobs.saveCondition(job.id!, const Uuid().v4obj(), [
    ConditionItem(
      key: 'screen',
      label: 'Screen / display',
      state: ConditionState.damaged,
      note: 'Crack from top-left corner',
    ),
    ConditionItem(
      key: 'touch',
      label: 'Touch response',
      state: ConditionState.notWorking,
      note: 'Lower third unresponsive',
    ),
    ConditionItem(
      key: 'backGlass',
      label: 'Back glass / cover',
      state: ConditionState.ok,
    ),
    ConditionItem(
      key: 'frame',
      label: 'Frame / housing',
      state: ConditionState.damaged,
      note: 'Dent on bottom-right corner',
    ),
    ConditionItem(
      key: 'rearCamera',
      label: 'Rear camera',
      state: ConditionState.ok,
    ),
    ConditionItem(
      key: 'chargingPort',
      label: 'Charging port',
      state: ConditionState.ok,
    ),
    ConditionItem(
      key: 'biometrics',
      label: 'Face / fingerprint unlock',
      state: ConditionState.notTested,
      note: 'Customer kept passcode; not tested',
    ),
  ], DateTime.now());
  // Placeholder image (the app icon), labelled as such: real photos come from
  // the phone camera in the shop app.
  final png = await File(
    '../fixwitness_flutter/web/icons/Icon-512.png',
  ).readAsBytes();
  final photoOp = const Uuid().v4obj();
  final ticket = await shop.evidence.preparePhotoUpload(
    job.id!,
    photoOp,
    'image/png',
    png.length,
  );
  if (!ticket.alreadyStored) {
    await FileUploader(
      ticket.uploadDescription!,
    ).uploadByteData(ByteData.sublistView(png));
  }
  await shop.evidence.registerPhoto(
    job.id!,
    photoOp,
    'image/png',
    sha256.convert(png).toString(),
    PhotoStage.intake,
    'Sample image (demo placeholder)',
    DateTime.now(),
  );
  await shop.jobs.addNote(
    job.id!,
    const Uuid().v4obj(),
    'Device received switched off. Customer will unlock it in person if testing needs it.',
    true,
    DateTime.now(),
  );
  final v1 = await shop.jobs.issueEstimate(
    job.id!,
    null,
    [
      EstimateLine(
        kind: LineKind.sparePart,
        description: 'Screen assembly (AMOLED, with frame)',
        quantity: 1,
        unitPriceMinor: 450000,
      ),
      EstimateLine(
        kind: LineKind.labour,
        description: 'Labour: screen replacement',
        quantity: 1,
        unitPriceMinor: 50000,
      ),
    ],
    'Includes 90-day warranty on the screen.',
    null,
  );
  final link = await shop.links.create(job.id!, 7);
  stdout.writeln(
    'Job id ${job.id} (#${job.jobNumber}), estimate v${v1.versionNumber} issued.',
  );
  stdout.writeln('Customer link: ${link.url}');
}

Future<void> _revise(Client shop, int jobId) async {
  final d = await shop.jobs.get(jobId);
  final current = d.estimates.lastOrNull;
  final next = await shop.jobs.issueEstimate(
    jobId,
    current?.versionNumber,
    [
      ...?current?.lines,
      EstimateLine(
        kind: LineKind.sparePart,
        description: 'Battery (swollen, found when opened)',
        quantity: 1,
        unitPriceMinor: 180000,
      ),
    ],
    current?.note,
    'Battery is swollen and pressing on the new screen; it must be replaced for the screen to sit flush.',
  );
  stdout.writeln('Issued v${next.versionNumber}: ${d.authorization.label}');
}
