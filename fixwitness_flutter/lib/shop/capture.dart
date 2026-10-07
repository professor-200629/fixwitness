import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../common/format.dart';
import '../common/widgets.dart';
import 'shop_services.dart';

/// Evidence capture. Everything here is queued on the phone first, so it
/// works without a connection.

Future<void> capturePhoto(
  BuildContext context,
  ShopServices s, {
  int? serverJobId,
  UuidValue? jobOpId,
}) async {
  final source = kIsWeb
      ? ImageSource.gallery
      : await showModalBottomSheet<ImageSource>(
          context: context,
          showDragHandle: true,
          builder: (ctx) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_camera_outlined),
                  title: const Text('Take photo'),
                  onTap: () => Navigator.pop(ctx, ImageSource.camera),
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: const Text('Choose from gallery'),
                  onTap: () => Navigator.pop(ctx, ImageSource.gallery),
                ),
              ],
            ),
          ),
        );
  if (source == null) return;
  final XFile? file;
  try {
    file = await ImagePicker().pickImage(
      source: source,
      maxWidth: 1600,
      maxHeight: 1600,
      imageQuality: 82,
    );
  } catch (e) {
    if (context.mounted) showError(context, e);
    return;
  }
  if (file == null || !context.mounted) return;
  final bytes = await file.readAsBytes();
  final isPng = bytes.length > 4 && bytes[0] == 0x89 && bytes[1] == 0x50;
  if (!context.mounted) return;

  final details = await showDialog<(PhotoStage, String)>(
    context: context,
    builder: (ctx) => _PhotoDetailsDialog(bytes: bytes),
  );
  if (details == null) return;
  await s.outbox.enqueuePhoto(
    serverJobId: serverJobId,
    jobOpId: jobOpId,
    bytes: bytes,
    contentType: isPng ? 'image/png' : 'image/jpeg',
    stage: details.$1,
    caption: details.$2.trim().isEmpty ? null : details.$2.trim(),
  );
  s.syncNow();
}

class _PhotoDetailsDialog extends StatefulWidget {
  const _PhotoDetailsDialog({required this.bytes});

  final Uint8List bytes;

  @override
  State<_PhotoDetailsDialog> createState() => _PhotoDetailsDialogState();
}

class _PhotoDetailsDialogState extends State<_PhotoDetailsDialog> {
  var _stage = PhotoStage.intake;
  final _caption = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Save photo'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(widget.bytes, height: 180, fit: BoxFit.cover),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<PhotoStage>(
              initialValue: _stage,
              decoration: const InputDecoration(labelText: 'Stage'),
              items: [
                for (final st in PhotoStage.values)
                  DropdownMenuItem(value: st, child: Text(stageLabel(st))),
              ],
              onChanged: (v) => setState(() => _stage = v!),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _caption,
              decoration: const InputDecoration(
                labelText: 'Caption (optional)',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, (_stage, _caption.text)),
          child: const Text('Save'),
        ),
      ],
    );
  }
}

Future<void> addNote(
  BuildContext context,
  ShopServices s, {
  int? serverJobId,
  UuidValue? jobOpId,
}) async {
  final text = TextEditingController();
  var visible = false;
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setLocal) => AlertDialog(
        title: const Text('Add note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: text,
              maxLines: 4,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'What did you find or do?',
              ),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: visible,
              onChanged: (v) => setLocal(() => visible = v),
              title: const Text('Show to customer'),
              subtitle: const Text('Appears as an update on their link'),
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
            child: const Text('Save'),
          ),
        ],
      ),
    ),
  );
  if (ok != true || text.text.trim().isEmpty) return;
  await s.outbox.enqueueNote(
    serverJobId: serverJobId,
    jobOpId: jobOpId,
    text: text.text.trim(),
    customerVisible: visible,
  );
  s.syncNow();
}

const standardChecks = [
  ('screen', 'Screen / display'),
  ('touch', 'Touch response'),
  ('backGlass', 'Back glass / cover'),
  ('frame', 'Frame / housing'),
  ('frontCamera', 'Front camera'),
  ('rearCamera', 'Rear camera'),
  ('buttons', 'Buttons'),
  ('chargingPort', 'Charging port'),
  ('speakerMic', 'Speaker / microphone'),
  ('biometrics', 'Face / fingerprint unlock'),
  ('battery', 'Battery (swelling)'),
  ('waterIndicator', 'Liquid damage indicator'),
  ('simTray', 'SIM tray'),
];

Future<void> openChecklist(
  BuildContext context,
  ShopServices s, {
  int? serverJobId,
  UuidValue? jobOpId,
  ConditionReport? previous,
}) async {
  final items = await Navigator.push<List<ConditionItem>>(
    context,
    MaterialPageRoute(builder: (_) => _ChecklistScreen(previous: previous)),
  );
  if (items == null) return;
  await s.outbox.enqueueCondition(
    serverJobId: serverJobId,
    jobOpId: jobOpId,
    items: items,
  );
  s.syncNow();
}

class _ChecklistScreen extends StatefulWidget {
  const _ChecklistScreen({this.previous});

  final ConditionReport? previous;

  @override
  State<_ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<_ChecklistScreen> {
  late final Map<String, ConditionState> _states;
  late final Map<String, TextEditingController> _notes;

  @override
  void initState() {
    super.initState();
    final prev = {
      for (final i in widget.previous?.items ?? <ConditionItem>[]) i.key: i,
    };
    _states = {
      for (final (k, _) in standardChecks)
        k: prev[k]?.state ?? ConditionState.notTested,
    };
    _notes = {
      for (final (k, _) in standardChecks)
        k: TextEditingController(text: prev[k]?.note ?? ''),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Condition at check-in')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Padding(
            padding: EdgeInsets.all(4),
            child: Text(
              'Record what you see before any work. Each save is kept; earlier '
              'checks are never overwritten.',
            ),
          ),
          for (final (key, label) in standardChecks)
            Card(
              margin: const EdgeInsets.only(top: 8),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (final st in ConditionState.values)
                          ChoiceChip(
                            label: Text(conditionLabel(st)),
                            selected: _states[key] == st,
                            onSelected: (_) =>
                                setState(() => _states[key] = st),
                          ),
                      ],
                    ),
                    if (_states[key] == ConditionState.damaged ||
                        _states[key] == ConditionState.notWorking)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: TextField(
                          controller: _notes[key],
                          decoration: const InputDecoration(
                            labelText: 'Describe it',
                            isDense: true,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 80),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context, _items()),
        icon: const Icon(Icons.save_outlined),
        label: const Text('Save checklist'),
      ),
    );
  }

  List<ConditionItem> _items() => [
    for (final (key, label) in standardChecks)
      ConditionItem(
        key: key,
        label: label,
        state: _states[key]!,
        note: _notes[key]!.text.trim().isEmpty
            ? null
            : _notes[key]!.text.trim(),
      ),
  ];
}
