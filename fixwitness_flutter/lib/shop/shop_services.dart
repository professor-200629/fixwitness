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

  /// Live changes pushed by the server (another device, or the customer on
  /// their link). Screens listen to this and reload what they show.
  Stream<JobChange> get liveChanges => _live.stream;
  final _live = StreamController<JobChange>.broadcast();
  StreamSubscription<JobChange>? _liveSub;
  Timer? _liveRetry;
  var _liveBackoff = const Duration(seconds: 2);
  bool _disposed = false;

  int get pendingCount => operations
      .where(
        (o) => o.status == OpStatus.pending || o.status == OpStatus.syncing,
      )
      .length;
  int get failedCount =>
      operations.where((o) => o.status == OpStatus.failed).length;

  void start() {
    if (_timer != null) return; // already running
    _sub = outbox.changes.listen((_) => _reloadOps());
    _reloadOps();
    _timer = Timer.periodic(const Duration(seconds: 15), (_) => syncNow());
    syncNow();
    _connectLive();
  }

  /// Keeps one `shop.watch()` stream open, reopening it with backoff after a
  /// drop (offline, server restart). Missing a message is harmless: screens
  /// also reload on open and on pull-to-refresh.
  void _connectLive() {
    if (_disposed) return;
    _liveRetry?.cancel();
    _liveSub?.cancel();
    _liveSub = client.shop.watch().listen(
      (change) {
        _liveBackoff = const Duration(seconds: 2);
        _setConnection(Connection.online);
        _live.add(change);
      },
      onError: (Object _) => _scheduleLiveReconnect(),
      onDone: _scheduleLiveReconnect,
      cancelOnError: true,
    );
  }

  /// Called when the app returns to the foreground. Android may have frozen
  /// or dropped the socket while the app was in the background, and changes
  /// sent in that time were missed, so open a fresh stream right away.
  void reconnectLive() {
    _liveBackoff = const Duration(seconds: 2);
    _connectLive();
  }

  void _scheduleLiveReconnect() {
    if (_disposed) return;
    _liveRetry?.cancel();
    _liveRetry = Timer(_liveBackoff, _connectLive);
    final next = _liveBackoff * 2;
    _liveBackoff = next > const Duration(minutes: 1)
        ? const Duration(minutes: 1)
        : next;
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
    if (c == Connection.online) {
      unawaited(outbox.syncOnce());
      // Back online: reopen the live stream now instead of waiting out the
      // backoff.
      if (_liveRetry?.isActive ?? false) _connectLive();
    }
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
    _disposed = true;
    _timer?.cancel();
    _sub?.cancel();
    _liveRetry?.cancel();
    _liveSub?.cancel();
    _live.close();
    super.dispose();
  }
}
