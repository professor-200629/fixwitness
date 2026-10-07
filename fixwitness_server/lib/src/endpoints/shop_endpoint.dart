import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../fixwitness/access.dart';
import '../fixwitness/validation.dart';
import '../generated/protocol.dart';

/// Shop membership for the signed-in user.
class ShopEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// The caller's shop and role, or null if they have not created a shop yet.
  Future<ShopContext?> myShop(Session session) async {
    final userId = session.authenticated!.authUserId;
    final member = await ShopMember.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
    );
    if (member == null) return null;
    return requireMember(session);
  }

  /// Creates a shop owned by the caller. Calling it again returns the existing
  /// shop, so a retried request does not create a second one.
  Future<ShopContext> createShop(
    Session session,
    String shopName,
    String yourName,
  ) async {
    final existing = await myShop(session);
    if (existing != null) return existing;
    final name = requireText(shopName, 'Shop name', max: 80);
    final displayName = requireText(yourName, 'Your name', max: 60);
    final userId = session.authenticated!.authUserId;
    return session.db.transaction((tx) async {
      final shop = await Shop.db.insertRow(
        session,
        Shop(name: name),
        transaction: tx,
      );
      final member = await ShopMember.db.insertRow(
        session,
        ShopMember(
          shopId: shop.id!,
          authUserId: userId,
          displayName: displayName,
          role: ShopRole.owner,
        ),
        transaction: tx,
      );
      return ShopContext(shop: shop, member: member);
    });
  }
}
