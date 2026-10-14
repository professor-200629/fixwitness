# FixWitness — project status

_Last updated 2026-10-14._

## Completed

| Slice | What exists |
|---|---|
| Tooling | Flutter 3.47.6, Serverpod CLI 4.0.4, project from `serverpod create` with the official Serverpod agent skills and MCP config. Docs read from docs.serverpod.dev (`llms.txt`) for 4.0.4. |
| 1. Online workflow | Server models + endpoints for shops, jobs, condition checklists, photos, notes, versioned estimates, customer links, decisions, collection, history. Shop app (Android/web) and customer review page (web) on the generated client. |
| 2. Correctness | 33 server integration tests (real server + embedded PostgreSQL), 35-check HTTP end-to-end harness (`fixwitness_e2e`). |
| 3. Offline | Durable outbox + job cache on Serverpod client-side SQLite (`database: client`, stable feature; experimental `database: sync` not used). 7 tests on real SQLite. |
| 4. Customer UX / history | Progress bar, server-written authorization statement, "changed since vN" diff, exact-version approval with typed name, collection confirmation, full history on both sides, localised outdated-approval message, token kept in the URL so refresh works. |
| 5. Shop team + live (2026-10-11) | Live job updates over a Serverpod streaming endpoint fed by server events (`shop.watch()`); customer approvals show at the counter at once. Technician invites (single-use, 24 h, hashed codes) and "Join with a code" at sign-up. QR code + Share for customer links. Hourly recurring future call that deletes never-registered photo bytes. App identity `com.fixwitness.app` and icon. |

Design notes: `docs/PLAN.md`. Setup: `README.md`. Demonstration: `docs/DEMO.md`.

## Verification results (observed)

