# CLI Tool / Library Criteria
(extends `_shared-core.md`)

- **Usability without docs:** Does `--help` (or the README quickstart) actually let a new user accomplish the core task without reading source code?
- **Input robustness:** Bad flags, missing required arguments, malformed input files — does it fail with a clear message and a sane exit code, not a stack trace?
- **Cross-environment behavior:** Does it behave consistently across the platforms/shells it claims to support, or does it quietly assume one environment?
- **API stability (for libraries):** Are public function signatures and exported types intentional and documented, not incidental leakage of internal implementation details?
