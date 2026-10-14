import 'dart:async';
import 'dart:convert';
import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../common/format.dart';
import '../common/widgets.dart';
import '../sync/outbox.dart';
import 'capture.dart';
import 'estimate_editor.dart';
import 'shop_services.dart';

/// One job. Opens either a job on the server ([serverJobId]) or a job that is
/// still queued on this phone ([jobOpId]); evidence can be captured for both.
class JobScreen extends StatefulWidget {
  const JobScreen({
    super.key,
    required this.services,
    this.serverJobId,
    this.jobOpId,
  }) : assert(serverJobId != null || jobOpId != null);

  final ShopServices services;
  final int? serverJobId;
  final UuidValue? jobOpId;

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> with WidgetsBindingObserver {
  int? _jobId;
  JobDetail? _detail;
  bool _fromCache = false;
  bool _loading = true;
  bool _busy = false;
  final _photoUrls = <int, Future<String>>{};

  ShopServices get s => widget.services;
  bool get _online => s.connection != Connection.offline;

  @override
  void initState() {
    super.initState();
    _jobId = widget.serverJobId;
    // Operations confirmed before this screen opened are already in the data.
    _seenConfirmed.addAll(
      s.operations
          .where((o) => o.status == OpStatus.confirmed)
          .map((o) => o.opId.uuid),
    );
    WidgetsBinding.instance.addObserver(this);
    s.addListener(_servicesChanged);
    _liveSub = s.liveChanges.listen((change) {
      if (change.jobId != _jobId || !mounted) return;
      _load();
      if (change.fromCustomer) showLiveChange(context, change);
    });
    _load();
  }

  StreamSubscription<JobChange>? _liveSub;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    s.removeListener(_servicesChanged);
    _liveSub?.cancel();
    super.dispose();
  }

