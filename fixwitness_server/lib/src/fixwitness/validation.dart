import '../generated/protocol.dart';
import 'errors.dart';

/// Matches text that records a device unlock secret, e.g. "passcode 1234" or
/// "password: hunter2". FixWitness never stores customer device passwords, so
/// such text is rejected rather than saved. "PIN connector loose" is allowed:
/// a secret needs a separator (is / : / =) or a run of digits after the word.
final _secretPattern = RegExp(
  r'\b(pass ?code|password|passwd|pin|unlock code|lock code|pattern lock|'
  r'screen lock|pattern)\b\s*(?:(?:is|=|:)\s*\S+|\d{3,})',
  caseSensitive: false,
);

/// Trims [value] and checks its length; throws a validation error naming
/// [field] when it is out of range.
String requireText(
  String? value,
  String field, {
  int min = 1,
  required int max,
}) {
  final trimmed = (value ?? '').trim();
  if (trimmed.length < min) {
    throw invalid(min == 1 ? '$field is required.' : '$field is too short.');
  }
  if (trimmed.length > max) {
    throw invalid('$field must be at most $max characters.');
  }
  rejectSecrets(trimmed, field);
  return trimmed;
}

String? optionalText(String? value, String field, {required int max}) {
  final trimmed = (value ?? '').trim();
  if (trimmed.isEmpty) return null;
  return requireText(trimmed, field, max: max);
}

void rejectSecrets(String text, String field) {
  if (_secretPattern.hasMatch(text)) {
    throw FwException(
      code: FwErrorCode.sensitiveContent,
      message:
          '$field looks like it contains a device passcode or password. '
          'FixWitness does not store customer unlock codes; remove it and '
          'ask the customer to unlock the device in person when needed.',
    );
  }
}

String requirePhone(String? value) {
  final trimmed = (value ?? '').trim();
  final digits = trimmed.replaceAll(RegExp(r'[^0-9]'), '');
  if (!RegExp(r'^\+?[0-9 ()\-]+$').hasMatch(trimmed) ||
      digits.length < 6 ||
      digits.length > 15) {
    throw invalid('Customer phone must be 6 to 15 digits.');
  }
  return trimmed;
}

const maxLines = 30;
const maxQuantity = 999;

/// Largest unit price accepted, in minor units (10,000,000.00 of the currency).
const maxUnitPriceMinor = 1000000000;

/// Validates estimate lines and returns them normalised plus the total in
/// integer minor units. Totals are computed here, never taken from the client.
({List<EstimateLine> lines, int totalMinor}) normaliseLines(
  List<EstimateLine> lines,
) {
  if (lines.isEmpty) throw invalid('An estimate needs at least one line.');
  if (lines.length > maxLines) {
    throw invalid('An estimate can have at most $maxLines lines.');
  }
  var total = 0;
  final out = <EstimateLine>[];
  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    final n = i + 1;
    final description = requireText(
      line.description,
      'Line $n description',
      max: 200,
    );
    if (line.quantity < 1 || line.quantity > maxQuantity) {
      throw invalid('Line $n quantity must be between 1 and $maxQuantity.');
    }
    if (line.unitPriceMinor < 0 || line.unitPriceMinor > maxUnitPriceMinor) {
      throw invalid('Line $n price is out of range.');
    }
    total += line.quantity * line.unitPriceMinor;
    out.add(
      EstimateLine(
        kind: line.kind,
        description: description,
        quantity: line.quantity,
        unitPriceMinor: line.unitPriceMinor,
      ),
    );
  }
  return (lines: out, totalMinor: total);
}

const _symbols = {'INR': '₹', 'USD': r'$', 'EUR': '€', 'GBP': '£'};

/// Formats integer minor units for history text, e.g. `₹4,500.00`. Matches the
/// app's formatting: INR uses Indian digit grouping (1,23,456.00).
String formatMoney(int minor, String currency) {
  final negative = minor < 0;
  final abs = minor.abs();
  final whole = (abs ~/ 100).toString();
  final fraction = (abs % 100).toString().padLeft(2, '0');
  final grouped = currency == 'INR' ? _groupIndian(whole) : _groupWestern(whole);
  return '${negative ? '-' : ''}${_symbols[currency] ?? '$currency '}$grouped.$fraction';
}

String _groupWestern(String digits) {
  final out = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) out.write(',');
    out.write(digits[i]);
  }
  return out.toString();
}

String _groupIndian(String digits) {
  if (digits.length <= 3) return digits;
  final last3 = digits.substring(digits.length - 3);
  var rest = digits.substring(0, digits.length - 3);
  final parts = <String>[];
  while (rest.length > 2) {
    parts.insert(0, rest.substring(rest.length - 2));
    rest = rest.substring(0, rest.length - 2);
  }
  if (rest.isNotEmpty) parts.insert(0, rest);
  return '${parts.join(',')},$last3';
}
