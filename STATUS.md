# FixWitness — project status

_Last updated 2026-10-07._

## Completed

| Slice | What exists |
|---|---|
| Tooling | Flutter 3.47.6, Serverpod CLI 4.0.4, project from `serverpod create` with the official Serverpod agent skills and MCP config. Docs read from docs.serverpod.dev (`llms.txt`) for 4.0.4. |
| 1. Online workflow | Server models + endpoints for shops, jobs, condition checklists, photos, notes, versioned estimates, customer links, decisions, collection, history. Shop app (Android/web) and customer review page (web) on the generated client. |
| 2. Correctness | 25 server integration tests (real server + embedded PostgreSQL), 35-check HTTP end-to-end harness (`fixwitness_e2e`). |
| 3. Offline | Durable outbox + job cache on Serverpod client-side SQLite (`database: client`, stable feature; experimental `database: sync` not used). 7 tests on real SQLite. |
| 4. Customer UX / history | Progress bar, server-written authorization statement, "changed since vN" diff, exact-version approval with typed name, collection confirmation, full history on both sides, localised outdated-approval message, token kept in the URL so refresh works. |

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
| Pending / syncing / failed / confirmed states | Android: "Waiting to send", "Sending…", "Saved on server" per item, banner and badge counts; web: same with server stopped/restarted. Failed state + reason covered by outbox test | PASS |
| Online-only actions offline | Android, airplane mode: "Issue estimate" disabled (`enabled=false` in the UI tree), banner "Offline: showing the copy saved on this phone" | PASS |
| Money in integer minor units | Server computes totals from lines; editor parses "4,250.50" → 425050 without floating point; UI total ₹4,750.00 exact | PASS |
| Device passcodes not stored | Notes/fault/checklist text matching passcode patterns refused server-side; "PIN connector loose" allowed | PASS |
| Secrets not in source control | `passwords.yaml`, demo credentials, web build, e2e artifacts gitignored; `git ls-files` checked | PASS |

Commands and counts from the last runs: `dart test` (server) **25/25**; `flutter test test/outbox_test.dart` **8/8**;
`dart run bin/e2e.dart --phase before-restart` **35/35**, `--phase after-restart` **2/2**;
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

## Unresolved problems / not verified

- **Android verified on an emulator and on a physical phone** (camera photo and offline queue on
  a Samsung SM-A366E). Earlier note kept for history: Emulator: Pixel 7 profile, Android 16
  (API 36) Google APIs x86_64 image, headless, installed with the Android command-line tools.
  The photo came from the gallery (a synthetic test image), not the camera app; camera capture
  itself was not exercised. Build warning to track: `flutter_web_auth_2` (pulled in by the
  Serverpod auth UI) still applies the Kotlin Gradle Plugin, which future Flutter versions reject.
- The outbox's `attempts` counter also counts offline retries (29 while in airplane mode); it is
  informational only.
- **Not deployed publicly.** Serverpod Cloud needs an account created by the owner
  (console.serverpod.dev) and `serverpod cloud launch`; ngrok is installed but has no auth token.
  The demo currently runs on this PC (http://localhost:8082).
- **Customer link is a bearer credential.** Anyone holding the link can approve. Mitigations in
  place: 256-bit token stored only as a hash, token kept in the URL fragment (never sent to the
  server in requests or logs), 1–30 day expiry, revocation, refusal of signed-in shop sessions,
  IP + user agent recorded with each decision. A shop employee with the link in a private window
  could still approve; the audit trail is the only control for that.
- **Web shop app queue is in memory** (lost on reload). Offline capture is an Android feature;
  the web build says so in the sync queue.
- **Unverified uploads are not garbage-collected.** Bytes uploaded but never registered expire with
  their upload entry in database storage; on S3/GCS they would remain. A cleanup job is not built.
- Production configuration (domain, TLS, external PostgreSQL, object storage, email provider) is
  documented but not set up.
- One staff member per account; inviting technicians to a shop has no UI yet (the model supports
  `technician` members; tests insert one directly).

## Next step

Decide the deployment target (Serverpod Cloud account, or a temporary tunnel from this PC). Then
repeat DEMO.md step 6 on a physical phone with the camera.