| Requirement | How it was checked | Result |
|---|---|---|
| Fresh job creation on two separate sessions | e2e: two independently signed-in clients create jobs at the same moment; server test: 10 concurrent creates across two members | PASS — distinct job numbers (1 and 2; 1–10), both visible to both sessions |
| Outdated approval rejection | e2e + server test: approve v1 after v2 issued; browser: customer page with v1 ticked, shop issues v2, customer presses Approve | PASS — `estimateOutdated` (attempted 1, current 2), nothing recorded, refusal written to history, page reloads to v2 with change summary |
| Concurrent estimate change and approval | e2e: 10 races over HTTP; server test: 15 races in-process (`approve(v1)` ∥ `issueEstimate(v2)`) | PASS — every outcome is one of the two serial orders; both orders observed (e2e 9/1, server 14/1); history seq contiguous |
| Duplicate upload retries | e2e: 5 concurrent `createJob` with one op id, retried note, retried photo registration; outbox tests: lost response after save | PASS — one record each |
| App restart while offline | **Android emulator** (Pixel 7, Android 16/API 36): airplane mode on (server confirmed unreachable from the device); new job + note + condition checklist + gallery photo captured; app force-stopped (process gone); device SQLite pulled and read: 4 pending rows, children linked to the queued job, photo file in `pending_photos/`; relaunched still offline: signed in, shop from cache, "4 item(s) saved on this phone"; airplane mode off: job created on the server as #2 with note, checklist and photo. Also the desktop outbox tests | PASS on device (after the fix below). Screenshots in `docs/evidence/` |
| Unauthorized job access | e2e + server tests: other shop (get, note, estimate, start, link, photo URL, upload), unauthenticated, signed-in user without shop, link used against another job's estimate, made-up / revoked / expired tokens, shop account calling customer approval | PASS — `notFound` for other shops (existence not revealed), 401 unauthenticated, `forbidden`, `linkInvalid` / `linkRevoked` / `linkExpired`, `shopAccountCannotApprove` |
| Database persistence after server restart | e2e `before-restart`; server and embedded PostgreSQL killed (postmaster force-stopped); restarted; `after-restart` | PASS — job rowVersion 12, 13 events, 3 estimates (ids, statuses, content hashes) identical; customer link and stored photo bytes (SHA-256) still served |
| Clear recovery after interrupted photo upload | e2e: bytes uploaded, metadata call skipped → `preparePhotoUpload` answers `alreadyStored`; truncated body refused by storage → `uploadMissing`; wrong bytes → `uploadRejected` and file deleted → fresh upload description. Outbox tests: upload ok + register fails → only registration repeated (1 upload); app killed between the two → resumes at registration | PASS (after fixing a bug the e2e found, below) |
| Offline on a **physical phone** (2026-10-11) | Samsung SM-A366E, Android 16, over the public ngrok link. The PC uses this phone's hotspot, so instead of airplane mode only FixWitness was cut off (`deploy/app-network.ps1 off`, Android per-app firewall) while phone, hotspot and PC stayed online. Note + condition checklist captured offline ("Waiting to send · No connection to the server"); app force-stopped and relaunched still blocked ("Offline. 2 item(s) saved on this phone"); network restored at 12:21:05; server logged JWT refresh (token had expired over 4 days) then `addNote` and `saveCondition` at 12:21:15. Earlier (10-07) on the same phone: sign-up, shop creation, check-in, rear-camera photo upload verified server-side | PASS |
| Customer approval on a **physical phone** (2026-10-11) | In the shop app on the Samsung: estimate v1 issued (₹3,200.00 + ₹400.50 = ₹3,600.50), customer link created and copied. Link opened in the phone's Chrome over the public ngrok address (ngrok warning page once; `main.dart.js` took 27 s over mobile data). Box ticked, approved as "Test Customer": `POST /customer/approve` 200; page shows "The customer approved v1 (₹3,600.50). This work is authorized." Shop app after reload: v1 "Approved by customer", History entry "Customer approved estimate v1 (₹3,600.50), signed as "Test Customer"" marked as a customer action. Screenshots `docs/evidence/phone_*.png` | PASS |
| Pending / syncing / failed / confirmed states | Android: "Waiting to send", "Sending…", "Saved on server" per item, banner and badge counts; web: same with server stopped/restarted. Failed state + reason covered by outbox test | PASS |
| Online-only actions offline | Android, airplane mode: "Issue estimate" disabled (`enabled=false` in the UI tree), banner "Offline: showing the copy saved on this phone" | PASS |
| Money in integer minor units | Server computes totals from lines; editor parses "4,250.50" → 425050 without floating point; UI total ₹4,750.00 exact | PASS |
| Device passcodes not stored | Notes/fault/checklist text matching passcode patterns refused server-side; "PIN connector loose" allowed | PASS |
| Live updates reach only the right shop | e2e over HTTP + websocket: a second signed-in device of the shop received "Customer approved estimate v1." 25 ms after the customer's approve call; another shop's stream received nothing. Web app (2026-10-11): customer approvals sent from another tab and from the API turned the row to "Approved" with no reload and showed "Job #4: Customer approved estimate v1.". Server test: a technician's `shop.watch()` stream receives "Customer approved estimate v1." (marked as a customer action) and "Note added by Ravi." in order; a job created by another shop is not received | PASS |
| Technician invites | Web app: owner menu → "Invite a technician" showed a code with its 24 h expiry; a second account chose "Join with a code", typed it in lower case and landed on the shop's job list as a technician, whose menu has no invite option. e2e: join, technician sees the shop's jobs, technician cannot invite. Server tests: join with the owner's code (case-insensitive) gives a technician who can open the shop's jobs; second use, expired and made-up codes refused (`inviteInvalid`); technicians cannot invite; a member of one shop cannot join another | PASS |
| Orphan photo bytes cleaned up | Server test: an upload never registered is deleted by the sweep once its grant is past the grace period; registered evidence in the same job is kept; young grants untouched | PASS |
| **Live on Serverpod Cloud, physical phone** (2026-10-14) | Release APK (`SERVER_URL` = Cloud API) on the Samsung SM-A366E, customer pages in the phone's Chrome. Shop app with networking cut for the app only: check-in, condition checklist, camera photo and a note saved offline ("Offline. 3 item(s) saved on this phone"); network restored, all sent within 8 s and shown from the server. Estimate v1 → customer link (QR) → customer page; v1 ticked, shop issued v2 (+ display cable, with reason), customer pressed Approve on v1 → "You were looking at version 1, but the shop has since issued version 2. Your decision was not recorded" with the change summary; v2 approved. History on the shop side lists the refused decision and the signed approval. Link revoked → `linkRevoked`. Made-up token → `linkInvalid`; shop call without sign-in → 401 | PASS (screens in `docs/screenshots/`, recording in the demo video) |
| Secrets not in source control | `passwords.yaml`, demo credentials, web build, e2e artifacts gitignored; `git ls-files` checked | PASS |

