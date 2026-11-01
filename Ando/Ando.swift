import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Callbacks are always delivered on the main actor, including cache hits and failures.
public typealias CompletionBlock = @MainActor (AResponse) -> Void

/// A small, cancellable image/JSON downloader. `url` and `callback` retain the original API.
@MainActor
public final class Ando {
    public let type: AType
    private let session: URLSession
    private var task: Task<Void, Never>?
    private var generation: UInt64 = 0

    public var callback: CompletionBlock?

    /// Setting a URL cancels any previous request, including when the new URL is cached.
    public var url: String = "" {
        didSet { startDownload() }
    }

    public convenience init() {
        self.init(type: .image)
    }

    public convenience init(type: AType) {
        self.init(type: type, session: .shared)
    }

    /// Inject a custom session to configure timeouts or test via URLProtocol.
    public init(type: AType, session: URLSession) {
        self.type = type
        self.session = session
    }

    /// Cancels the `url` property's in-flight request. Does not cancel standalone `load` calls.
    public func cancel() {
        generation &+= 1
        task?.cancel()
        task = nil
    }

    /// Modern async API; uses a type-aware memory cache and validates HTTP status codes.
    public func load(from url: URL) async throws -> AResponse {
        guard let scheme = url.scheme?.lowercased(),
              (scheme == "https" || scheme == "http"),
              url.host != nil else {
            throw AError.error(code: .WrongURL, failureReason: "A valid HTTP(S) URL is required")
        }

        let cacheKey = "\(type.rawValue):\(url.absoluteString)"
        if let cached = ACache.shared.getItem(url: cacheKey) {
            try Task.checkCancellation()
            return AResponse(item: cached, type: type)
        }

        let (data, response) = try await session.data(from: url)
        try Task.checkCancellation()
        guard let http = response as? HTTPURLResponse else {
            throw AError.error(code: .ProcessResponseError, failureReason: "Not an HTTP response")
        }
        guard (200...299).contains(http.statusCode) else {
            throw AError.error(code: .InvalidHTTPStatus, failureReason: "HTTP \(http.statusCode)")
        }

        let item = try Item(type: type).get(data)
        try Task.checkCancellation()
        ACache.shared.addItem(url: cacheKey, item: item)
        return AResponse(item: item, type: type)
    }

    private func startDownload() {
        cancel()
        let requestedURL = url
        guard let parsed = URL(string: requestedURL),
              let scheme = parsed.scheme?.lowercased(),
              (scheme == "http" || scheme == "https"),
              parsed.host != nil else {
            callback?(AResponse(error: AError.error(code: .WrongURL, failureReason: "Invalid HTTP(S) URL: \(requestedURL)"), type: type))
            return
        }

        let requestGeneration = generation
        task = Task { [weak self] in
            guard let self else { return }
            do {
                let response = try await self.load(from: parsed)
                try Task.checkCancellation()
                guard self.generation == requestGeneration else { return }
                self.task = nil
                self.callback?(response)
            } catch {
                guard self.generation == requestGeneration else { return }
                self.task = nil
                guard !Task.isCancelled else { return }
                let nsError = error as NSError
                guard !(nsError.domain == NSURLErrorDomain && nsError.code == NSURLErrorCancelled) else { return }
                self.callback?(AResponse(error: nsError, type: self.type))
            }
        }
    }
}
