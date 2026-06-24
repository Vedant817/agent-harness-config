# Backend / API Service Criteria
(extends `_shared-core.md`)

- **Contract correctness:** Request/response shapes match what was specified (or what's already established elsewhere in the API) — status codes, error payloads, pagination, auth behavior included, not just the 200 path.
- **Failure handling:** What happens when a downstream dependency (DB, queue, third-party API) is slow, errors, or returns malformed data? Does the service degrade predictably or does it throw an unhandled exception?
- **Data integrity:** Are writes safe under retries/concurrent requests? Is there an obvious way for the data to end up inconsistent (partial writes, missing transactions, race conditions on shared state)?
- **Backward compatibility / versioning:** If this changes an existing contract, is the change additive/non-breaking, or does it silently break existing consumers?