Commands and counts from the last runs: `dart test` (server) **33/33**; `flutter test` **11/11** (offline queue + job cache);
`dart run bin/e2e.dart` **42/42** (2026-10-11, includes live updates and invites; run against a throwaway database, dropped afterwards); earlier `--phase before-restart` **35/35**, `--phase after-restart` **2/2**;
`dart analyze` / `flutter analyze`: no issues.

### Bugs found by verification and fixed

1. **Embedded PostgreSQL would not start in this environment.** The Claude desktop app's packaged
   process redirects `%LOCALAPPDATA%` writes, so Serverpod's process-identity check compared two
   different paths. Workaround: `SERVERPOD_PG_CACHE_DIR` outside AppData. Not a FixWitness bug.
2. **Bytes uploaded before a failed registration were not recognised** (e2e). Database storage only
   reports verified files; `preparePhotoUpload` now verifies first, so the device is not asked to
   upload again.
3. **Customer page lost its token on refresh** (browser). Flutter rewrote the URL to `/`; the route
   name now carries `#/r/<token>`.
4. **Money shown two ways** ("INR 7,700.00" from server text, "₹7,700.00" in the app). Unified.
5. **Job screen did not refresh when queued evidence was confirmed** (browser). Fixed: it reloads
   when this job's queued items are confirmed.
6. **A hung request blocked the whole offline queue** (Android emulator). The photo upload URL
   pointed at the server's configured public host (`localhost`), which on the device is the device
   itself; the request never answered, the outbox had no timeout, and the item sat on "Sending…"
   for minutes. Fixed: every outbox call has a timeout (30 s, uploads 2 min) and a timeout is
   treated as "no connection" (stays pending, retried, safe because of operation ids). New
   regression test: an upload that never answers. On the device, the stuck item was left marked
   `syncing` when the process was killed; after installing the fix over the app's data it was reset
   to pending on start-up and sent (attempts 2), so recovery of an interrupted upload was also
   observed on the device.
7. **Development server advertised `localhost`** to devices (upload and photo URLs). For phones and
   emulators run it with `SERVERPOD_API_SERVER_PUBLIC_HOST` / `SERVERPOD_WEB_SERVER_PUBLIC_HOST` set to
   the PC's LAN IP (README). In production these are the real domain.
