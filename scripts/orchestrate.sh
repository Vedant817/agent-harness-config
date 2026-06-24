#!/usr/bin/env bash
# Usage: orchestrate.sh /path/to/target/project "<one-line prompt for a new build>"
# Run from anywhere; CODEX_HOME should already point at this repo's codex/ dir
# (see bootstrap.sh) so config.toml profiles and MCP servers are picked up.
set -euo pipefail

TARGET_DIR="${1:?target project directory required}"
PROMPT="${2:-}"
HARNESS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$TARGET_DIR"
mkdir -p .harness/sprints

if [ ! -f .harness/spec.md ]; then
  echo "== Planner =="
  codex exec --profile planner --cd "$TARGET_DIR" \
    "$(cat "$HARNESS_DIR/codex/prompts/planner.md")

Prompt for this build: $PROMPT"
fi

# Loop: generator proposes/builds, evaluator reviews, until approved
# or you hit a sane iteration cap. This is intentionally simple — swap in
# real pass/fail parsing once you've used it a few times
# and know what your reports actually look like.
MAX_ROUNDS=10
for i in $(seq 1 $MAX_ROUNDS); do
  echo "== Generator (round $i) =="
  codex exec --profile generator --cd "$TARGET_DIR" \
    "$(cat "$HARNESS_DIR/codex/prompts/generator.md")"

  echo "== Evaluator (round $i) =="
  codex exec --profile evaluator --cd "$TARGET_DIR" \
    "$(cat "$HARNESS_DIR/codex/prompts/evaluator.md")"

  echo "Round $i complete. Check .harness/sprints/ for the latest review report."
  read -p "Continue to next unit/round? [Y/n] " ans
  [ "$ans" = "n" ] && break
done
