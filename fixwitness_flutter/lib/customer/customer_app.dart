import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:flutter/material.dart';

import '../common/format.dart';
import '../common/widgets.dart';

/// The customer's review page, opened from the link the shop sends. Uses a
/// client with no sign-in at all: the link token is the only credential and
/// it reaches exactly one job.
class CustomerApp extends StatelessWidget {
  const CustomerApp({super.key, required this.client, required this.token});

  final Client client;
  final String token;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your repair',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      // Keep `#/r/<token>` as the route name so the browser URL keeps the
      // token and a page refresh reopens the same repair.
      initialRoute: '/r/$token',
      onGenerateInitialRoutes: (_) => [_route()],
      onGenerateRoute: (_) => _route(),
    );
  }

  Route<void> _route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: '/r/$token'),
      builder: (_) => CustomerReviewPage(client: client, token: token),
    );
  }
}

class CustomerReviewPage extends StatefulWidget {
  const CustomerReviewPage({
    super.key,
    required this.client,
    required this.token,
  });

  final Client client;
  final String token;

  @override
  State<CustomerReviewPage> createState() => _CustomerReviewPageState();
}

class _CustomerReviewPageState extends State<CustomerReviewPage> {
  CustomerJobView? _view;
  Object? _error;
  bool _loading = true;
  String? _notice;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final v = await widget.client.customer.view(widget.token);
      setState(() {
        _view = v;
        _error = null;
      });
    } catch (e) {
      setState(() => _error = e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final v = _view;
    return Scaffold(
      body: SafeArea(
        child: _loading && v == null
            ? const Center(child: CircularProgressIndicator())
            : v == null
            ? _errorPage()
            : RefreshIndicator(
                onRefresh: _load,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 48),
                      children: [
                        _header(v),
                        if (_notice != null) ...[
                          const SizedBox(height: 12),
                          _noticeCard(_notice!),
                        ],
                        const SizedBox(height: 16),
                        _progress(v),
                        const SizedBox(height: 16),
                        AuthorizationBanner(v.authorization),
                        if (v.currentEstimate != null) _estimateSection(v),
                        if (v.canAcknowledgeCollection) _collectionSection(v),
                        _conditionSection(v),
                        if (v.notes.isNotEmpty) _updatesSection(v),
                        _historySection(v),
                        const SizedBox(height: 24),
                        Text(
                          'This page shows one repair only. Link valid until ${when(v.linkExpiresAt)}. '
                          'FixWitness never asks for your phone’s passcode.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _errorPage() {
    final e = _error;
    final (title, body) = switch (e) {
      FwException(code: FwErrorCode.linkExpired) => (
        'This link has expired',
        e.message,
      ),
      FwException(code: FwErrorCode.linkRevoked) => (
        'This link was withdrawn',
        e.message,
      ),
      FwException(code: FwErrorCode.linkInvalid) => (
        'Link not recognised',
        e.message,
      ),
      FwException() => ('Something is not right', e.message),
      _ => (
        'Could not reach the shop’s server',
        'Check your connection and try again.',
      ),
    };
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.link_off, size: 48),
            const SizedBox(height: 12),
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(body, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            if (e is! FwException)
              FilledButton(onPressed: _load, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }

  Widget _noticeCard(String text) {
    final c = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: c.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: c.onErrorContainer),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text, style: TextStyle(color: c.onErrorContainer)),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () => setState(() => _notice = null),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Widget _header(CustomerJobView v) {
    final t = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          v.shopName,
          style: t.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          v.deviceLabel,
          style: t.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text('Repair #${v.jobNumber} · ${v.customerName}'),
            const Spacer(),
            StatusChip(v.status),
          ],
        ),
        const SizedBox(height: 8),
        Text('You reported: ${v.reportedFault}', style: t.bodyMedium),
      ],
    );
  }

  Widget _progress(CustomerJobView v) {
    const steps = [
      'Checked in',
      'Estimate',
      'Approved',
      'Repairing',
      'Ready',
      'Collected',
    ];
    final index = switch (v.status) {
      JobStatus.checkedIn => 0,
      JobStatus.awaitingApproval => 1,
      JobStatus.declined => 1,
      JobStatus.approved => 2,
      JobStatus.inProgress => 3,
      JobStatus.completed => 4,
      JobStatus.collected => 5,
    };
    final c = Theme.of(context).colorScheme;
    return Row(
      children: [
        for (var i = 0; i < steps.length; i++)
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: i <= index ? c.primary : c.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  steps[i],
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: i == index
                        ? FontWeight.w700
                        : FontWeight.normal,
                    color: i <= index ? c.onSurface : c.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
      ],
    );
  }

  // ----------------------------------------------------------------- estimate

  Widget _estimateSection(CustomerJobView v) {
    final e = v.currentEstimate!;
    final previous = v.estimates
        .where((x) => x.versionNumber == e.versionNumber - 1)
        .firstOrNull;
    final older = v.estimates
        .where((x) => x.id != e.id)
        .toList()
        .reversed
        .toList();
    final decision = v.decisions.where((d) => d.estimateId == e.id).firstOrNull;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          'Estimate · version ${e.versionNumber}',
          trailing: Text(
            estimateStatusLabel(e.status),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Issued ${when(e.issuedAt)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (e.reasonForRevision != null) ...[
                  const SizedBox(height: 8),
                  _revisionBox(e, previous),
                ],
                const SizedBox(height: 8),
                EstimateTable(e),
                if (e.note != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(e.note!),
                  ),
                if (decision != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      '${decision.decision == DecisionKind.approved ? 'You approved' : 'You declined'} '
                      'this version as “${decision.typedName}” on ${when(decision.decidedAt)}.',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                if (v.canDecide) ...[
                  const Divider(height: 32),
                  _DecisionForm(
                    estimate: e,
                    customerName: v.customerName,
                    onApprove: (name) => _decide(e, name, approve: true),
                    onDecline: (name, reason) =>
                        _decide(e, name, approve: false, reason: reason),
                  ),
                ],
              ],
            ),
          ),
        ),
        if (older.isNotEmpty)
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: Text('Earlier versions (${older.length})'),
            children: [
              for (final o in older)
                Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Version ${o.versionNumber} · ${estimateStatusLabel(o.status)}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Issued ${when(o.issuedAt)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 6),
                        EstimateTable(o),
                      ],
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  /// Explains a revision: the shop's reason plus what was added, removed or
  /// repriced compared to the previous version.
  Widget _revisionBox(Estimate e, Estimate? previous) {
    final c = Theme.of(context).colorScheme;
    final changes = <String>[];
    if (previous != null) {
      final before = {for (final l in previous.lines) l.description: l};
      final after = {for (final l in e.lines) l.description: l};
      for (final l in e.lines) {
        final old = before[l.description];
        if (old == null) {
          changes.add(
            'Added: ${l.description} (${money(l.quantity * l.unitPriceMinor, e.currency)})',
          );
        } else if (old.quantity * old.unitPriceMinor !=
            l.quantity * l.unitPriceMinor) {
          changes.add(
            'Changed: ${l.description} '
            '${money(old.quantity * old.unitPriceMinor, e.currency)} → ${money(l.quantity * l.unitPriceMinor, e.currency)}',
          );
        }
      }
      for (final l in previous.lines) {
        if (!after.containsKey(l.description)) {
          changes.add('Removed: ${l.description}');
        }
      }
      final diff = e.totalMinor - previous.totalMinor;
      changes.add(
        'Total ${diff >= 0 ? 'up' : 'down'} by ${money(diff.abs(), e.currency)} '
        '(was ${money(previous.totalMinor, e.currency)})',
      );
    }
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: c.tertiaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Changed since version ${e.versionNumber - 1}',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: c.onTertiaryContainer,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Shop’s reason: ${e.reasonForRevision}',
            style: TextStyle(color: c.onTertiaryContainer),
          ),
          for (final ch in changes)
            Text('• $ch', style: TextStyle(color: c.onTertiaryContainer)),
        ],
      ),
    );
  }

  Future<void> _decide(
    Estimate e,
    String name, {
    required bool approve,
    String? reason,
  }) async {
    try {
      if (approve) {
        await widget.client.customer.approve(
          widget.token,
          e.id!,
          e.versionNumber,
          e.contentHash,
          name,
        );
      } else {
        await widget.client.customer.decline(
          widget.token,
          e.id!,
          e.versionNumber,
          e.contentHash,
          name,
          reason,
        );
      }
      setState(() => _notice = null);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              approve
                  ? 'Thank you. Your approval of version ${e.versionNumber} is recorded.'
                  : 'Your decision is recorded. The shop will contact you.',
            ),
          ),
        );
      }
    } on FwException catch (err) {
      // The server explains exactly why (e.g. a newer version was issued);
      // reload so the customer sees what is current now.
      setState(() => _notice = err.message);
    } catch (err) {
      setState(
        () => _notice =
            'Could not reach the shop’s server. Nothing was recorded. Try again.',
      );
    }
    await _load();
  }

  // --------------------------------------------------------------- collection

  Widget _collectionSection(CustomerJobView v) {
    final name = TextEditingController(text: v.customerName);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(
          v.status == JobStatus.completed
              ? 'Ready for collection'
              : 'Collect your device',
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'When you have your device back, confirm it here. Check it in the shop first.',
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: name,
                  decoration: const InputDecoration(labelText: 'Your name'),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: () async {
                    try {
                      await widget.client.customer.acknowledgeCollection(
                        widget.token,
                        name.text,
                      );
                    } on FwException catch (e) {
                      setState(() => _notice = e.message);
                    } catch (_) {
                      setState(
                        () => _notice =
                            'Could not reach the shop’s server. Try again.',
                      );
                    }
                    await _load();
                  },
                  icon: const Icon(Icons.handshake_outlined),
                  label: const Text('I have collected my device'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------- evidence

  Widget _conditionSection(CustomerJobView v) {
    final c = v.condition;
    final intakePhotos = v.photos;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Condition when you handed it in'),
        if (c == null)
          const Text('The shop has not recorded the condition yet.')
        else
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recorded ${when(c.capturedAt)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 6),
                  for (final i in c.items.where(
                    (i) => i.state != ConditionState.notApplicable,
                  ))
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              i.note == null
                                  ? i.label
                                  : '${i.label} — ${i.note}',
                            ),
                          ),
                          Text(
                            conditionLabel(i.state),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color:
                                  i.state == ConditionState.damaged ||
                                      i.state == ConditionState.notWorking
                                  ? Theme.of(context).colorScheme.error
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        if (intakePhotos.isNotEmpty) ...[
          const SectionTitle('Photos'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [for (final p in intakePhotos) _photo(p)],
          ),
        ],
      ],
    );
  }

  Widget _photo(CustomerPhoto p) {
    return GestureDetector(
      onTap: () => showDialog<void>(
        context: context,
        builder: (ctx) => Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Image.network(
                  p.url,
                  webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  '${stageLabel(p.stage)} · ${when(p.capturedAt)}${p.caption == null ? '' : '\n${p.caption}'}',
                ),
              ),
            ],
          ),
        ),
      ),
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 140,
                height: 140,
                child: Image.network(
                  p.url,
                  fit: BoxFit.cover,
                  webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                  errorBuilder: (_, _, _) =>
                      const Center(child: Icon(Icons.broken_image_outlined)),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              p.caption ?? stageLabel(p.stage),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _updatesSection(CustomerJobView v) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SectionTitle('Updates from the shop'),
      for (final n in v.notes.reversed)
        Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            title: Text(n.text),
            subtitle: Text('${n.authorName} · ${when(n.writtenAt)}'),
          ),
        ),
    ],
  );

  Widget _historySection(CustomerJobView v) {
    final events = v.history.reversed.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Full history'),
        for (var i = 0; i < events.length; i++)
          EventTile(events[i], last: i == events.length - 1),
      ],
    );
  }
}

