import 'dart:convert';

import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:flutter/material.dart';

import '../common/format.dart';
import '../common/widgets.dart';
import 'shop_services.dart';

/// Everything captured on this phone and where it stands: waiting, sending,
/// not accepted (with the server's reason), or saved on the server.
class SyncQueueScreen extends StatefulWidget {
  const SyncQueueScreen({super.key, required this.services});

  final ShopServices services;

  @override
  State<SyncQueueScreen> createState() => _SyncQueueScreenState();
}

class _SyncQueueScreenState extends State<SyncQueueScreen> {
  bool _syncing = false;

  @override
  void initState() {
    super.initState();
    widget.services.addListener(_changed);
  }

  @override
  void dispose() {
    widget.services.removeListener(_changed);
    super.dispose();
  }

  void _changed() => setState(() {});

  Future<void> _sync() async {
    setState(() => _syncing = true);
    final r = await widget.services.syncNow();
    if (!mounted) return;
    setState(() => _syncing = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          r.reachedServer
              ? 'Sent ${r.confirmed}. ${r.failed > 0 ? '${r.failed} not accepted. ' : ''}${r.stillPending > 0 ? '${r.stillPending} waiting.' : ''}'
              : 'No connection. Everything stays saved on this phone.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.services;
    final ops = s.operations.reversed.toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Sync queue')),
      body: ops.isEmpty
          ? const Center(child: Text('Nothing captured on this phone yet.'))
          : ListView(
              padding: const EdgeInsets.all(12),
              children: [
                Text(
                  s.storage.durable
                      ? 'Saved on this phone until the server confirms. Survives closing the app.'
                      : 'Browser session: queued items are lost if this page reloads.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                for (final op in ops) _tile(op),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _syncing ? null : _sync,
        icon: const Icon(Icons.sync),
        label: Text(_syncing ? 'Sending…' : 'Send now'),
      ),
    );
  }

  Widget _tile(PendingOperation op) {
    final s = widget.services;
    final payload = jsonDecode(op.payloadJson) as Map<String, dynamic>;
    final title = switch (op.kind) {
      OpKind.createJob =>
        'New job · ${payload['deviceMake']} ${payload['deviceModel']} (${payload['customerName']})',
      OpKind.addNote => 'Note · ${payload['text']}',
      OpKind.saveCondition => 'Condition checklist',
      OpKind.addPhoto =>
        'Photo · ${stageLabel(PhotoStage.values.byName(payload['stage'] as String))}'
            '${op.uploadDone && op.status != OpStatus.confirmed ? ' · bytes uploaded, finishing' : ''}',
    };
    final job = op.serverJobId != null
        ? 'Job id ${op.serverJobId}'
        : op.kind == OpKind.createJob
        ? ''
        : 'Waiting for its job to be created';
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                OpStatusBadge(op.status),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Captured ${when(op.createdAt)}${job.isEmpty ? '' : ' · $job'} · attempts ${op.attempts}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (op.lastError != null && op.status != OpStatus.confirmed)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  op.lastError!,
                  style: TextStyle(
                    color: op.status == OpStatus.failed
                        ? Theme.of(context).colorScheme.error
                        : null,
                  ),
                ),
              ),
            if (op.status == OpStatus.failed)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      final ok = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Discard this item?'),
                          content: const Text(
                            'It will be removed from this phone and never sent.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: const Text('Keep'),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.pop(ctx, true),
                              child: const Text('Discard'),
                            ),
                          ],
                        ),
                      );
                      if (ok == true) await s.outbox.discard(op);
                    },
                    child: const Text('Discard'),
                  ),
                  FilledButton.tonal(
                    onPressed: () async {
                      await s.outbox.retry(op);
                      await s.syncNow();
                    },
                    child: const Text('Try again'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
