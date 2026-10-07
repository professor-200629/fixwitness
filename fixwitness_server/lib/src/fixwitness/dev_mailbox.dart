import 'dart:convert';
import 'dart:io';

import 'package:serverpod/serverpod.dart';

/// Development-only stand-in for an email provider. Verification codes are
/// appended to `.serverpod/development/dev_mailbox.jsonl` (gitignored) and
/// logged. Only wired up when the server runs in development mode.
class DevMailbox {
  final File file = File('.serverpod/development/dev_mailbox.jsonl');

  void _write(Session session, String kind, String email, String code) {
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(
      '${jsonEncode({'kind': kind, 'email': email, 'code': code, 'at': DateTime.now().toUtc().toIso8601String()})}\n',
      mode: FileMode.append,
      flush: true,
    );
    session.log('[dev mailbox] $kind code for $email: $code');
  }

  void registration(
    Session session, {
    required String email,
    required UuidValue accountRequestId,
    required String verificationCode,
    required Transaction? transaction,
  }) => _write(session, 'registration', email, verificationCode);

  void passwordReset(
    Session session, {
    required String email,
    required UuidValue passwordResetRequestId,
    required String verificationCode,
    required Transaction? transaction,
  }) => _write(session, 'passwordReset', email, verificationCode);
}

final devMailbox = DevMailbox();
