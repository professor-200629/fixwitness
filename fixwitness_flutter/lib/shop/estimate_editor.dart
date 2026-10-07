import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:flutter/material.dart';

import '../common/format.dart';
import '../common/widgets.dart';
import 'shop_services.dart';

class _LineDraft {
  _LineDraft({
    this.kind = LineKind.sparePart,
    String description = '',
    int quantity = 1,
    int? price,
  }) : description = TextEditingController(text: description),
       quantity = TextEditingController(text: '$quantity'),
       price = TextEditingController(
         text: price == null ? '' : minorToInput(price),
       );

  LineKind kind;
  final TextEditingController description;
  final TextEditingController quantity;
  final TextEditingController price;

  int? get quantityValue => int.tryParse(quantity.text.trim());
  int? get priceMinor => parseMinor(price.text);
}

/// Issues a new estimate version. Needs a connection: an estimate exists only
/// once the server has numbered and stored it. Prices are typed in rupees and
/// converted to integer paise without floating point.
class EstimateEditor extends StatefulWidget {
  const EstimateEditor({
    super.key,
    required this.services,
    required this.jobId,
    required this.currency,
    this.previous,
  });

  final ShopServices services;
  final int jobId;
  final String currency;
  final Estimate? previous;

  @override
  State<EstimateEditor> createState() => _EstimateEditorState();
}

class _EstimateEditorState extends State<EstimateEditor> {
  late final List<_LineDraft> _lines;
  final _note = TextEditingController();
  final _reason = TextEditingController();
  bool _busy = false;

  bool get _isRevision => widget.previous != null;

  @override
  void initState() {
    super.initState();
    final prev = widget.previous;
    _lines = prev == null
        ? [
            _LineDraft(),
            _LineDraft(kind: LineKind.labour, description: 'Labour'),
          ]
        : [
            for (final l in prev.lines)
              _LineDraft(
                kind: l.kind,
                description: l.description,
                quantity: l.quantity,
                price: l.unitPriceMinor,
              ),
          ];
    _note.text = prev?.note ?? '';
  }

  int? get _total {
    var total = 0;
    for (final l in _lines) {
      final q = l.quantityValue;
      final p = l.priceMinor;
      if (q == null || p == null) return null;
      total += q * p;
    }
    return total;
  }

  Future<void> _issue() async {
    final lines = <EstimateLine>[];
    for (var i = 0; i < _lines.length; i++) {
      final l = _lines[i];
      if (l.description.text.trim().isEmpty ||
          l.quantityValue == null ||
          l.priceMinor == null) {
        showError(
          context,
          FwException(
            code: FwErrorCode.validation,
            message: 'Line ${i + 1} is incomplete.',
          ),
        );
        return;
      }
      lines.add(
        EstimateLine(
          kind: l.kind,
          description: l.description.text.trim(),
          quantity: l.quantityValue!,
          unitPriceMinor: l.priceMinor!,
        ),
      );
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          _isRevision
              ? 'Issue version ${widget.previous!.versionNumber + 1}?'
              : 'Issue estimate?',
        ),
        content: Text(
          'Total ${money(_total!, widget.currency)}.\n\n'
          'Once issued, this version cannot be edited. '
          '${_isRevision ? 'The customer must approve it before the changed work is authorized.' : 'The customer approves it on their link.'}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Back'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Issue'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    setState(() => _busy = true);
    try {
      await widget.services.client.jobs.issueEstimate(
        widget.jobId,
        widget.previous?.versionNumber,
        lines,
        _note.text.trim().isEmpty ? null : _note.text.trim(),
        _reason.text.trim().isEmpty ? null : _reason.text.trim(),
      );
      widget.services.reportCall(reached: true);
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) showError(context, e);
      if (e is FwException &&
          e.code == FwErrorCode.estimateOutdated &&
          mounted) {
        Navigator.pop(context, true);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = _total;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isRevision
              ? 'Revised estimate v${widget.previous!.versionNumber + 1}'
              : 'New estimate',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_isRevision) ...[
            Text(
              'Version ${widget.previous!.versionNumber} stays on record unchanged. '
              'Explain the change so the customer can decide.',
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _reason,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'What changed and why (shown to customer)',
              ),
            ),
            const SizedBox(height: 8),
          ],
          for (var i = 0; i < _lines.length; i++) _lineCard(i),
          TextButton.icon(
            onPressed: () => setState(() => _lines.add(_LineDraft())),
            icon: const Icon(Icons.add),
            label: const Text('Add line'),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _note,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: 'Note for the customer (optional)',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('Total', style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              Text(
                total == null ? '—' : money(total, widget.currency),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _busy || total == null ? null : _issue,
            icon: const Icon(Icons.send_outlined),
            label: Text(_busy ? 'Issuing…' : 'Issue to customer'),
          ),
        ],
      ),
    );
  }

  Widget _lineCard(int i) {
    final l = _lines[i];
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                DropdownButton<LineKind>(
                  value: l.kind,
                  items: [
                    for (final k in LineKind.values)
                      DropdownMenuItem(value: k, child: Text(lineKindLabel(k))),
                  ],
                  onChanged: (v) => setState(() => l.kind = v!),
                ),
                const Spacer(),
                if (_lines.length > 1)
                  IconButton(
                    tooltip: 'Remove line',
                    onPressed: () => setState(() => _lines.removeAt(i)),
                    icon: const Icon(Icons.delete_outline),
                  ),
              ],
            ),
            TextField(
              controller: l.description,
              decoration: const InputDecoration(
                labelText: 'Description',
                isDense: true,
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: l.quantity,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Qty',
                      isDense: true,
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: l.price,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Unit price (${widget.currency})',
                      isDense: true,
                      errorText: l.price.text.isNotEmpty && l.priceMinor == null
                          ? 'Use a number like 4500 or 4500.50'
                          : null,
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
