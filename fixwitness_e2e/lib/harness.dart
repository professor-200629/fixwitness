import 'dart:convert';
import 'dart:io';

import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    show
        AuthSuccess,
        ClientAuthSessionManager,
        ClientAuthSessionManagerExtension,
        ClientAuthSuccessStorage;

class MemoryAuthStorage implements ClientAuthSuccessStorage {
  AuthSuccess? _v;
  @override
  Future<AuthSuccess?> get() async => _v;
  @override
  Future<void> set(AuthSuccess? data) async => _v = data;
}

/// Talks to one FixWitness server.
class Harness {
  Harness({required this.apiUrl, required this.mailbox});

  final String apiUrl;

  /// The development server's dev mailbox (verification codes).
  final File mailbox;

  Client anonymousClient() =>
      Client(apiUrl, connectionTimeout: const Duration(seconds: 20));

  /// Signs in, registering the account first if it does not exist yet.
  /// Every call returns a client with its own independent session.
  Future<Client> signIn(String email, String password) async {
    final client = anonymousClient();
    final manager = ClientAuthSessionManager(storage: MemoryAuthStorage());
    client.authSessionManager = manager;
    AuthSuccess auth;
    try {
      auth = await client.emailIdp.login(email: email, password: password);
    } catch (_) {
      final since = DateTime.now().toUtc().subtract(const Duration(seconds: 2));
      final requestId = await client.emailIdp.startRegistration(email: email);
      final code = await _codeFor(email, since);
      final token = await client.emailIdp.verifyRegistrationCode(
        accountRequestId: requestId,
        verificationCode: code,
      );
      auth = await client.emailIdp.finishRegistration(
        registrationToken: token,
        password: password,
      );
    }
    await manager.updateSignedInUser(auth);
    return client;
  }

  Future<String> _codeFor(String email, DateTime since) async {
    for (var i = 0; i < 50; i++) {
      if (await mailbox.exists()) {
        for (final line in (await mailbox.readAsLines()).reversed) {
          final m = jsonDecode(line) as Map<String, dynamic>;
          if (m['email'] == email &&
              m['kind'] == 'registration' &&
              DateTime.parse(m['at'] as String).isAfter(since)) {
            return m['code'] as String;
          }
        }
      }
      await Future<void>.delayed(const Duration(milliseconds: 200));
    }
    throw StateError(
      'No verification code for $email in ${mailbox.path}. Is the server '
      'running in development mode from fixwitness_server?',
    );
  }
}

Future<ShopContext> ensureShop(Client c, String shop, String name) async =>
    await c.shop.myShop() ?? await c.shop.createShop(shop, name);

String tokenOf(CreatedLink l) => l.url.split('/r/').last;
