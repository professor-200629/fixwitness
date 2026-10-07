import 'dart:convert';

import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../common/format.dart';
import '../common/widgets.dart';
import '../sync/outbox.dart';
import 'job_screen.dart';
import 'new_job_screen.dart';
import 'shop_services.dart';
import 'sync_queue_screen.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key, required this.services, required this.shop});

  final ShopServices services;
  final ShopContext shop;

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> with WidgetsBindingObserver {
  List<JobSummary> _jobs = const [];
  bool _fromCache = false;
  bool _loading = true;

  ShopServices get s => widget.services;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    s.addListener(_servicesChanged);
    _refresh();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    s.removeListener(_servicesChanged);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      s.syncNow().then((_) => _refresh());
    }
  }

  int _lastConfirmed = 0;

  void _servicesChanged() {
    // Refresh the list when queued jobs reach the server.
    final confirmed = s.operations
        .where((o) => o.status == OpStatus.confirmed)
        .length;
    if (confirmed != _lastConfirmed) {
      _lastConfirmed = confirmed;
      _refresh();
    }
    setState(() {});
  }

  Future<void> _refresh() async {
    try {
      final jobs = await s.client.jobs.list();
      s.reportCall(reached: true);
      await s.storage.jobCache.putSummaries(jobs);
      if (mounted) {
        setState(() {
          _jobs = jobs;
          _fromCache = false;
        });
      }
    } catch (e) {
      if (classify(e) != FailureKind.transient) {
        if (mounted) showError(context, e);
      } else {
        s.reportCall(reached: false);
      }
      final cached = await s.storage.jobCache.summaries();
      if (mounted) {
        setState(() {
          _jobs = cached;
          _fromCache = true;
        });
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final queuedJobs = s.operations
        .where(
          (o) => o.kind == OpKind.createJob && o.status != OpStatus.confirmed,
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shop.shop.name),
        actions: [
          IconButton(
            tooltip: 'Sync queue',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SyncQueueScreen(services: s)),
            ),
            icon: Badge(
              isLabelVisible: s.pendingCount + s.failedCount > 0,
              label: Text('${s.pendingCount + s.failedCount}'),
              backgroundColor: s.failedCount > 0
                  ? Theme.of(context).colorScheme.error
                  : null,
              child: const Icon(Icons.cloud_sync_outlined),
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (v) async {
              if (v == 'signout') {
                await s.rememberShop(null);
                await s.client.auth.signOutDevice();
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                enabled: false,
                child: Text('Signed in as ${widget.shop.member.displayName}'),
              ),
              const PopupMenuItem(value: 'signout', child: Text('Sign out')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          SyncBanner(services: s, fromCache: _fromCache),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await s.syncNow();
                await _refresh();
              },
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 96),
                      children: [
                        for (final op in queuedJobs)
                          _QueuedJobCard(op: op, services: s),
                        for (final j in _jobs)
                          _JobCard(job: j, services: s, onChanged: _refresh),
                        if (_jobs.isEmpty && queuedJobs.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(32),
                            child: Text(
                              'No jobs yet. Tap “New job” when a device comes in.',
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NewJobScreen(services: s)),
          );
          await _refresh();
        },
        icon: const Icon(Icons.add),
        label: const Text('New job'),
      ),
    );
  }
}

/// One line telling the technician whether the server is reachable and what
/// is still waiting to be sent.
class SyncBanner extends StatelessWidget {
  const SyncBanner({super.key, required this.services, this.fromCache = false});

  final ShopServices services;
  final bool fromCache;

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    final s = services;
    final offline = s.connection == Connection.offline;
    final String text;
    final Color bg;
    final IconData icon;
    if (s.failedCount > 0) {
      text = '${s.failedCount} item(s) were not accepted. Tap to review.';
      bg = c.errorContainer;
      icon = Icons.error_outline;
    } else if (offline) {
      text = s.pendingCount > 0
          ? 'Offline. ${s.pendingCount} item(s) saved on this phone, will send when back online.'
          : 'Offline. Showing the last saved copy. New captures are kept on this phone.';
      bg = c.tertiaryContainer;
      icon = Icons.cloud_off_outlined;
    } else if (s.pendingCount > 0) {
      text = 'Sending ${s.pendingCount} item(s)…';
      bg = c.secondaryContainer;
      icon = Icons.cloud_upload_outlined;
    } else {
      return const SizedBox.shrink();
    }
    return Material(
      color: bg,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SyncQueueScreen(services: s)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: 10),
              Expanded(child: Text(text)),
              if (!s.storage.durable && s.pendingCount > 0)
                const Tooltip(
                  message:
                      'In the browser, queued items are lost if the page reloads. Use the Android app for offline work.',
                  child: Icon(Icons.info_outline, size: 18),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  const _JobCard({
    required this.job,
    required this.services,
    required this.onChanged,
  });

  final JobSummary job;
  final ShopServices services;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final pending = services.operations
        .where((o) => o.serverJobId == job.id && o.status != OpStatus.confirmed)
        .length;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),
          title: Text('#${job.jobNumber} · ${job.deviceLabel}'),
          subtitle: Text(
            '${job.customerName} · updated ${when(job.updatedAt)}'
            '${pending > 0 ? '\n$pending item(s) not yet sent' : ''}',
          ),
          trailing: StatusChip(job.status),
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    JobScreen(services: services, serverJobId: job.id),
              ),
            );
            onChanged();
          },
        ),
      ),
    );
  }
}

class _QueuedJobCard extends StatelessWidget {
  const _QueuedJobCard({required this.op, required this.services});

  final PendingOperation op;
  final ShopServices services;

  @override
  Widget build(BuildContext context) {
    final input = NewJobInput.fromJson(
      jsonDecode(op.payloadJson) as Map<String, dynamic>,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),
          title: Text('New · ${input.deviceMake} ${input.deviceModel}'),
          subtitle: Text(
            '${input.customerName} · captured ${when(op.createdAt)}'
            '${op.lastError == null ? '' : '\n${op.lastError}'}',
          ),
          trailing: OpStatusBadge(op.status),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => JobScreen(services: services, jobOpId: op.opId),
            ),
          ),
        ),
      ),
    );
  }
}
