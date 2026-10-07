import 'dart:typed_data';

import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:serverpod_database/serverpod_database.dart';

/// Durable storage for queued operations.
abstract class OutboxStore {
  Future<PendingOperation> insert(PendingOperation op);
  Future<PendingOperation> update(PendingOperation op);
  Future<List<PendingOperation>> all();
  Future<void> delete(PendingOperation op);
}

/// The production store: Serverpod's client-side SQLite database, so queued
/// work survives the app being killed or the phone restarting.
class SqliteOutboxStore implements OutboxStore {
  SqliteOutboxStore(this.session);

  final ClientDatabaseSession session;

  @override
  Future<PendingOperation> insert(PendingOperation op) =>
      PendingOperation.db.insertRow(session, op);

  @override
  Future<PendingOperation> update(PendingOperation op) =>
      PendingOperation.db.updateRow(session, op);

  @override
  Future<List<PendingOperation>> all() => PendingOperation.db.find(
    session,
    orderBy: (t) => t.createdAt,
  );

  @override
  Future<void> delete(PendingOperation op) async {
    await PendingOperation.db.deleteRow(session, op);
  }
}

/// Non-durable store for platforms without the SQLite setup (the shop app on
/// the web). The UI says that queued work there is lost on reload.
class MemoryOutboxStore implements OutboxStore {
  final _ops = <PendingOperation>[];
  var _nextId = 1;

  @override
  Future<PendingOperation> insert(PendingOperation op) async {
    final stored = op.copyWith(id: _nextId++);
    _ops.add(stored);
    return stored;
  }

  @override
  Future<PendingOperation> update(PendingOperation op) async {
    final i = _ops.indexWhere((o) => o.id == op.id);
    _ops[i] = op;
    return op;
  }

  @override
  Future<List<PendingOperation>> all() async =>
      [..._ops]..sort((a, b) => a.createdAt.compareTo(b.createdAt));

  @override
  Future<void> delete(PendingOperation op) async =>
      _ops.removeWhere((o) => o.id == op.id);
}

/// Keeps captured photo bytes on the device until the server confirms them.
abstract class PhotoVault {
  Future<String> save(UuidValue opId, Uint8List bytes);
  Future<Uint8List?> read(String path);
  Future<void> delete(String path);
}

class MemoryPhotoVault implements PhotoVault {
  final _files = <String, Uint8List>{};

  @override
  Future<String> save(UuidValue opId, Uint8List bytes) async {
    final path = 'memory://${opId.uuid}';
    _files[path] = bytes;
    return path;
  }

  @override
  Future<Uint8List?> read(String path) async => _files[path];

  @override
  Future<void> delete(String path) async => _files.remove(path);
}
