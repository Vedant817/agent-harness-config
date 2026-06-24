#!/usr/bin/env bash
# Run once per machine after cloning this repo.
# Wires Claude Code (via the plugin marketplace) and Codex (via CODEX_HOME)
# to this exact harness, so both tools behave identically everywhere.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
GITHUB_SLUG="${1:?usage: bootstrap.sh <github-username>/<repo-name>}"

echo "== Claude Code: registering marketplace and installing plugin =="
# These are the non-interactive CLI equivalents of the in-session
# /plugin marketplace add and /plugin install commands. If your installed
# Claude Code version doesn't recognize them, run the slash-command versions
# inside a `claude` session instead — check `claude plugin --help` to confirm
# current syntax for your version.
claude plugin marketplace add "$GITHUB_SLUG" || true
claude plugin install "agent-harness@agent-harness-marketplace" --scope user

echo "== Codex: pointing CODEX_HOME at this repo's codex/ directory =="
SHELL_RC="$HOME/.bashrc"
[ -n "${ZSH_VERSION:-}" ] && SHELL_RC="$HOME/.zshrc"

LINE="export CODEX_HOME=\"$REPO_DIR/codex\""
if ! grep -qF "$LINE" "$SHELL_RC" 2>/dev/null; then
  echo "$LINE" >> "$SHELL_RC"
  echo "Added CODEX_HOME export to $SHELL_RC — restart your shell or 'source $SHELL_RC'."
else
  echo "CODEX_HOME export already present in $SHELL_RC."
fi

echo "Done. Verify with: claude plugin list   and   codex --version && echo \$CODEX_HOME"
