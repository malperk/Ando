# Ando 2.0.0

A lightweight iOS downloader for images and JSON, modernized for Swift 6. The original `imageView.ando.url` and `Ando(type: .json)` callback APIs remain available.

## Requirements

- iOS 15+
- Xcode 16+ / Swift 6+
- Swift Package Manager (recommended)

In Xcode, add the package using `https://github.com/malperk/Ando` and select the `Ando` library. Git tags for releases follow `vMAJOR.MINOR.PATCH` when published.

## UIImageView example

```swift
imageView.ando.url = "https://example.com/photo.jpg"
// Cancel when a view is no longer needed:
imageView.ando.cancel()
```

## JSON callback example

```swift
let downloader = Ando(type: .json)
downloader.callback = { response in
    if let error = response.error { print(error); return }
    if let json = response.item as? [String: Any] { print(json) }
}
downloader.url = "https://example.com/data.json"
```

All callback invocations run on the main actor. Setting `url` cancels any preceding request. HTTP errors, invalid URLs, and decoding failures are reported via `response.error`. Cancellation is silent.

## Swift concurrency

```swift
@MainActor
func loadJSON() async throws -> [String: Any] {
    let downloader = Ando(type: .json)
    let response = try await downloader.load(from: URL(string: "https://example.com/data.json")!)
    return response.item as? [String: Any] ?? [:]
}
```

`load(from:)` is an independently cancellable async operation when its calling task is cancelled. The `cancel()` method cancels only downloads initiated by setting the `url` property.

## Cache

`ACache.shared` is an in-memory, thread-safe FIFO cache with a default capacity of **100 items** (not a byte limit). Entries are keyed by URL and requested item type. Adjust or reset it with:

```swift
ACache.shared.setMaxLength(200)
ACache.shared.clear()
// Legacy spelling also works:
ACache.shared.setMaxLenght(200)
```

## Development

```bash
swift test
```

Package tests use a mock URL protocol and do not depend on external HTTP endpoints. The old `Example/` UIKit demo remains an archival 2017 example and uses retired third-party endpoints; it is not part of the supported v2 distribution.

## License

GPL-3.0 (see [LICENSE](LICENSE)). Check GPL obligations before integrating into closed-source apps.
