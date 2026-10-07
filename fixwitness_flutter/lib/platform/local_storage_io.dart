import 'dart:convert';
import 'dart:io';

import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../sync/file_photo_vault.dart';
import '../sync/job_cache.dart';
import '../sync/outbox_store.dart';
import 'local_storage.dart';

Future<LocalStorage> openLocalStorage(Client client) async {
  final dir = await getApplicationSupportDirectory();
  final session = await client.createSession(
    p.join(dir.path, 'fixwitness.db'),
    isDebugMode: kDebugMode,
  );
  return LocalStorage(
    outboxStore: SqliteOutboxStore(session),
    photoVault: FilePhotoVault(Directory(p.join(dir.path, 'pending_photos'))),
    jobCache: SqliteJobCache(session),
    prefs: _FileKeyValueStore(File(p.join(dir.path, 'prefs.json'))),
    durable: true,
  );
}

class _FileKeyValueStore implements KeyValueStore {
  _FileKeyValueStore(this.file);

  final File file;

  Future<Map<String, dynamic>> _load() async {
    if (!await file.exists()) return {};
    try {
      return jsonDecode(await file.readAsString()) as Map<String, dynamic>;
    } on FormatException {
      return {};
    }
  }

  @override
  Future<String?> read(String key) async => (await _load())[key] as String?;

  @override
  Future<void> write(String key, String? value) async {
    final map = await _load();
    value == null ? map.remove(key) : map[key] = value;
    final tmp = File('${file.path}.tmp');
    await tmp.writeAsString(jsonEncode(map), flush: true);
    await tmp.rename(file.path);
  }
}