  /// Changes made while the app was in the background (a customer approving
  /// from their phone) are shown as soon as the shop comes back to it.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted) _load();
  }

  /// Ids of this job's queued operations already confirmed by the server.
  final _seenConfirmed = <String>{};

  void _servicesChanged() {
    if (_jobId == null && widget.jobOpId != null) {
      final op = s.operations
          .where((o) => o.opId == widget.jobOpId)
          .firstOrNull;
      if (op?.status == OpStatus.confirmed && op?.resultId != null) {
        _jobId = op!.resultId;
        _load();
      }
    }
    // When queued evidence for this job reaches the server, show the server's
    // copy (it disappears from "On this phone" at the same moment).
    final newlyConfirmed = s.operations
        .where(
          (o) =>
              o.status == OpStatus.confirmed &&
              o.kind != OpKind.createJob &&
              _jobId != null &&
              o.serverJobId == _jobId &&
              _seenConfirmed.add(o.opId.uuid),
        )
        .toList();
    if (newlyConfirmed.isNotEmpty) _load();
    if (mounted) setState(() {});
  }

  Future<void> _load() async {
    if (_jobId == null) {
      setState(() => _loading = false);
      return;
    }
    try {
      final d = await s.client.jobs.get(_jobId!);
      s.reportCall(reached: true);
      await s.storage.jobCache.putDetail(d);
      if (mounted) {
        setState(() {
          _detail = d;
          _fromCache = false;
        });
      }
    } catch (e) {
      if (classify(e) == FailureKind.transient) {
        s.reportCall(reached: false);
        final cached = await s.storage.jobCache.detail(_jobId!);
        if (mounted) {
          setState(() {
            _detail = cached;
            _fromCache = true;
          });
        }
      } else if (mounted) {
        showError(context, e);
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  List<PendingOperation> get _localOps => s.operations
      .where(
        (o) =>
            o.kind != OpKind.createJob &&
            o.status != OpStatus.confirmed &&
            ((_jobId != null && o.serverJobId == _jobId) ||
                (widget.jobOpId != null && o.parentOpId == widget.jobOpId)),
      )
      .toList();

  /// Runs a call that must reach the server now (estimates, transitions).
  Future<void> _online1(Future<void> Function() call) async {
    setState(() => _busy = true);
    try {
      await call();
      s.reportCall(reached: true);
      await _load();
    } on FwException catch (e) {
      if (mounted) showError(context, e);
      await _load();
    } catch (e) {
      if (classify(e) == FailureKind.transient) s.reportCall(reached: false);
      if (mounted) showError(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final queuedInput = _queuedInput();
    final title = _detail != null
        ? '#${_detail!.job.jobNumber} · ${_detail!.job.deviceMake} ${_detail!.job.deviceModel}'
        : queuedInput != null
        ? '${queuedInput.deviceMake} ${queuedInput.deviceModel}'
        : 'Job';
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            IconButton(
              onPressed: _load,
              icon: const Icon(Icons.refresh),
              tooltip: 'Reload',
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Evidence'),
              Tab(text: 'Estimates'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  if (_fromCache)
                    MaterialBanner(
                      content: Text(
                        'Offline: showing the copy saved on this phone. '
                        'Estimates and status changes need a connection.',
                      ),
                      leading: const Icon(Icons.cloud_off_outlined),
                      actions: [
                        TextButton(
                          onPressed: _load,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  if (_busy) const LinearProgressIndicator(),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _overview(queuedInput),
                        _evidence(),
                        _estimates(),
                        _history(),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  NewJobInput? _queuedInput() {
    if (widget.jobOpId == null) return null;
    final op = s.operations.where((o) => o.opId == widget.jobOpId).firstOrNull;
    if (op == null) return null;
    return NewJobInput.fromJson(
      jsonDecode(op.payloadJson) as Map<String, dynamic>,
    );
  }

  // ---------------------------------------------------------------- overview

  Widget _overview(NewJobInput? queued) {
    final d = _detail;
    if (d == null) {
      final op = s.operations
          .where((o) => o.opId == widget.jobOpId)
          .firstOrNull;
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (op != null) OpStatusBadge(op.status),
                  const SizedBox(height: 8),
                  if (queued != null) ...[
                    Text(
                      queued.customerName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(queued.customerPhone),
                    const SizedBox(height: 8),
                    Text('Fault: ${queued.reportedFault}'),
                  ],
                  if (op?.lastError != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      op!.lastError!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'This job is saved on the phone and will be created on the server '
            'when there is a connection. You can already record its condition, '
            'photos and notes in the Evidence tab. Estimates are issued once '
            'the job is on the server.',
          ),
        ],
      );
    }
    final job = d.job;
    final c = Theme.of(context).colorScheme;
    final current = d.estimates
        .where((e) => e.id == job.currentEstimateId)
        .firstOrNull;
    final pendingEstimate = current?.status == EstimateStatus.issued;
    final canEstimate = {
      JobStatus.checkedIn,
      JobStatus.awaitingApproval,
      JobStatus.approved,
      JobStatus.inProgress,
      JobStatus.declined,
    }.contains(job.status);
    final authorized = job.authorizedEstimateId != null && !pendingEstimate;
    final enabled = _online && !_busy && !_fromCache;

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              StatusChip(job.status),
              const Spacer(),
              Text(
                'v${job.rowVersion}',
                style: TextStyle(color: c.outline, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AuthorizationBanner(d.authorization),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.customerName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(job.customerPhone),
                  const Divider(height: 24),
                  _kv('Device', '${job.deviceMake} ${job.deviceModel}'),
                  if (job.deviceSerial != null)
                    _kv('IMEI / serial', job.deviceSerial!),
                  _kv('Reported fault', job.reportedFault),
                  if (job.accessories != null)
                    _kv('Accessories', job.accessories!),
                  _kv('Checked in', when(job.createdAt)),
                ],
              ),
            ),
          ),
          const SectionTitle('Actions'),
          if (!_online || _fromCache)
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text('These need a connection to the server.'),
            ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (canEstimate)
                FilledButton.icon(
                  onPressed: enabled ? () => _openEstimateEditor(d) : null,
                  icon: const Icon(Icons.request_quote_outlined),
                  label: Text(
                    current == null
                        ? 'Issue estimate'
                        : 'Issue revised estimate',
                  ),
                ),
              if (job.status != JobStatus.collected)
                OutlinedButton.icon(
                  onPressed: enabled ? () => _shareLink(d) : null,
                  icon: const Icon(Icons.link),
                  label: const Text('Customer link'),
                ),
              if ((job.status == JobStatus.approved ||
                      job.status == JobStatus.declined) &&
                  authorized)
                OutlinedButton.icon(
                  onPressed: enabled
                      ? () => _online1(() => s.client.jobs.startWork(job.id!))
                      : null,
                  icon: const Icon(Icons.build_outlined),
                  label: const Text('Start repair'),
                ),
              if ({
                    JobStatus.approved,
                    JobStatus.inProgress,
                    JobStatus.declined,
                  }.contains(job.status) &&
                  authorized)
                OutlinedButton.icon(
                  onPressed: enabled ? () => _confirmComplete(d) : null,
                  icon: const Icon(Icons.task_alt),
                  label: const Text('Repair complete'),
                ),
              if (job.status == JobStatus.completed ||
                  job.status == JobStatus.declined)
                OutlinedButton.icon(
                  onPressed: enabled ? () => _recordCollection(job) : null,
                  icon: const Icon(Icons.handshake_outlined),
                  label: const Text('Record handover'),
                ),
            ],
          ),
          if (pendingEstimate && job.authorizedEstimateId != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'Repair can continue only within the approved estimate until the '
                'customer approves v${current!.versionNumber}.',
                style: TextStyle(color: c.error),
              ),
            ),
        ],
      ),
    );
  }

  Widget _kv(String k, String v) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            k,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(child: Text(v)),
      ],
    ),
  );

  Future<void> _openEstimateEditor(JobDetail d) async {
    final current = d.estimates
        .where((e) => e.id == d.job.currentEstimateId)
        .firstOrNull;
    final issued = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => EstimateEditor(
          services: s,
          jobId: d.job.id!,
          currency: d.shopCurrency,
          previous: current,
        ),
      ),
    );
    if (issued == true) await _load();
  }

  Future<void> _confirmComplete(JobDetail d) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Mark repair complete?'),
        content: Text(
          '${d.authorization.label}\n\nThe customer will see the device as ready for collection.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Complete'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await _online1(() => s.client.jobs.completeRepair(d.job.id!));
    }
  }

  Future<void> _recordCollection(RepairJob job) async {
    final name = TextEditingController(text: job.customerName);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Record handover at the counter'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Prefer asking the customer to confirm on their link. A handover '
              'recorded here is marked in the history as recorded by shop staff.',
            ),
            const SizedBox(height: 12),
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: 'Collected by'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Record'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await _online1(() => s.client.jobs.recordCollection(job.id!, name.text));
    }
  }

  Future<void> _shareLink(JobDetail d) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) => _LinkSheet(services: s, detail: d, onChanged: _load),
    );
  }

  // ---------------------------------------------------------------- evidence

  Widget _evidence() {
    final d = _detail;
    final local = _localOps;
    final latestCondition = d?.conditionReports.lastOrNull;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilledButton.tonalIcon(
              onPressed: () => capturePhoto(
                context,
                s,
                serverJobId: _jobId,
                jobOpId: widget.jobOpId,
              ),
              icon: const Icon(Icons.photo_camera_outlined),
              label: const Text('Photo'),
            ),
            FilledButton.tonalIcon(
              onPressed: () => openChecklist(
                context,
                s,
                serverJobId: _jobId,
                jobOpId: widget.jobOpId,
                previous: latestCondition,
              ),
              icon: const Icon(Icons.checklist),
              label: const Text('Condition'),
            ),
            FilledButton.tonalIcon(
              onPressed: () => addNote(
                context,
                s,
                serverJobId: _jobId,
                jobOpId: widget.jobOpId,
              ),
              icon: const Icon(Icons.note_add_outlined),
              label: const Text('Note'),
            ),
          ],
        ),
        if (local.isNotEmpty) ...[
          const SectionTitle('On this phone'),
          for (final op in local) _localOpTile(op),
        ],
        const SectionTitle('Condition'),
        if (latestCondition == null)
          const Text('No condition checklist recorded yet.')
        else
          _conditionCard(latestCondition, d!.conditionReports.length),
        const SectionTitle('Photos'),
        if (d == null || d.photos.isEmpty)
          const Text('No photos on the server yet.')
        else
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            children: [for (final p in d.photos) _serverPhoto(p)],
          ),
        const SectionTitle('Notes'),
        if (d == null || d.notes.isEmpty)
          const Text('No notes yet.')
        else
          for (final n in d.notes.reversed)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                n.customerVisible
                    ? Icons.visibility_outlined
                    : Icons.lock_outline,
              ),
              title: Text(n.text),
              subtitle: Text(
                '${n.authorName} · ${when(n.writtenAt)}'
                '${n.customerVisible ? ' · shown to customer' : ' · internal'}',
              ),
            ),
      ],
    );
  }

  Widget _conditionCard(ConditionReport r, int count) => Card(
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recorded by ${r.recordedByName} · ${when(r.capturedAt)}'
            '${count > 1 ? ' · $count checks on record' : ''}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          for (final i in r.items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Expanded(child: Text(i.label)),
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
  );

  Widget _serverPhoto(EvidencePhoto p) {
    final url = _photoUrls.putIfAbsent(
      p.id!,
      () => s.client.evidence.photoUrl(p.id!),
    );
    return FutureBuilder<String>(
      future: url,
      builder: (context, snap) => ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (snap.hasData)
              Image.network(
                snap.data!,
                fit: BoxFit.cover,
                webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
                errorBuilder: (_, _, _) =>
                    const Center(child: Icon(Icons.broken_image_outlined)),
              )
            else
              const Center(child: Icon(Icons.image_outlined)),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.all(4),
                child: Text(
                  stageLabel(p.stage),
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _localOpTile(PendingOperation op) {
    final payload = jsonDecode(op.payloadJson) as Map<String, dynamic>;
    final (icon, title) = switch (op.kind) {
      OpKind.addPhoto => (
        Icons.photo_outlined,
        '${stageLabel(PhotoStage.values.byName(payload['stage'] as String))} photo'
            '${payload['caption'] == null ? '' : ' · ${payload['caption']}'}'
            '${op.uploadDone ? ' (uploaded, finishing)' : ''}',
      ),
      OpKind.addNote => (Icons.note_outlined, payload['text'] as String),
      OpKind.saveCondition => (Icons.checklist, 'Condition checklist'),
      OpKind.createJob => (Icons.work_outline, 'New job'),
    };
    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        leading: op.kind == OpKind.addPhoto && op.localFilePath != null
            ? _LocalThumb(services: s, path: op.localFilePath!)
            : Icon(icon),
        title: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OpStatusBadge(op.status),
            if (op.lastError != null)
              Text(op.lastError!, style: const TextStyle(fontSize: 12)),
          ],
        ),
        trailing: op.status == OpStatus.failed
            ? IconButton(
                tooltip: 'Try again',
                onPressed: () async {
                  await s.outbox.retry(op);
                  await s.syncNow();
                },
                icon: const Icon(Icons.refresh),
              )
            : null,
      ),
    );
  }

  // --------------------------------------------------------------- estimates

  Widget _estimates() {
    final d = _detail;
    if (d == null || d.estimates.isEmpty) {
      return const Center(child: Text('No estimate issued yet.'));
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AuthorizationBanner(d.authorization),
        for (final e in d.estimates.reversed) ...[
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Version ${e.versionNumber}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      Text(
                        estimateStatusLabel(e.status),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: _estimateColor(e.status),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Issued ${when(e.issuedAt)} by ${e.issuedByName}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (e.reasonForRevision != null) ...[
                    const SizedBox(height: 8),
                    Text('Why it changed: ${e.reasonForRevision}'),
                  ],
                  const SizedBox(height: 8),
                  EstimateTable(e),
                  if (e.note != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(e.note!),
                    ),
                  for (final dec in d.decisions.where(
                    (x) => x.estimateId == e.id,
                  ))
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        '${dec.decision == DecisionKind.approved ? 'Approved' : 'Declined'} by '
                        '“${dec.typedName}” on the customer link, ${when(dec.decidedAt)}'
                        '${dec.declineReason == null ? '' : ' — ${dec.declineReason}'}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Color? _estimateColor(EstimateStatus s) {
    final c = Theme.of(context).colorScheme;
    return switch (s) {
      EstimateStatus.approved => c.primary,
      EstimateStatus.declined => c.error,
      EstimateStatus.issued => c.tertiary,
      EstimateStatus.superseded => c.outline,
    };
  }

  // ----------------------------------------------------------------- history

  Widget _history() {
    final d = _detail;
    if (d == null) {
      return const Center(
        child: Text('History appears once the job is on the server.'),
      );
    }
    final events = d.events.reversed.toList();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (var i = 0; i < events.length; i++)
          EventTile(events[i], last: i == events.length - 1),
      ],
    );
  }
}

