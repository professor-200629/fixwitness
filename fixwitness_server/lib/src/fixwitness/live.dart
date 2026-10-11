import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

String shopChannel(int shopId) => 'fixwitness-shop-$shopId';

/// Tells every signed-in device of the job's shop that the job changed.
/// Call after the transaction has committed, so a device that reloads on
/// the message sees the new state. Delivery is best effort: devices that
/// miss it still see the change on their next reload.
Future<void> announce(
  Session session,
  RepairJob job,
  String summary, {
  bool fromCustomer = false,
}) async {
  try {
    await session.messages.postMessage(
      shopChannel(job.shopId),
      JobChange(
        jobId: job.id!,
        jobNumber: job.jobNumber,
        summary: summary,
        fromCustomer: fromCustomer,
        occurredAt: DateTime.now().toUtc(),
      ),
    );
  } catch (e, st) {
    session.log(
      'Live update not sent: $e',
      level: LogLevel.warning,
      stackTrace: st,
    );
  }
}
