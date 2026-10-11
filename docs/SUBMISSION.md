# Hackathon submission

Text for the submission form, and the plan for the video (under 2 minutes, public on YouTube).
Placeholders in `<angle brackets>` are filled in once the Cloud deployment and repository exist.

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
- **A recurring future call** cleans up photo uploads that were never registered.
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
- All of it runs in CI.
- Verified on an Android emulator and a physical Android phone, including an offline capture
  that survived an app restart and a customer approval made on the phone.

**Try it.**
- Web app and customer page: `<https://….serverpod.space>`
- Android APK: `<release link>`
- Demo shop login for judges: `<email / password>`
- Code: `<github link>`

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
