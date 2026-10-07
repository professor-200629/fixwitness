# FixWitness — implementation plan

Written 2026-10-07 after inspecting the tooling and reading the Serverpod 4.0.4 docs
(docs.serverpod.dev, `llms.txt`) and the official Serverpod agent skills that
`serverpod create` installed under `.claude/skills/`.

## Stack (verified, not assumed)

| Piece | Version | Notes |
|---|---|---|
| Flutter | 3.47.6 stable (Dart 3.13.5) | installed to `C:\dev\tools\flutter` |
| Serverpod CLI + packages | 4.0.4 | `dart install serverpod_cli` |
| Database (dev/test) | embedded PostgreSQL 16.13 | Serverpod 4 feature, no Docker |
| Client cache | Serverpod client-side SQLite (`database: client`) | stable feature; the experimental `database: sync` is **not** used |
| Auth | `serverpod_auth_idp` email + JWT | scaffolded |
| File storage | `DatabaseCloudStorage('private')` | private only; signed temporary URLs |

## Domain model (server, PostgreSQL)

- `Shop`, `ShopMember` — a signed-in user belongs to exactly one shop. All job queries are scoped by shop.
- `RepairJob` — per-shop `jobNumber`, `status`, `rowVersion`, `eventSeq`, `currentEstimateId`, `authorizedEstimateId`.
- `Estimate` — immutable once issued. `versionNumber` unique per job, `lines` (integer minor units), `totalMinor`, `contentHash` (SHA-256 of the canonical content). Status: issued → superseded / approved / declined.
- `Approval` — references `estimateId` + `versionNumber` + `contentHash`, typed customer name, link id, IP, user agent.
- `CustomerLink` — random 256-bit token, only its SHA-256 stored; single job; `expiresAt`; `revokedAt`.
- `ConditionReport` — checklist items for intake condition.
- `EvidencePhoto` — private storage path derived on the server, sha256, size, content type, stage, `clientOpId` (unique).
- `JobNote` — `clientOpId` (unique), customer-visible flag.
- `JobEvent` — append-only history, `seq` unique per job, written in the same transaction as every state change.
- `ProcessedOperation` — opId → stored result, for idempotent retries.

## State machine (enforced on the server)

```
checkedIn ──issueEstimate──▶ awaitingApproval ──approve(exact version)──▶ approved ──startWork──▶ inProgress
                                 │  ▲    │                                   │                        │
                                 │  └────┴──issueEstimate (supersedes)◀──────┴────────────────────────┤
                                 └──decline──▶ declined ──issueEstimate──▶ awaitingApproval            │
                                                  │                                                   ▼
                                                  └──────────▶ collected ◀──acknowledgeCollection── completed
```

`completeRepair` requires the latest issued estimate to be approved. Every transition
locks the job row (`LockMode.forUpdate`) inside a transaction and appends a `JobEvent`
in the same transaction.

## Approval correctness

- Customer approval endpoint takes `token, estimateId, versionNumber, contentHash, typedName`.
- Rejected with `EstimateOutdatedException` (clear message naming both versions) if the estimate is not the job's current issued estimate.
- Rejected if the call carries a signed-in shop session (shop accounts cannot approve). No shop endpoint can approve.
- Residual risk (documented): the link is a bearer credential. Mitigations: hash-only storage, expiry, revocation, audit (IP/UA) shown in history.

## Offline (shop app)

- Client tables (`database: client`): `CachedJob` (JSON snapshot), `PendingOperation` (durable queue).
- Queued kinds: create job, add note, save checklist, add photo. Estimates, transitions, approvals are online-only.
- Every op has a UUID; the server deduplicates by opId (`ProcessedOperation` / unique `clientOpId`).
- Photo op stages: `captured → uploaded → registered`. The server's `preparePhotoUpload(opId)` answers "already stored" if the file exists, so an upload that succeeded before a metadata failure is not repeated.
- States shown: pending, syncing, failed (with reason, retry/discard), confirmed.

## Slices

1. Online workflow (server + shop app + customer web), deployed demo.
2. Correctness tests (server integration tests).
3. Offline capture and recovery (client SQLite queue + tests).
4. Customer experience and handover history polish.

Status and verification results live in `STATUS.md`.
