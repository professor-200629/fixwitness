import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../common/format.dart';
import '../common/widgets.dart';
import 'shop_services.dart';

/// Owner: creates a single-use invite code and shows it with Share / Copy.
Future<void> showInviteDialog(BuildContext context, ShopServices s) async {
  final InviteCode invite;
  try {
    invite = await s.client.shop.createInvite();
  } catch (e) {
    if (context.mounted) showError(context, e);
    return;
  }
  if (!context.mounted) return;
  await showDialog<void>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Invite a technician'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'They sign up in FixWitness, choose "Join with a code" and enter '
            'this code. It works once.',
          ),
          const SizedBox(height: 16),
          Center(
            child: SelectableText(
              invite.code,
              style: Theme.of(ctx).textTheme.headlineMedium?.copyWith(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Valid until ${when(invite.expiresAt)}',
              style: Theme.of(ctx).textTheme.bodySmall,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: invite.code));
            Navigator.pop(ctx);
          },
          child: const Text('Copy'),
        ),
        FilledButton.icon(
          onPressed: () => SharePlus.instance.share(
            ShareParams(
              text: 'Join my shop on FixWitness with this code: ${invite.code}',
            ),
          ),
          icon: const Icon(Icons.share_outlined),
          label: const Text('Share'),
        ),
      ],
    ),
  );
}
