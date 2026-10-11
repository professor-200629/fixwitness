import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:flutter/material.dart';

import 'format.dart';

ThemeData buildTheme(Brightness brightness) {
  final scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF0F6E6E),
    brightness: brightness,
  );
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    visualDensity: VisualDensity.standard,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      margin: EdgeInsets.zero,
    ),
  );
}

/// Colour pair for a job status, used consistently in both apps.
(Color, Color) statusColors(BuildContext context, JobStatus s) {
  final c = Theme.of(context).colorScheme;
  return switch (s) {
    JobStatus.awaitingApproval => (c.tertiaryContainer, c.onTertiaryContainer),
    JobStatus.declined => (c.errorContainer, c.onErrorContainer),
    JobStatus.completed => (c.primaryContainer, c.onPrimaryContainer),
    JobStatus.collected => (c.surfaceContainerHighest, c.onSurfaceVariant),
    _ => (c.secondaryContainer, c.onSecondaryContainer),
  };
}

class StatusChip extends StatelessWidget {
  const StatusChip(this.status, {super.key});

  final JobStatus status;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = statusColors(context, status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statusLabel(status),
        style: TextStyle(color: fg, fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }
}

/// Shows the server's statement of what work is authorized. Highlighted when
/// a revision is waiting, so unapproved work never looks approved.
class AuthorizationBanner extends StatelessWidget {
  const AuthorizationBanner(this.state, {super.key});

  final AuthorizationState state;

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    final warn = state.pendingApproval || state.authorizedVersion == null;
    final bg = state.revisionPending
        ? c.errorContainer
        : warn
        ? c.tertiaryContainer
        : c.primaryContainer;
    final fg = state.revisionPending
        ? c.onErrorContainer
        : warn
        ? c.onTertiaryContainer
        : c.onPrimaryContainer;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            warn ? Icons.pending_actions_outlined : Icons.verified_outlined,
            color: fg,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(state.label, style: TextStyle(color: fg)),
          ),
        ],
      ),
    );
  }
}

class OpStatusBadge extends StatelessWidget {
  const OpStatusBadge(this.status, {super.key});

  final OpStatus status;

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    final (label, icon, color) = switch (status) {
      OpStatus.pending => ('Waiting to send', Icons.schedule, c.tertiary),
      OpStatus.syncing => ('Sending…', Icons.sync, c.primary),
      OpStatus.failed => ('Not accepted', Icons.error_outline, c.error),
      OpStatus.confirmed => (
        'Saved on server',
        Icons.cloud_done_outlined,
        c.primary,
      ),
    };
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.trailing});

  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 20, 4, 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

/// Estimate lines and total, used by the shop and the customer.
class EstimateTable extends StatelessWidget {
  const EstimateTable(this.estimate, {super.key});

  final Estimate estimate;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Column(
      children: [
        for (final l in estimate.lines)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: l.description),
                        TextSpan(
                          text:
                              '  ${lineKindLabel(l.kind)}'
                              '${l.quantity > 1 ? ' · ${l.quantity} × ${money(l.unitPriceMinor, estimate.currency)}' : ''}',
                          style: t.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                Text(money(l.quantity * l.unitPriceMinor, estimate.currency)),
              ],
            ),
          ),
        const Divider(),
        Row(
          children: [
            Expanded(child: Text('Total', style: t.titleMedium)),
            Text(
              money(estimate.totalMinor, estimate.currency),
              style: t.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }
}

/// History timeline entry.
class EventTile extends StatelessWidget {
  const EventTile(this.event, {super.key, this.last = false});

  final JobEvent event;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    final color = switch (event.actorKind) {
      ActorKind.customer => c.tertiary,
      ActorKind.system => c.outline,
      ActorKind.shop => c.primary,
    };
    final who = switch (event.actorKind) {
      ActorKind.customer => 'Customer · ${event.actorLabel}',
      ActorKind.system => 'FixWitness',
      ActorKind.shop => 'Shop · ${event.actorLabel}',
    };
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                const SizedBox(height: 4),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!last)
                  Expanded(child: Container(width: 2, color: c.outlineVariant)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.summary),
                  const SizedBox(height: 2),
                  Text(
                    '${when(event.occurredAt)} · $who',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: c.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Snack bar with the server's message when available.
void showError(BuildContext context, Object error) {
  final text = error is FwException
      ? error.message
      : error is ServerpodClientException
      ? 'Could not reach the server. Check the connection and try again.'
      : 'Something went wrong: $error';
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text), behavior: SnackBarBehavior.floating),
  );
}

/// Announces a change the customer just made on their link (live update).
void showLiveChange(BuildContext context, JobChange change) {
  final c = Theme.of(context).colorScheme;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: c.primaryContainer,
      duration: const Duration(seconds: 6),
      content: Row(
        children: [
          Icon(
            Icons.notifications_active_outlined,
            color: c.onPrimaryContainer,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Job #${change.jobNumber}: ${change.summary}',
              style: TextStyle(color: c.onPrimaryContainer),
            ),
          ),
        ],
      ),
    ),
  );
}
