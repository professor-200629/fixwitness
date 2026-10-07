import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

final _random = Random.secure();

/// 256 random bits, URL-safe, no padding.
String newLinkToken() {
  final bytes = List<int>.generate(32, (_) => _random.nextInt(256));
  return base64Url.encode(bytes).replaceAll('=', '');
}

String hashToken(String token) =>
    sha256.convert(utf8.encode(token)).toString();

/// Public URL of the customer review page for [token].
String customerUrl(Session session, String token) {
  final web = session.serverpod.config.webServer;
  final base = web == null
      ? 'http://localhost:8082'
      : Uri(
          scheme: web.publicScheme,
          host: web.publicHost,
          port: web.publicPort,
        ).toString();
  return '$base/#/r/$token';
}

/// Resolves a customer token to its link. Every customer call goes through
/// this, so a link only ever reaches its own job and stops working once
/// revoked or expired.
Future<CustomerLink> resolveLink(
  Session session,
  String token, {
  Transaction? transaction,
}) async {
  if (token.length < 20 || token.length > 100) throw _invalidLink();
  final link = await CustomerLink.db.findFirstRow(
    session,
    where: (t) => t.tokenHash.equals(hashToken(token)),
    transaction: transaction,
  );
  if (link == null) throw _invalidLink();
  if (link.revokedAt != null) {
    throw FwException(
      code: FwErrorCode.linkRevoked,
      message: 'The shop has withdrawn this link. Ask them for a new one.',
    );
  }
  if (link.expiresAt.isBefore(DateTime.now().toUtc())) {
    throw FwException(
      code: FwErrorCode.linkExpired,
      message: 'This link expired on ${link.expiresAt.toIso8601String().substring(0, 10)}. '
          'Ask the shop to send a new one.',
    );
  }
  return link;
}

FwException _invalidLink() => FwException(
  code: FwErrorCode.linkInvalid,
  message: 'This link is not valid. Check that you opened the full link the shop sent.',
);

/// Caller network details for the approval audit trail.
({String? ip, String? userAgent}) requestOrigin(Session session) {
  if (session is! MethodCallSession) return (ip: null, userAgent: null);
  final request = session.request;
  final forwarded = request.headers['x-forwarded-for']?.firstOrNull;
  final ip = forwarded?.split(',').first.trim() ??
      request.connectionInfo.remote.address.toString();
  final agent = request.headers.userAgent;
  return (
    ip: ip,
    userAgent: agent == null || agent.length <= 300 ? agent : agent.substring(0, 300),
  );
}
