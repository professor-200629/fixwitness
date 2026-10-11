# FixWitness demonstration (about 8 minutes)

Setup once: server running in development mode (see README), web bundle built, and

```bash
cd fixwitness_e2e
set FW_DEMO_PASSWORD=<12+ chars with upper, lower, digit, symbol>   # PowerShell: $env:FW_DEMO_PASSWORD="..."
dart run bin/demo.dart seed
```

`seed` registers `demo.shop@example.com` (shop "Fix Point Mobiles"), checks in a Samsung Galaxy
A52 with a condition checklist, a placeholder photo (the app icon, captioned as a placeholder),
a customer-visible note and estimate v1 (₹5,000.00), and prints the customer link.

## 1. The shop's record (shop app, http://localhost:8082)

1. Sign in as the demo shop. The job list shows job #1 *Awaiting approval*.
2. Open it. **Overview**: the banner states what is authorized, written by the server:
   "Estimate v1 (₹5,000.00) is waiting for customer approval. No work is authorized yet."
   *Start repair* is not offered.
3. **Evidence**: checklist (screen damaged, touch not working, frame dented, biometrics not
   tested because the customer kept their passcode), photo, note.
4. Try adding a note "customer passcode 4821" → the sync queue marks it *Not accepted* with the
   server's reason (FixWitness does not store unlock codes); *Discard* removes it.

## 2. The customer's link (open the printed link in a private window)

1. Shop name, device, progress bar, the same authorization statement.
2. Condition at check-in with the photo, the shop's update, the full history.
3. Tick "I approve estimate version 1 for ₹5,000.00, exactly as shown above." **Do not press
   Approve yet.**

## 3. A revision arrives while the customer is deciding

```bash
dart run bin/demo.dart revise latest     # shop issues v2: + swollen battery ₹1,800
```

4. Press **Approve ₹5,000.00** on the customer page (still showing v1).
   → "You were looking at version 1, but the shop has since issued version 2. Your decision was
   not recorded." The page reloads to v2 with *Changed since version 1*: the shop's reason,
   "Added: Battery (₹1,800.00)", "Total up by ₹1,800.00 (was ₹5,000.00)".
5. Approve v2 with the typed name. The shop app (reload) shows v1 *Replaced before decision*,
   v2 *Approved by customer* with the typed name and time, and an *approval refused* entry in
   History.

## 4. Repair, a further revision, handover

6. Shop: *Start repair*. Issue revised estimate v3 (add "Charging port", reason "loose port").
   Overview now reads "Only the work in v2 (₹6,800.00) is authorized" and *Repair complete* is
   not offered until the customer approves v3.
7. Customer approves v3. Shop: *Repair complete*. Customer: *I have collected my device*.
8. History on both sides: every step in order, who did it (shop staff / customer / system).

## 5. Link control

9. Shop: *Customer link* → *Revoke*. Reload the customer page → "The shop has withdrawn this link."

## 6. Offline capture (Android phone or emulator)

Start the server with `SERVERPOD_API_SERVER_PUBLIC_HOST` and `SERVERPOD_WEB_SERVER_PUBLIC_HOST` set to
the PC's LAN IP (photo upload and download URLs use it), then
`flutter run -d <device> --dart-define=SERVER_URL=http://<PC-IP>:8080/` (emulator: `10.0.2.2` also works).

> **PC on the phone's hotspot?** Don't use airplane mode: it takes the PC (server, tunnel) offline
> too. Cut only FixWitness's network instead: `.\deploypp-network.ps1 off` (and `on` afterwards).
> It uses Android 13+'s per-app firewall over USB; the phone and hotspot stay online.

10. Airplane mode on (or `app-network.ps1 off`). *New job* → fill in → *Check in device*. The list shows it as *Waiting to
    send*; the banner says items are saved on the phone.
11. Open it → *Evidence* → take a photo, save a checklist, add a note. Each shows *Waiting to send*.
12. Swipe the app away (force stop) and reopen: the queue is still there (SQLite on the device).
13. Airplane mode off (or `app-network.ps1 on`). Within ~15 s (or *Send now* in the sync queue) the job is created, then its
    note, checklist and photo; each turns *Saved on server*. Approvals and estimates are never
    queued: their buttons say they need a connection.

Step 6 was run on an Android 16 emulator on 2026-10-07 (gallery photo, not camera); see STATUS.md
and the screenshots in `docs/evidence/`.
