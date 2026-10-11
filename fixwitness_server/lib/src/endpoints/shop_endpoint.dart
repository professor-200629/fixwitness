import 'dart:math';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../fixwitness/access.dart';
import '../fixwitness/errors.dart';
import '../fixwitness/links.dart' show hashToken;
import '../fixwitness/live.dart';
import '../fixwitness/validation.dart';
import '../generated/protocol.dart';

/// Unambiguous characters (no 0/O, 1/I/L) for codes read out at the counter.
const _codeAlphabet = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';
final _random = Random.secure();

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

  /// Live changes to the caller's shop: every device of the shop receives a
  /// [JobChange] when a job changes, including customer approvals made on a
  /// review link. Open while the app runs; reopen after a disconnect.
  Stream<JobChange> watch(Session session) async* {
    final ctx = await requireMember(session);
    yield* session.messages.createStream<JobChange>(shopChannel(ctx.shop.id!));
  }

  /// Owner only: a single-use code a technician enters to join this shop.
  /// Valid for 24 hours. Only its hash is stored, so it is shown just once.
  Future<InviteCode> createInvite(Session session) async {
    final ctx = await requireMember(session);
    if (ctx.member.role != ShopRole.owner) {
      throw forbidden('Only the shop owner can invite technicians.');
    }
    final raw = List.generate(
      8,
      (_) => _codeAlphabet[_random.nextInt(_codeAlphabet.length)],
    ).join();
    final now = DateTime.now().toUtc();
    final invite = await ShopInvite.db.insertRow(
      session,
      ShopInvite(
        shopId: ctx.shop.id!,
        codeHash: hashToken(raw),
        createdByUserId: ctx.member.authUserId,
        createdAt: now,
        expiresAt: now.add(const Duration(hours: 24)),
      ),
    );
    return InviteCode(
      code: '${raw.substring(0, 4)}-${raw.substring(4)}',
      expiresAt: invite.expiresAt,
    );
  }

  /// Joins the shop that issued [code] as a technician. The caller must not
  /// belong to a shop yet. Each code works once.
  Future<ShopContext> joinShop(
    Session session,
    String code,
    String yourName,
  ) async {
    if (await myShop(session) != null) {
      throw invalid('This account already belongs to a shop.');
    }
    final displayName = requireText(yourName, 'Your name', max: 60);
    final normalised = code.toUpperCase().replaceAll(RegExp('[^A-Z0-9]'), '');
    final userId = session.authenticated!.authUserId;
    return session.db.transaction((tx) async {
      final invite = await ShopInvite.db.findFirstRow(
        session,
        where: (t) => t.codeHash.equals(hashToken(normalised)),
        transaction: tx,
        lockMode: LockMode.forUpdate,
      );
      if (invite == null ||
          invite.usedAt != null ||
          invite.expiresAt.isBefore(DateTime.now().toUtc())) {
        throw FwException(
          code: FwErrorCode.inviteInvalid,
          message:
              'That invite code is not valid. Codes work once and expire after '
              '24 hours; ask the shop owner for a new one.',
        );
      }
      await ShopInvite.db.updateRow(
        session,
        invite.copyWith(usedAt: DateTime.now().toUtc(), usedByUserId: userId),
        transaction: tx,
      );
      final member = await ShopMember.db.insertRow(
        session,
        ShopMember(
          shopId: invite.shopId,
          authUserId: userId,
          displayName: displayName,
          role: ShopRole.technician,
        ),
        transaction: tx,
      );
      final shop = (await Shop.db.findById(
        session,
        invite.shopId,
        transaction: tx,
      ))!;
      return ShopContext(shop: shop, member: member);
    });
  }
}
