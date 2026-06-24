# DevOps / Infra Criteria
(extends `_shared-core.md`)

- **Idempotency:** Running this twice produces the same end state as running it once — no duplicated resources, no drift from re-application.
- **Rollback safety:** Is there an actual, verified path back to the previous state if this change goes wrong in production? "We'd figure it out" is a fail.
- **Secret handling:** No credentials, tokens, or keys committed in plaintext anywhere — config, scripts, CI definitions, or commit history.
- **Blast radius:** Does the change affect only what it's scoped to, or could it touch shared/unrelated resources? Check plan/diff output, not just the script's intent.
