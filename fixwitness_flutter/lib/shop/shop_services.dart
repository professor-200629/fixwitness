import 'dart:async';
import 'dart:convert';

import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:flutter/foundation.dart';

import '../platform/local_storage.dart';
import '../sync/outbox.dart';
import '../sync/outbox_api.dart';

enum Connection { unknown, online, offline }

/// Everything the shop screens share: the API client, device storage, the
/// outbox and a background sync loop.
class ShopServices extends ChangeNotifier {
  ShopServices._(this.client, this.storage, this.outbox);

  static Future<ShopServices> create(Client client) async {
    final storage = await LocalStorage.open(client);
    final outbox = Outbox(
      store: storage.outboxStore,
      vault: storage.photoVault,
      api: ClientOutboxApi(client),
    );
    await outbox.recoverInterrupted();
    await outbox.pruneConfirmed();
    return ShopServices._(client, storage, outbox);
  }

  final Client client;
  final LocalStorage storage;
  final Outbox outbox;

  Connection connection = Connection.unknown;
  DateTime? lastSyncAt;
  List<PendingOperation> operations = const [];
  Timer? _timer;
  StreamSubscription<void>? _sub;

  int get pendingCount => operations
      .where(
        (o) => o.status == OpStatus.pending || o.status == OpStatus.syncing,
      )
      .length;
  int get failedCount =>
      operations.where((o) => o.status == OpStatus.failed).length;

  void start() {
    _sub = outbox.changes.listen((_) => _reloadOps());
    _reloadOps();
    _timer = Timer.periodic(const Duration(seconds: 15), (_) => syncNow());
    syncNow();
  }

  Future<void> _reloadOps() async {
    operations = await outbox.operations();
    notifyListeners();
  }

  /// Runs one sync pass; also used as the connectivity probe.
  Future<SyncReport> syncNow() async {
    final report = await outbox.syncOnce();
    if (operations.every((o) => o.status == OpStatus.confirmed) &&
        report.confirmed == 0 &&
        report.stillPending == 0) {
      // Nothing to send: probe the server cheaply so the banner is truthful.
      await _probe();
    } else {
      _setConnection(
        report.reachedServer ? Connection.online : Connection.offline,
      );
    }
    if (report.reachedServer) lastSyncAt = DateTime.now();
    await _reloadOps();
    return report;
  }

  Future<void> _probe() async {
    try {
      await client.shop.myShop().timeout(const Duration(seconds: 8));
      _setConnection(Connection.online);
    } catch (e) {
      if (classify(e) == FailureKind.transient) {
        _setConnection(Connection.offline);
      }
    }
  }

  /// Records the outcome of any server call made by a screen.
  void reportCall({required bool reached}) =>
      _setConnection(reached ? Connection.online : Connection.offline);

  void _setConnection(Connection c) {
    if (connection == c) return;
    connection = c;
    notifyListeners();
    if (c == Connection.online) unawaited(outbox.syncOnce());
  }

  Future<ShopContext?> cachedShop() async {
    final raw = await storage.prefs.read('shopContext');
    if (raw == null) return null;
    return ShopContext.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> rememberShop(ShopContext? ctx) => storage.prefs.write(
    'shopContext',
    ctx == null ? null : jsonEncode(ctx.toJson()),
  );

  @override
  void dispose() {
    _timer?.cancel();
    _sub?.cancel();
    super.dispose();
  }
}