class _DecisionForm extends StatefulWidget {
  const _DecisionForm({
    required this.estimate,
    required this.customerName,
    required this.onApprove,
    required this.onDecline,
  });

  final Estimate estimate;
  final String customerName;
  final Future<void> Function(String name) onApprove;
  final Future<void> Function(String name, String? reason) onDecline;

  @override
  State<_DecisionForm> createState() => _DecisionFormState();
}

class _DecisionFormState extends State<_DecisionForm> {
  late final _name = TextEditingController(text: widget.customerName);
  final _reason = TextEditingController();
  bool _agree = false;
  bool _busy = false;

  Future<void> _run(Future<void> Function() f) async {
    setState(() => _busy = true);
    try {
      await f();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final e = widget.estimate;
    final total = money(e.totalMinor, e.currency);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your decision', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          value: _agree,
          onChanged: (v) => setState(() => _agree = v ?? false),
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(
            'I approve estimate version ${e.versionNumber} for $total, exactly as shown above.',
          ),
        ),
        TextField(
          controller: _name,
          decoration: const InputDecoration(
            labelText: 'Type your full name to sign',
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: _busy || !_agree
                    ? null
                    : () => _run(() => widget.onApprove(_name.text)),
                child: Text('Approve $total'),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: _busy
                  ? null
                  : () async {
                      final ok = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Decline version ${e.versionNumber}?'),
                          content: TextField(
                            controller: _reason,
                            decoration: const InputDecoration(
                              labelText: 'Reason (optional)',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: const Text('Back'),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.pop(ctx, true),
                              child: const Text('Decline'),
                            ),
                          ],
                        ),
                      );
                      if (ok == true) {
                        await _run(
                          () => widget.onDecline(
                            _name.text,
                            _reason.text.trim().isEmpty
                                ? null
                                : _reason.text.trim(),
                          ),
                        );
                      }
                    },
              child: const Text('Decline'),
            ),
          ],
        ),
      ],
    );
  }
}
