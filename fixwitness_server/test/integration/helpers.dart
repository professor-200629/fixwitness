import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:fixwitness_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const ownerA = '11111111-1111-4111-8111-111111111111';
const techA = '22222222-2222-4222-8222-222222222222';
const ownerB = '33333333-3333-4333-8333-333333333333';
const stranger = '44444444-4444-4444-8444-444444444444';

TestSessionBuilder as(TestSessionBuilder base, String userId) => base.copyWith(
  authentication: AuthenticationOverride.authenticationInfo(userId, {}),
);

TestSessionBuilder anonymous(TestSessionBuilder base) => base.copyWith(
  authentication: AuthenticationOverride.unauthenticated(),
);

UuidValue newOp() => const Uuid().v4obj();

NewJobInput sampleJob({String customer = 'Asha Rao'}) => NewJobInput(
  customerName: customer,
  customerPhone: '+91 98450 12345',
  deviceMake: 'Samsung',
  deviceModel: 'Galaxy A52',
  deviceSerial: '356938035643809',
  reportedFault: 'Cracked screen, touch not working in the lower half',
  accessories: 'Blue case',
);

List<EstimateLine> lines(List<(String, int, int)> spec) => [
  for (final (description, qty, price) in spec)
    EstimateLine(
      kind: LineKind.sparePart,
      description: description,
      quantity: qty,
      unitPriceMinor: price,
    ),
];

/// Creates shop A (owner + technician) and shop B. Returns their ids.
Future<({int shopA, int shopB})> seedShops(
  TestSessionBuilder sb,
  TestEndpoints endpoints,
) async {
  final a = await endpoints.shop.createShop(as(sb, ownerA), 'Fix Point', 'Ravi');
  await ShopMember.db.insertRow(
    sb.build(),
    ShopMember(
      shopId: a.shop.id!,
      authUserId: UuidValue.fromString(techA),
      displayName: 'Meena',
      role: ShopRole.technician,
    ),
  );
  final b = await endpoints.shop.createShop(as(sb, ownerB), 'Other Shop', 'Kiran');
  return (shopA: a.shop.id!, shopB: b.shop.id!);
}

/// Extracts the token from a customer URL (`.../#/r/<token>`).
String tokenOf(CreatedLink link) => link.url.split('/r/').last;

/// A tiny valid JPEG header followed by filler; enough for magic-byte checks.
Uint8List fakeJpeg([int size = 2048]) {
  final b = Uint8List(size);
  b[0] = 0xFF;
  b[1] = 0xD8;
  b[2] = 0xFF;
  for (var i = 3; i < size; i++) {
    b[i] = i % 251;
  }
  return b;
}

String sha(Uint8List bytes) => sha256.convert(bytes).toString();

/// Simulates the device upload by writing the bytes where the server's upload
/// description points (the path is derived the same way as on the server).
Future<void> simulateUpload(
  Session session, {
  required int shopId,
  required int jobId,
  required UuidValue opId,
  required Uint8List bytes,
}) async {
  await session.storage.storeFile(
    storageId: 'private',
    path: 'shops/$shopId/jobs/$jobId/photos/${opId.uuid}.jpg',
    byteData: ByteData.sublistView(bytes),
  );
}

Matcher throwsFw(FwErrorCode code) => throwsA(
  isA<FwException>().having((e) => e.code, 'code', code),
);

String pretty(Object o) => const JsonEncoder.withIndent(' ').convert(o);
