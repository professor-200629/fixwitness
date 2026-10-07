import 'package:fixwitness_client/fixwitness_client.dart';

const _symbols = {'INR': '₹', 'USD': r'$', 'EUR': '€', 'GBP': '£'};

/// Formats integer minor units. INR uses Indian digit grouping (1,23,456.00).
String money(int minor, String currency) {
  final negative = minor < 0;
  final abs = minor.abs();
  final whole = (abs ~/ 100).toString();
  final fraction = (abs % 100).toString().padLeft(2, '0');
  final grouped = currency == 'INR' ? _indian(whole) : _western(whole);
  final symbol = _symbols[currency] ?? '$currency ';
  return '${negative ? '-' : ''}$symbol$grouped.$fraction';
}

String _western(String digits) {
  final out = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) out.write(',');
    out.write(digits[i]);
  }
  return out.toString();
}

String _indian(String digits) {
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

/// Parses a price typed in major units ("4500", "4,500.5") into minor units
/// without going through floating point. Returns null if invalid.
int? parseMinor(String input) {
  final s = input.replaceAll(',', '').replaceAll(' ', '').trim();
  final m = RegExp(r'^(\d{1,9})(?:\.(\d{0,2}))?$').firstMatch(s);
  if (m == null) return null;
  final whole = int.parse(m.group(1)!);
  final frac = (m.group(2) ?? '').padRight(2, '0');
  return whole * 100 + int.parse(frac.isEmpty ? '0' : frac);
}

/// Minor units back to an editable string ("4500.50").
String minorToInput(int minor) =>
    '${minor ~/ 100}.${(minor % 100).toString().padLeft(2, '0')}';

String statusLabel(JobStatus s) => switch (s) {
  JobStatus.checkedIn => 'Checked in',
  JobStatus.awaitingApproval => 'Awaiting approval',
  JobStatus.approved => 'Approved',
  JobStatus.inProgress => 'In repair',
  JobStatus.declined => 'Declined',
  JobStatus.completed => 'Ready for collection',
  JobStatus.collected => 'Collected',
};

String estimateStatusLabel(EstimateStatus s) => switch (s) {
  EstimateStatus.issued => 'Waiting for customer',
  EstimateStatus.superseded => 'Replaced before decision',
  EstimateStatus.approved => 'Approved by customer',
  EstimateStatus.declined => 'Declined by customer',
};

String conditionLabel(ConditionState s) => switch (s) {
  ConditionState.ok => 'OK',
  ConditionState.damaged => 'Damaged',
  ConditionState.notWorking => 'Not working',
  ConditionState.notTested => 'Not tested',
  ConditionState.notApplicable => 'N/A',
};

String stageLabel(PhotoStage s) => switch (s) {
  PhotoStage.intake => 'Check-in',
  PhotoStage.progress => 'Progress',
  PhotoStage.completion => 'Completed',
  PhotoStage.handover => 'Handover',
};

String lineKindLabel(LineKind k) => switch (k) {
  LineKind.sparePart => 'Part',
  LineKind.labour => 'Labour',
  LineKind.other => 'Other',
};

const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

/// Local date and time, e.g. "7 Oct 2026, 14:05".
String when(DateTime t) {
  final l = t.toLocal();
  final hh = l.hour.toString().padLeft(2, '0');
  final mm = l.minute.toString().padLeft(2, '0');
  return '${l.day} ${_months[l.month - 1]} ${l.year}, $hh:$mm';
}
