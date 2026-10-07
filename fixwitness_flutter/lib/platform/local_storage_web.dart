import 'package:fixwitness_client/fixwitness_client.dart';

import '../sync/job_cache.dart';
import '../sync/outbox_store.dart';
import 'local_storage.dart';

/// The shop app on the web keeps its queue in memory. Offline capture is an
/// Android feature; the web build is for the counter PC and the demo.
Future<LocalStorage> openLocalStorage(Client client) async => LocalStorage(
  outboxStore: MemoryOutboxStore(),
  photoVault: MemoryPhotoVault(),
  jobCache: MemoryJobCache(),
  prefs: MemoryKeyValueStore(),
  durable: false,
);