class _LocalThumb extends StatelessWidget {
  const _LocalThumb({required this.services, required this.path});

  final ShopServices services;
  final String path;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: services.storage.photoVault.read(path),
      builder: (context, snap) => SizedBox(
        width: 48,
        height: 48,
        child: snap.data == null
            ? const Icon(Icons.photo_outlined)
            : ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.memory(snap.data!, fit: BoxFit.cover),
              ),
      ),
    );
  }
}

class _LinkSheet extends StatefulWidget {
  const _LinkSheet({
    required this.services,
    required this.detail,
    required this.onChanged,
  });

  final ShopServices services;
  final JobDetail detail;
  final Future<void> Function() onChanged;

  @override
  State<_LinkSheet> createState() => _LinkSheetState();
}

class _LinkSheetState extends State<_LinkSheet> {
  String? _url;
  bool _busy = false;
  late List<CustomerLink> _links = widget.detail.links;

  Future<void> _create() async {
    setState(() => _busy = true);
    try {
      final created = await widget.services.client.links.create(
        widget.detail.job.id!,
        7,
      );
      setState(() {
        _url = created.url;
        _links = [..._links, created.link];
      });
      await widget.onChanged();
    } catch (e) {
      if (mounted) showError(context, e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _revoke(CustomerLink l) async {
    try {
      final r = await widget.services.client.links.revoke(l.id!);
      setState(() => _links = [for (final x in _links) x.id == r.id ? r : x]);
      await widget.onChanged();
    } catch (e) {
      if (mounted) showError(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().toUtc();
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        0,
        20,
        20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer review link',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'The customer uses this link to see the condition record and photos, '
              'approve or decline the exact estimate, and confirm collection. It '
              'opens only this job. Anyone with the link can use it, so send it '
              'only to the customer.',
            ),
            const SizedBox(height: 12),
            if (_url != null) ...[
              // At the counter the customer scans this with their phone camera;
              // remotely, Share sends it through any messaging app.
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: QrImageView(
                    data: _url!,
                    size: 220,
                    backgroundColor: Colors.white,
                    errorCorrectionLevel: QrErrorCorrectLevel.M,
                    semanticsLabel: 'QR code of the customer link',
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ask the customer to scan this with their phone camera.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: () => SharePlus.instance.share(
                        ShareParams(
                          text:
                              'Your ${widget.detail.job.deviceMake} '
                              '${widget.detail.job.deviceModel} repair: see the '
                              'condition record and approve the estimate here: '
                              '$_url',
                          subject: 'Your repair record',
                        ),
                      ),
                      icon: const Icon(Icons.share_outlined),
                      label: const Text('Share'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: _url!));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Link copied.')),
                        );
                      },
                      icon: const Icon(Icons.copy),
                      label: const Text('Copy'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'This is the only time the full link is shown.',
                style: TextStyle(fontSize: 12),
              ),
            ] else
              FilledButton.icon(
                onPressed: _busy ? null : _create,
                icon: const Icon(Icons.add_link),
                label: const Text('Create link (valid 7 days)'),
              ),
            if (_links.isNotEmpty) ...[
              const SectionTitle('Links for this job'),
              for (final l in _links.reversed)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Created ${when(l.createdAt)}'),
                  subtitle: Text(
                    l.revokedAt != null
                        ? 'Revoked ${when(l.revokedAt!)}'
                        : l.expiresAt.isBefore(now)
                        ? 'Expired ${when(l.expiresAt)}'
                        : 'Active until ${when(l.expiresAt)}'
                              '${l.lastOpenedAt == null ? ' · not opened yet' : ' · opened ${when(l.lastOpenedAt!)}'}',
                  ),
                  trailing: l.revokedAt == null && l.expiresAt.isAfter(now)
                      ? TextButton(
                          onPressed: () => _revoke(l),
                          child: const Text('Revoke'),
                        )
                      : null,
                ),
            ],
          ],
        ),
      ),
    );
  }
}
