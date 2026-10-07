import 'package:fixwitness_client/fixwitness_client.dart';

import '../sync/job_cache.dart';
import '../sync/outbox_store.dart';
import 'local_storage_web.dart'
    if (dart.library.io) 'local_storage_io.dart'
    as impl;

/// Device storage for the shop app.
class LocalStorage {
  LocalStorage({
    required this.outboxStore,
    required this.photoVault,
    required this.jobCache,
    required this.prefs,
    required this.durable,
  });

  final OutboxStore outboxStore;
  final PhotoVault photoVault;
  final JobCache jobCache;
  final KeyValueStore prefs;

  /// False on the web build, where queued work does not survive a reload.
  final bool durable;

  static Future<LocalStorage> open(Client client) =>
      impl.openLocalStorage(client);
}

abstract class KeyValueStore {
  Future<String?> read(String key);
  Future<void> write(String key, String? value);
}

class MemoryKeyValueStore implements KeyValueStore {
  final _values = <String, String>{};

  @override
  Future<String?> read(String key) async => _values[key];

  @override
  Future<void> write(String key, String? value) async =>
      value == null ? _values.remove(key) : _values[key] = value;
}
