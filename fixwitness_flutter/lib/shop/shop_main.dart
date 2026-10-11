import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'shop_app.dart';
import 'shop_services.dart';

/// Starts the shop app. Kept apart from `main.dart` so the web build can load
/// it as a deferred chunk: customers opening a review link never download the
/// shop screens, the sign-in UI or the offline database code.
Future<void> runShop(String serverUrl) async {
  final client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
  // Restores the saved sign-in. Offline this keeps the stored session.
  try {
    await client.auth.initialize().timeout(const Duration(seconds: 8));
  } catch (_) {
    // Offline at start-up: carry on with whatever session is stored.
  }
  final services = await ShopServices.create(client);
  runApp(ShopApp(services: services));
}
