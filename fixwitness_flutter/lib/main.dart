import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'customer/customer_app.dart';
import 'shop/shop_main.dart' deferred as shop;

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

  // The shop app is a separate chunk on the web; on Android this is a no-op.
  await shop.loadLibrary();
  await shop.runShop(serverUrl);
}
