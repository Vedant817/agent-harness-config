---
name: sprint-contract
description: Use when starting a new unit of work in the harness (a sprint, module, service, or stage) to negotiate and record what "done" means before any implementation begins. Applies to both the Generator proposing a contract and the Evaluator reviewing one.
---

A contract lives at `.harness/sprints/sprint-N-contract.md` and has two sections:

```markdown
## Scope
What will be built in this unit, in plain terms. One paragraph, not a wall of detail.

## Verification
A numbered list of specific, checkable behaviors. Each one should be answerable as
pass/fail by someone who didn't write the code. Bad: "the editor works." Good:
"user can click-drag to select a rectangular region and the selection highlight
follows the drag in real time."
```

Negotiation protocol:
1. Generator writes the first draft.
2. Evaluator appends a `## Evaluator notes` section to the same file — approve as-is, or list specific changes needed.
3. Generator revises if needed. Repeat until the Evaluator's notes section says `AGREED`.
4. Only after `AGREED` does the Generator start writing code.

Keep contracts short enough to read in under a minute — a contract that's harder to read than the unit it describes has failed its own purpose.
