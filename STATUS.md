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
| App restart while offline | outbox test: queue captured offline (job + condition + note + photo), SQLite session closed and reopened, then synced; mid-flight `syncing` op recovered on restart | PASS on desktop SQLite. **Not run on an Android device** (see unresolved) |
| Unauthorized job access | e2e + server tests: other shop (get, note, estimate, start, link, photo URL, upload), unauthenticated, signed-in user without shop, link used against another job's estimate, made-up / revoked / expired tokens, shop account calling customer approval | PASS — `notFound` for other shops (existence not revealed), 401 unauthenticated, `forbidden`, `linkInvalid` / `linkRevoked` / `linkExpired`, `shopAccountCannotApprove` |
| Database persistence after server restart | e2e `before-restart`; server and embedded PostgreSQL killed (postmaster force-stopped); restarted; `after-restart` | PASS — job rowVersion 12, 13 events, 3 estimates (ids, statuses, content hashes) identical; customer link and stored photo bytes (SHA-256) still served |
| Clear recovery after interrupted photo upload | e2e: bytes uploaded, metadata call skipped → `preparePhotoUpload` answers `alreadyStored`; truncated body refused by storage → `uploadMissing`; wrong bytes → `uploadRejected` and file deleted → fresh upload description. Outbox tests: upload ok + register fails → only registration repeated (1 upload); app killed between the two → resumes at registration | PASS (after fixing a bug the e2e found, below) |
| Pending / syncing / failed / confirmed states | Browser (web shop app): note added with server stopped → "Waiting to send · No connection to the server"; server restarted → sent and shown on the server. Failed state + reason covered by outbox test | PASS (web). Android UI not observed |
| Money in integer minor units | Server computes totals from lines; editor parses "4,250.50" → 425050 without floating point; UI total ₹4,750.00 exact | PASS |
| Device passcodes not stored | Notes/fault/checklist text matching passcode patterns refused server-side; "PIN connector loose" allowed | PASS |
| Secrets not in source control | `passwords.yaml`, demo credentials, web build, e2e artifacts gitignored; `git ls-files` checked | PASS |

Commands and counts from the last runs: `dart test` (server) **25/25**; `flutter test test/outbox_test.dart` **7/7**;
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

## Unresolved problems / not verified

- **No on-device Android run.** The debug APK build is reported below; there is no Android device
  attached and the only emulator system image on this machine is an incomplete download (empty
  folder), and `cmdline-tools` is missing. Camera capture, Android file storage and offline
  behaviour on a phone have not been observed.
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

Decide the deployment target (Serverpod Cloud account, or a temporary tunnel from this PC), then
run the Android app on a real phone or a fully installed emulator and walk through DEMO.md step 6
(offline capture, force-stop, reconnect).
