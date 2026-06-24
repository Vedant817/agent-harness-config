# agent-harness

A portable planner → generator → evaluator harness for Claude Code and
Codex CLI, built around the architecture described in Anthropic's
["Harness design for long-running application development"](https://www.anthropic.com/engineering/harness-design-long-running-apps).
Project-type-agnostic: the `criteria/` profiles are what adapt it to a web
app vs. a backend service vs. a CLI tool vs. devops/infra — the roles and
process stay the same.

Push this repo to your own private GitHub, then run the bootstrap script on
any machine you use Claude Code or Codex on. Both tools end up wired to the
exact same harness.

## One-time setup per machine

```bash
git clone https://github.com/<you>/agent-harness.git ~/agent-harness
cd ~/agent-harness
./scripts/bootstrap.sh <you>/agent-harness
```

This does two things:
1. **Claude Code** — registers this repo as a plugin marketplace and installs
   the `agent-harness` plugin at **user scope**, so it's active in every
   project on that machine, not just one repo.
2. **Codex** — points `CODEX_HOME` at this repo's `codex/` directory, so
   `AGENTS.md`, `config.toml` profiles, and prompts are identical everywhere
   `codex` runs from that machine.

Re-running the script is safe; it's idempotent.

## Using it in a project (Claude Code)

Inside any project, just start with the planner subagent:

> Use the planner agent to spec out: <your 1-4 sentence prompt>

Then proceed unit by unit, always invoking the evaluator subagent to review
after the generator hands off a unit before moving to the next one — the subagent
prompts say to negotiate a contract first, but you (or a short slash command
you add later) drive the sequencing between agents.

## Using it in a project (Codex)

```bash
./scripts/orchestrate.sh /path/to/project "<your 1-4 sentence prompt>"
```

This runs the planner once, then loops generator → evaluator for review per unit,
pausing between rounds so you can stop or course-correct.

## Adapting it as models improve

Per the source article: every piece here encodes an assumption about what
the current model can't do reliably alone. Revisit this repo when you
upgrade models —

- If contract negotiation rarely changes anything, consider letting the
  generator self-scope without it.
- If the evaluator rarely finds real issues the generator's own self-check
  missed, consider moving review to a single pass at the end of a build instead
  of per-unit.
- If you never see premature wrap-up behavior from a model, you don't need
  anything beyond normal compaction — don't add context-reset machinery you
  don't need.

Strip, don't just add.

## Notes / things to verify on your machine

- Claude Code's plugin CLI and hook schema move fairly often — if
  `claude plugin marketplace add` / `claude plugin install` don't match what
  your installed version expects, use the in-session `/plugin` commands
  instead and check the current docs.
- Codex's `config.toml` profile fields in `codex/config.toml` are written
  against the schema documented at the time this repo was created — confirm
  against `codex --help` / the current config reference before relying on
  them, especially `approval_policy` and `sandbox_mode` naming.
- Don't commit secrets into this repo — plugins and AGENTS.md content run
  with your full local privileges, including on every machine you bootstrap.
- `criteria/` is the thing actually worth iterating on over time.
