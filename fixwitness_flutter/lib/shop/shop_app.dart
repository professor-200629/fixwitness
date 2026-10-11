import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../common/widgets.dart';
import '../sync/outbox.dart';
import 'jobs_screen.dart';
import 'shop_services.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({super.key, required this.services});

  final ShopServices services;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FixWitness',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      home: _AuthGate(services: services),
    );
  }
}

class _AuthGate extends StatefulWidget {
  const _AuthGate({required this.services});

  final ShopServices services;

  @override
  State<_AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<_AuthGate> {
  Client get client => widget.services.client;

  @override
  void initState() {
    super.initState();
    client.auth.authInfoListenable.addListener(_changed);
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_changed);
    super.dispose();
  }

  void _changed() => setState(() {});

  @override
  Widget build(BuildContext context) {
    if (client.auth.isAuthenticated) {
      return _ShopGate(services: widget.services);
    }
    final t = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.verified_user_outlined,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'FixWitness',
                    textAlign: TextAlign.center,
                    style: t.headlineMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Repair records your customers can trust.\nSign in with your shop account.',
                    textAlign: TextAlign.center,
                    style: t.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  SignInWidget(
                    client: client,
                    onAuthenticated: () {},
                    onError: (e) => showError(context, e),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Loads the user's shop (from the server, or the last known one offline) and
/// asks them to create one on first use.
class _ShopGate extends StatefulWidget {
  const _ShopGate({required this.services});

  final ShopServices services;

  @override
  State<_ShopGate> createState() => _ShopGateState();
}

class _ShopGateState extends State<_ShopGate> {
  ShopContext? _ctx;
  bool _loading = true;
  bool _needsShop = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final s = widget.services;
    try {
      final ctx = await s.client.shop.myShop();
      s.reportCall(reached: true);
      await s.rememberShop(ctx);
      setState(() {
        _ctx = ctx;
        _needsShop = ctx == null;
      });
    } catch (e) {
      final cached = await s.cachedShop();
      if (classify(e) == FailureKind.transient && cached != null) {
        s.reportCall(reached: false);
        setState(() => _ctx = cached);
      } else {
        setState(() => _error = e);
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
    if (_ctx != null) s.start();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_ctx != null) return JobsScreen(services: widget.services, shop: _ctx!);
    if (_needsShop) {
      return _CreateShopScreen(
        services: widget.services,
        onCreated: (ctx) async {
          await widget.services.rememberShop(ctx);
          setState(() => _ctx = ctx);
          widget.services.start();
        },
      );
    }
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off, size: 40),
              const SizedBox(height: 12),
              const Text(
                'Could not load your shop. The first sign-in on a device needs a connection.',
                textAlign: TextAlign.center,
              ),
              if (_error is FwException) Text((_error as FwException).message),
              const SizedBox(height: 12),
              FilledButton(onPressed: _load, child: const Text('Try again')),
              TextButton(
                onPressed: () => widget.services.client.auth.signOutDevice(),
                child: const Text('Sign out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateShopScreen extends StatefulWidget {
  const _CreateShopScreen({required this.services, required this.onCreated});

  final ShopServices services;
  final ValueChanged<ShopContext> onCreated;

  @override
  State<_CreateShopScreen> createState() => _CreateShopScreenState();
}

class _CreateShopScreenState extends State<_CreateShopScreen> {
  final _shop = TextEditingController();
  final _name = TextEditingController();
  final _code = TextEditingController();
  bool _busy = false;
  bool _joining = false;

  Future<void> _submit() async {
    setState(() => _busy = true);
    try {
      final shop = widget.services.client.shop;
      final ctx = _joining
          ? await shop.joinShop(_code.text, _name.text)
          : await shop.createShop(_shop.text, _name.text);
      widget.onCreated(ctx);
    } catch (e) {
      if (mounted) showError(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set up FixWitness')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(
                value: false,
                icon: Icon(Icons.storefront_outlined),
                label: Text('New shop'),
              ),
              ButtonSegment(
                value: true,
                icon: Icon(Icons.group_add_outlined),
                label: Text('Join with a code'),
              ),
            ],
            selected: {_joining},
            onSelectionChanged: (v) => setState(() => _joining = v.first),
          ),
          const SizedBox(height: 20),
          Text(
            _joining
                ? 'Enter the invite code the shop owner gave you.'
                : 'Your shop name appears on every estimate and customer link.',
          ),
          const SizedBox(height: 16),
          if (_joining)
            TextField(
              controller: _code,
              decoration: const InputDecoration(
                labelText: 'Invite code',
                hintText: 'ABCD-EFGH',
              ),
              textCapitalization: TextCapitalization.characters,
              textInputAction: TextInputAction.next,
            )
          else
            TextField(
              controller: _shop,
              decoration: const InputDecoration(labelText: 'Shop name'),
              textInputAction: TextInputAction.next,
            ),
          const SizedBox(height: 12),
          TextField(
            controller: _name,
            decoration: const InputDecoration(
              labelText: 'Your name (shown in history)',
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _busy ? null : _submit,
            child: Text(
              _busy
                  ? 'Please wait…'
                  : _joining
                  ? 'Join shop'
                  : 'Create shop',
            ),
          ),
        ],
      ),
    );
  }
}
