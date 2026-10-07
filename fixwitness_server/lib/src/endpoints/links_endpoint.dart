import 'package:serverpod/serverpod.dart';

import '../fixwitness/access.dart';
import '../fixwitness/errors.dart';
import '../fixwitness/history.dart';
import '../fixwitness/links.dart';
import '../generated/protocol.dart';

/// Shop staff create and revoke customer review links.
class LinksEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Creates a link valid for [validDays] (1-30). The returned URL is the only
  /// time the token is visible; the server keeps just its hash.
  Future<CreatedLink> create(Session session, int jobId, int validDays) async {
    final ctx = await requireMember(session);
    if (validDays < 1 || validDays > 30) {
      throw invalid('A link can be valid for 1 to 30 days.');
    }
    final token = newLinkToken();
    final now = DateTime.now().toUtc();
    final link = await session.db.transaction((tx) async {
      var job = await loadShopJob(
        session,
        jobId,
        ctx.shop.id!,
        transaction: tx,
        lock: true,
      );
      final link = await CustomerLink.db.insertRow(
        session,
        CustomerLink(
          jobId: jobId,
          tokenHash: hashToken(token),
          createdByUserId: ctx.member.authUserId,
          createdAt: now,
          expiresAt: now.add(Duration(days: validDays)),
        ),
        transaction: tx,
      );
      job = await appendEvent(
        session,
        tx,
        job,
        type: JobEventType.customerLinkCreated,
        actorKind: ActorKind.shop,
        actorLabel: ctx.member.displayName,
        summary: 'Review link created, valid for $validDays days.',
        customerVisible: false,
      );
      await saveJob(session, tx, job);
      return link;
    });
    return CreatedLink(link: link, url: customerUrl(session, token));
  }

  Future<CustomerLink> revoke(Session session, int linkId) async {
    final ctx = await requireMember(session);
    return session.db.transaction((tx) async {
      final link = await CustomerLink.db.findById(session, linkId, transaction: tx);
      if (link == null) throw notFound('Link not found.');
      var job = await loadShopJob(
        session,
        link.jobId,
        ctx.shop.id!,
        transaction: tx,
        lock: true,
      );
      if (link.revokedAt != null) return link;
      final revoked = await CustomerLink.db.updateRow(
        session,
        link.copyWith(revokedAt: DateTime.now().toUtc()),
        transaction: tx,
      );
      job = await appendEvent(
        session,
        tx,
        job,
        type: JobEventType.customerLinkRevoked,
        actorKind: ActorKind.shop,
        actorLabel: ctx.member.displayName,
        summary: 'A review link was revoked.',
        customerVisible: false,
      );
      await saveJob(session, tx, job);
      return revoked;
    });
  }
}
