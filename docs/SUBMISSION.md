# Hackathon submission

Text for the submission form, and the plan for the video (under 2 minutes, public on YouTube).

## One-line summary

FixWitness gives phone-repair shops and their customers one record neither side can quietly
change: condition and photos at check-in, then approval of one exact estimate version from the
customer's own phone. It works offline at the counter and updates live.

## Description

**The problem.** Small phone-repair shops in India run on trust and paper slips. Disputes are
always the same three: "the screen wasn't cracked when I gave it to you", "I never agreed to
₹4,000", and "you said ₹3,200". The shop has no proof, and neither does the customer.

**What FixWitness does.**
- At check-in the shop records the device's condition with a checklist and photos. This works
  with no connection: the Android app queues everything on the phone and sends it when the
  network returns.
- The shop issues an estimate. Every estimate version is immutable and identified by a content
  hash.
- The customer gets a link (QR code at the counter, or shared to WhatsApp). On their own phone
  they see the condition record and photos, and approve or decline *that exact version*, signed
  with their name. They never need an account.
- If the shop revises the estimate while the customer is looking at the old one, the old approval
  is refused. The customer sees what changed. An approval of v1 can never count for v2.
- The approval appears on every shop device at once. Owners invite technicians with a one-time
  code. Both sides can read the full history.

**Built on Serverpod 4.**
- **Transactions with row locks** make an approval racing a revision resolve to one serial
  order. History is written in the same transaction as the change.
- **A streaming endpoint fed by server events** pushes job changes to the shop's devices.
- **A recurring future call** cleans up photo uploads that were never registered (tested on
  a real server; Cloud's Starter plan keeps future calls off, so the demo runs without it).
- **Private cloud storage** takes photos as direct uploads, checked with `verifyUpload`, and
  resumes interrupted uploads.
- **The client-side database** (`database: client`) holds the offline outbox and job cache as
  Serverpod models on the phone.
- **The email identity provider** handles shop accounts.
- **Relic middleware** serves the web bundle gzipped for phones on mobile data.
- **Serverpod Cloud** hosts it all.

**Does it work.**
- 33 server integration tests run on a real server and PostgreSQL, covering outdated approvals,
  concurrent approve-vs-revise races, retries, cross-shop access, live updates, invites and
  cleanup.
- 11 app tests cover the offline queue on real SQLite.
- 42 end-to-end checks run over HTTP and websockets.
- The server and app tests, analysis and formatting run in GitHub Actions on every push; the
  end-to-end checks run against a live server.
- Verified on a physical Android phone against the live Serverpod Cloud deployment: offline
  check-in with a camera photo that synced when the network came back, the QR link, the refused
  old-version approval, the signed approval of v2, the history, and link revocation. Also on an
  Android emulator, including an offline capture that survived an app restart.
- That run found two weaknesses, both fixed and redeployed the same night: the customer saw only
  the first condition check, and the shop app missed an approval made while it was in the
  background (STATUS.md, bugs 9 and 10).

**Try it.**
- Web app and customer page: https://fixwitness.serverpod.space/
- Demo video: https://youtu.be/pcIDlt0_vwg
- Android APK: https://github.com/professor-200629/fixwitness/releases/tag/v1.0.0
- Demo shop "Fix Point Mobiles" for judges: tap **Sign in** (the page opens on Sign up), then use
  the email and password given in the submission form. Or sign up with your own email: Serverpod
  Cloud sends the code.
- Code: https://github.com/professor-200629/fixwitness

**Build and run.** Flutter 3.47.6 and the Serverpod CLI 4.0.4; no Docker (Serverpod 4 runs an
embedded PostgreSQL for development).

```bash
git clone https://github.com/professor-200629/fixwitness && cd fixwitness
flutter pub get
cd fixwitness_server
serverpod run flutter_build                  # builds the web app the server serves
dart run bin/main.dart --apply-migrations    # API :8080, web :8082 (embedded PostgreSQL)
dart test                                    # 33 integration tests (second terminal)
cd ../fixwitness_flutter && flutter test     # 11 app tests
```

Full setup, the Android build and the Cloud deploy steps are in the README.

**AI disclosure.** Built with Claude Code (Claude Opus 5.5) and the official Serverpod agent
skills. The developer wrote the specification and made the product decisions, and did the
device testing with the agent. The agent wrote most of the code and tests. Details:
`AI_DISCLOSURE.md`.

## Video plan (target 1:50)

Recorded as phone screen captures (`adb screenrecord`) and browser captures, joined with
`ffmpeg`, with on-screen captions; a voice-over is optional.

| Time | Screen | Caption / voice |
|---|---|---|
| 0:00–0:08 | Title card: shield icon, "FixWitness" | "Phone repair shops lose money and customers over one sentence: *I never agreed to that.*" |
| 0:08–0:25 | Shop phone: New job → condition checklist (screen cracked, back glass OK) → camera photo. Banner shows *Offline · saved on this phone* | "Check-in records the condition with photos, even with no network." |
| 0:25–0:32 | Network back: queue items turn *Saved on server* | "When the connection returns, everything syncs. Retries can't create duplicates." |
| 0:32–0:45 | Issue estimate v1 ₹3,600 → customer link sheet with QR code → customer phone scans it | "The customer gets a link: a QR at the counter, or WhatsApp." |
| 0:45–1:00 | Customer phone: condition + photos, tick "I approve version 1 for ₹3,600", type name, Approve. Cut to shop phone: notice *Job #12: Customer approved estimate v1.* | "They approve one exact version, and the shop sees it instantly." |
| 1:00–1:20 | Shop issues v2 (adds a part, ₹4,250) while the customer page still shows v1 → customer presses Approve → refusal: *a newer estimate exists*, page shows v2 with "what changed" | "If the price changes, the old approval is refused and the customer sees exactly what changed." |
| 1:20–1:32 | History on both sides; owner menu → Invite a technician → code | "Every step is in a history both sides can read. Owners invite their technicians with a one-time code." |
| 1:32–1:48 | Architecture card: Flutter (Android + web) ↔ Serverpod 4 on Serverpod Cloud: transactions + row locks, streaming + server events, future calls, cloud storage, client SQLite. "33 + 11 + 42 tests in CI" | "Built on Serverpod 4, tested against a real database, deployed on Serverpod Cloud." |
| 1:48–1:52 | End card: URL + GitHub | "FixWitness. Repair records both sides can trust." |
