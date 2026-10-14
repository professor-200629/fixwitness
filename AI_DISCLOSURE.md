# AI tool disclosure

FixWitness was built with an AI coding agent. This file says which tool was used, what it did,
what the developer did, and how the AI's output was checked.

## Tool

- **Claude Code** (Anthropic), in the Claude desktop app, with the **Claude Opus 5.5** model.
- The **official Serverpod agent skills** (`serverpod-*`, installed by `serverpod create`) and the
  Serverpod 4.0.4 documentation (`docs.serverpod.dev/llms.txt`) were given to the agent as
  references.

## What the AI did

- Wrote most of the source code: the Serverpod models, endpoints and business rules, the
  migrations, the Flutter shop app and customer page, the offline outbox, and the scripts in
  `deploy/` and `fixwitness_e2e/`.
- Wrote the tests (server integration tests, app tests, the HTTP end-to-end harness) and the
  documentation (`README.md`, `STATUS.md`, `docs/`).
- Ran the verification and fixed what it found: test runs, an Android emulator offline run, and
  the physical-phone runs driven over `adb`. It also generated the app icon with a script
  (`tool/make_icon.ps1`).

## What the developer did

- Defined the product and wrote the specification: the problem (estimate and condition disputes
  in small phone-repair shops), the required correctness rules, the offline behaviour, the
  security rules and the scope limits.
- Made the decisions during the build: what to verify on real hardware, the public demo setup,
  and what to add for the hackathon.
- Did the physical-device work: connected and tested on their own Android phone, created
  accounts, and approved the account sign-ins the agent cannot do itself.
- Reviewed the results and the verification evidence.

## How the AI's output was checked

Nothing here is accepted on the agent's word. The checks are in the repository and run in CI:

- 33 server integration tests against a real Serverpod server and PostgreSQL. They cover outdated
  approvals, concurrent estimate changes, duplicate retries, access across shops, live updates,
  invites and the upload sweep.
- 11 app tests for the offline queue and job cache, on real SQLite.
- A 42-check end-to-end harness over HTTP and websockets, plus a persistence check across a
  server restart.
- Runs on an Android emulator and a physical Android phone. Their results and screenshots are in
  `STATUS.md` and `docs/evidence/`.

Bugs that verification found in AI-written code are listed in `STATUS.md` ("Bugs found by
verification and fixed").

## AI inside the product

None. FixWitness makes no model calls and does no automatic diagnosis or pricing. Every estimate
is written by a person, and every approval is given by a person.
