import 'package:fixwitness_client/fixwitness_client.dart';
import 'package:flutter/material.dart';

import 'shop_services.dart';

/// Intake form. Works offline: the job is queued on the phone and created on
/// the server when a connection is available.
class NewJobScreen extends StatefulWidget {
  const NewJobScreen({super.key, required this.services});

  final ShopServices services;

  @override
  State<NewJobScreen> createState() => _NewJobScreenState();
}

class _NewJobScreenState extends State<NewJobScreen> {
  final _form = GlobalKey<FormState>();
  final _customer = TextEditingController();
  final _phone = TextEditingController();
  final _make = TextEditingController();
  final _model = TextEditingController();
  final _serial = TextEditingController();
  final _fault = TextEditingController();
  final _accessories = TextEditingController();
  bool _saving = false;

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Required' : null;

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _saving = true);
    await widget.services.outbox.enqueueCreateJob(
      NewJobInput(
        customerName: _customer.text.trim(),
        customerPhone: _phone.text.trim(),
        deviceMake: _make.text.trim(),
        deviceModel: _model.text.trim(),
        deviceSerial: _serial.text.trim().isEmpty ? null : _serial.text.trim(),
        reportedFault: _fault.text.trim(),
        accessories: _accessories.text.trim().isEmpty
            ? null
            : _accessories.text.trim(),
      ),
    );
    // Saved on the phone; sending happens in the background.
    widget.services.syncNow();
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('New job')),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: c.secondaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lock_outline, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Do not record the customer’s passcode, PIN or pattern. '
                      'Ask them to unlock the device in person when testing is needed.',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _customer,
              decoration: const InputDecoration(labelText: 'Customer name'),
              textCapitalization: TextCapitalization.words,
              validator: _required,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phone,
              decoration: const InputDecoration(labelText: 'Customer phone'),
              keyboardType: TextInputType.phone,
              validator: _required,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _make,
                    decoration: const InputDecoration(labelText: 'Make'),
                    validator: _required,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _model,
                    decoration: const InputDecoration(labelText: 'Model'),
                    validator: _required,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _serial,
              decoration: const InputDecoration(
                labelText: 'IMEI / serial (optional)',
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _fault,
              decoration: const InputDecoration(labelText: 'Reported fault'),
              maxLines: 3,
              validator: _required,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _accessories,
              decoration: const InputDecoration(
                labelText: 'Accessories left with device (optional)',
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _saving ? null : _save,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Check in device'),
            ),
            const SizedBox(height: 8),
            Text(
              'Saved on this phone first, then sent to the server. You can add the '
              'condition checklist and photos right away, even offline.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
