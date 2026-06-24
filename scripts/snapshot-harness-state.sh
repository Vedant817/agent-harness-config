#!/usr/bin/env bash
# Snapshots .harness/ before a context compaction event, purely as a safety
# net — the harness is already designed to hand off via files, this just
# guards against losing in-progress notes that hadn't been written yet.
set -e
cd "${CLAUDE_PROJECT_DIR:-.}"
if [ -d .harness ]; then
  ts=$(date +%Y%m%d-%H%M%S)
  mkdir -p .harness/.snapshots
  cp -r .harness/spec.md .harness/sprints .harness/.snapshots/"$ts" 2>/dev/null || true
fi
