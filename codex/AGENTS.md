# Agent Harness — Codex Instructions

Codex doesn't have Claude Code's persistent subagents, so the three harness
roles here are separate `codex exec` invocations against the same `.harness/`
files, run in sequence by `scripts/orchestrate.sh`. Each invocation reads
`codex/prompts/<role>.md` as its instructions.

State lives entirely in `.harness/` inside the target project repo:

- `.harness/project-type.txt` — set by the planner role
- `.harness/spec.md` — the build spec
- `.harness/criteria.md` — the active grading profile, copied from this
  harness repo's `criteria/<project-type>.md` (falls back to
  `criteria/_shared-core.md`)
- `.harness/sprints/sprint-N-contract.md` / `sprint-N-review-report.md` — per-unit
  contracts and review results

## Working agreements

- Never skip straight to the generator role on a repo with no
  `.harness/spec.md` — run the planner role first.
- The evaluator role is a separate, skeptical pass. It does not get to see
  itself as "the same agent that just built this" — treat every finding from
  the generator role's self-check as a starting hypothesis to verify, not a
  fact to trust.
- Always run this project's own build/lint/test commands before reporting a
  unit as done.
- Use git. Commit at meaningful checkpoints.

See `criteria/_shared-core.md` and the project-type file in this harness repo
for the standards. Read `prompts/<role>.md` for the specific role
instructions for the invocation you're running.
