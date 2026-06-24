# Shared Core Criteria

Every project-type profile in this folder extends these four. Project-type files add domain-specific criteria on top — they don't replace these.

- **Spec coverage:** Does the finished unit do what the contract said it would, completely — not a partial or stubbed version presented as done?
- **Code quality & architecture:** Is this maintainable by someone other than the agent that wrote it? Reasonable naming, no copy-pasted duplication where a shared abstraction was obviously called for, dependencies used sensibly.
- **Test / edge-case coverage:** Beyond the happy path — what happens with bad input, empty state, concurrent access, or failure of a dependency? Most reasonable implementations should pass this by default; failing means an obvious case was skipped entirely.
- **Operability:** Can someone who isn't the Generator debug this when it breaks? Errors surface with useful messages, failures don't fail silently, logging exists where it matters.

Weight spec coverage and edge-case coverage more heavily than code-quality polish — a unit that's narrowly correct but ugly is more salvageable than one that's polished but doesn't actually do the thing.
