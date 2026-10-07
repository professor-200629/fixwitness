import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'customer/customer_app.dart';
import 'shop/shop_app.dart';
import 'shop/shop_services.dart';

/// Customer links look like `https://<host>/#/r/<token>`. The token stays in
/// the URL fragment, which browsers never send to the server.
String? customerTokenFromUrl() {
  final fragment = Uri.base.fragment;
  final match = RegExp(r'^/r/([A-Za-z0-9_\-]{20,100})$').firstMatch(fragment);
  return match?.group(1);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final serverUrl = await getServerUrl();

  final token = customerTokenFromUrl();
  if (token != null) {
    // No auth session manager: customer calls never carry a shop sign-in.
    final client = Client(serverUrl)
      ..connectivityMonitor = FlutterConnectivityMonitor();
    runApp(CustomerApp(client: client, token: token));
    return;
  }

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