8. **The server crashed at start-up on Serverpod Cloud** (first deploy, 2026-10-14). Cloud's
   Starter plan switches future calls off (`SERVERPOD_FUTURE_CALL_ENABLED` "is managed by your
   project plan and can't be set"), so scheduling the hourly sweep threw `Bad state: FutureCalls
   is not initialized` and the rollout failed after 10 minutes of restarts. Fixed: the server
   checks `futureCall.enabled` and starts without the sweep when future calls are off.
9. **The customer saw only the first condition check** (phone run on Cloud). A correction saved a
   minute later at the counter was visible to the shop ("2 checks on record") but not to the
   customer. The first report still leads ("when you handed it in"), and every later check now
   follows it with its own time. Server test extended.
10. **The shop app missed a customer's approval made while it was in the background** (phone run).
    The job screen still said "waiting for customer approval" until a manual reload. On resume the
    job screen reloads and the live stream is reopened at once; checked on the phone: approving in
    Chrome and switching back showed "The customer approved v1" with no reload.

## Data state (2026-10-11)

Test data removed from the development database with a one-off SQL script (one
transaction, after a `pg_dump` backup that was itself deleted afterwards at the owner's request):
- 4 test accounts and their shops with all jobs, estimates, decisions, links, notes, checklists,
  photo records and history (ravi.fixpoint@, e2e.owner.a@, e2e.owner.b@, demo.shop@example.com);
- the TEST JOB #1 in the owner's real shop (account kept; job numbering reset to #1);
- 5 stored photo files and pending upload/download grants; development request logs.
Verified afterwards: 1 account, 1 shop, 0 jobs/estimates/photos/notes/events/stored files.
Also cleared: the phone's sent-item receipts (new "Clear sent items" action), the dev mailbox file,
e2e run files, the emulator's user data (AVD definition kept). `bin/demo.dart seed` recreates the
demo shop when needed. Screenshots in `docs/evidence/` are kept as verification records.

Bugs found during the cleanup and fixed: the offline job cache never dropped jobs the server no
longer lists (deleted jobs would show offline as ghosts); sent queue items could only age out
after 24 h. Both have tests (`test/job_cache_test.dart`, `outbox_test.dart`).

## Unresolved problems / not verified

- **Android verified on an emulator and on a physical phone** (camera photo and offline queue on
  a Samsung SM-A366E). Earlier note kept for history: Emulator: Pixel 7 profile, Android 16
  (API 36) Google APIs x86_64 image, headless, installed with the Android command-line tools.
  The photo came from the gallery (a synthetic test image), not the camera app; camera capture
  itself was not exercised. Build warning to track: `flutter_web_auth_2` (pulled in by the
  Serverpod auth UI) still applies the Kotlin Gradle Plugin, which future Flutter versions reject.
- The outbox's `attempts` counter also counts offline retries (29 while in airplane mode); it is
  informational only.
- **Deployed on Serverpod Cloud** (Starter plan): https://fixwitness.serverpod.space/, API
  https://fixwitness.api.serverpod.space/. The plan switches future calls off, so the hourly
  orphan-upload sweep does not run there (it is covered by a server test on a real server).
- **Customer page load time (fixed 2026-10-11).** It was 27 s for `main.dart.js` on the phone:
  3.49 MB sent uncompressed, crossing the phone's mobile link twice because the PC uses its hotspot.
  Now: the shop app is a deferred chunk (customer bundle 2.95 MB, shop-only part 553 KB loaded
  only by the shop), and the server serves gzipped copies written by `tool/precompress_web.dart`
  (`lib/src/web/precompressed.dart`, ETag + 304 on repeat visits, plain file for non-gzip
  clients). Measured on the phone over mobile data: `main.dart.js` 864,748 bytes gzipped in
  0.4 s (was 27.5 s); link opened to customer data loading in about 5 s, page drawn by about
  7 s. A plain-HTML loading screen shows before Flutter starts instead of a white page.
- **Customer link is a bearer credential.** Anyone holding the link can approve. Mitigations in
  place: 256-bit token stored only as a hash, token kept in the URL fragment (never sent to the
  server in requests or logs), 1–30 day expiry, revocation, refusal of signed-in shop sessions,
  IP + user agent recorded with each decision. A shop employee with the link in a private window
  could still approve; the audit trail is the only control for that.
- **Web shop app queue is in memory** (lost on reload). Offline capture is an Android feature;
  the web build says so in the sync queue.
- Production runs on Serverpod Cloud (managed PostgreSQL, private storage, Cloud email, TLS on
  `*.serverpod.space`). Self-hosting elsewhere is documented in the README but not exercised.
- Live updates and the QR sheet were exercised on the Android build (2026-10-14); technician
  invites only in the web app.

## Next step

Submission (2026-10-14): public repository, Cloud deployment, APK release
(https://github.com/professor-200629/fixwitness/releases/tag/v1.0.0) and demo video.
