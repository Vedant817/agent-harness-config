#!/usr/bin/env bash
# Runs whatever check command this project actually defines, so the Generator
# gets fast feedback without the harness hardcoding a stack.
# Reads JSON on stdin per the Claude Code hooks contract; ignored here since
# we just need "something changed," not which file.
set -e
cd "${CLAUDE_PROJECT_DIR:-.}"

if [ -f package.json ] && grep -q '"test"' package.json; then
  npm test --silent 2>&1 | tail -20
elif [ -f pyproject.toml ] || [ -f requirements.txt ]; then
  python -m pytest -q 2>&1 | tail -20 || true
elif [ -f Makefile ] && grep -q '^test:' Makefile; then
  make test 2>&1 | tail -20
else
  echo "No recognized test command for this project — skipping auto-check."
fi
