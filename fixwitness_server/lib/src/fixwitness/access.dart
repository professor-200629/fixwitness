import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import 'errors.dart';

/// Resolves the signed-in user's shop membership. Every shop endpoint calls
/// this first, so all reads and writes are scoped to the caller's shop.
Future<ShopContext> requireMember(Session session) async {
  final auth = session.authenticated;
  if (auth == null) throw forbidden('Sign in to continue.');
  final member = await ShopMember.db.findFirstRow(
    session,
    where: (t) => t.authUserId.equals(auth.authUserId),
  );
  if (member == null) {
    throw forbidden('This account is not part of a shop yet. Create your shop first.');
  }
  final shop = await Shop.db.findById(session, member.shopId);
  if (shop == null) throw forbidden('Your shop no longer exists.');
  return ShopContext(shop: shop, member: member);
}

/// Loads a job that belongs to [shopId]. A job from another shop is reported
/// as not found so its existence is not revealed.
Future<RepairJob> loadShopJob(
  Session session,
  int jobId,
  int shopId, {
  Transaction? transaction,
  bool lock = false,
}) async {
  final job = await RepairJob.db.findById(
    session,
    jobId,
    transaction: transaction,
    lockMode: lock ? LockMode.forUpdate : null,
  );
  if (job == null || job.shopId != shopId) {
    throw notFound('Job not found.');
  }
  return job;
}
