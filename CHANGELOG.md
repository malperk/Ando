# Changelog

## 2.0.0 — 2026-11-01

- Require Swift 6 and iOS 15+; introduce Swift Package Manager support.
- Preserve `Ando(type:)`, `callback`, `url`, `cancel()` and `UIImageView.ando` APIs on the main actor.
- Introduce `load(from:) async throws` for structured concurrency.
- Make request replacement safe across cancellation and cache hits; prevent stale completions from updating reused views.
- Validate HTTP(S) URLs and HTTP 2xx status codes before decoding.
- Fix FIFO cache off-by-one eviction, synchronization, zero-capacity handling and typed cache keys.
- Make callback delivery consistent on the main actor and add test injection via a custom URLSession.
- Add deterministic offline tests for caching, JSON decoding, HTTP failures and invalid URLs.

**Migration:** iOS 15 / Swift 6 are required. Callback execution is now main-actor isolated. The legacy UIKit demo is historical and not maintained as part of v2.
