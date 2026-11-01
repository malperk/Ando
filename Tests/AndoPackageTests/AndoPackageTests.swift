import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Testing
@testable import Ando

private final class MockURLProtocol: URLProtocol {
    private static let lock = NSLock()
    nonisolated(unsafe) private static var responseStatus = 200
    nonisolated(unsafe) private static var responseData = Data()

    static func configure(status: Int, body: Data) {
        lock.lock()
        defer { lock.unlock() }
        responseStatus = status
        responseData = body
    }

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    override func startLoading() {
        let (status, body): (Int, Data) = Self.lock.withLock {
            (Self.responseStatus, Self.responseData)
        }
        guard let url = request.url,
              let response = HTTPURLResponse(url: url, statusCode: status, httpVersion: "HTTP/1.1", headerFields: nil) else {
            client?.urlProtocol(self, didFailWithError: URLError(.badURL))
            return
        }
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        client?.urlProtocol(self, didLoad: body)
        client?.urlProtocolDidFinishLoading(self)
    }
    override func stopLoading() {}
}

@MainActor
@Suite(.serialized)
struct AndoPackageTests {
    private func makeSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }

    @Test func cacheLimitAndFIFO() {
        let cache = ACache()
        cache.setMaxLength(2)
        cache.addItem(url: "a", item: 1)
        cache.addItem(url: "b", item: 2)
        cache.addItem(url: "c", item: 3)
        #expect(cache.count == 2)
        #expect(cache.getItem(url: "a") == nil)
        #expect(cache.getItem(url: "b") as? Int == 2)
        #expect(cache.getItem(url: "c") as? Int == 3)
        cache.setMaxLenght(1)
        #expect(cache.count == 1)
        #expect(cache.getItem(url: "b") == nil)
        cache.setMaxLength(0)
        cache.addItem(url: "d", item: 4)
        #expect(cache.count == 0)
    }

    @Test func imageAndJSONAreSeparatedInCache() async throws {
        ACache.shared.clear()
        ACache.shared.setMaxLength(100)
        let jsonBody = Data(#"{"ok":true}"#.utf8)
        MockURLProtocol.configure(status: 200, body: jsonBody)
        let session = makeSession()
        let downloader = Ando(type: .json, session: session)
        let url = try #require(URL(string: "https://example.test/response"))
        let response = try await downloader.load(from: url)
        #expect(response.error == nil)
        #expect((response.item as? [String: Bool])?["ok"] == true)
        #expect(ACache.shared.count == 1)
        let cached = try await downloader.load(from: url)
        #expect((cached.item as? [String: Bool])?["ok"] == true)
        ACache.shared.clear()
    }

    @Test func rejectsHTTPFailures() async throws {
        ACache.shared.clear()
        MockURLProtocol.configure(status: 404, body: Data(#"{"message":"missing"}"#.utf8))
        let downloader = Ando(type: .json, session: makeSession())
        let url = try #require(URL(string: "https://example.test/missing"))
        do {
            _ = try await downloader.load(from: url)
            Issue.record("Expected HTTP error")
        } catch {
            let nsError = error as NSError
            #expect(nsError.domain == AError.Domain)
            #expect(nsError.code == AError.Code.InvalidHTTPStatus.rawValue)
        }
    }

    @Test func rejectsMalformedJSON() async throws {
        ACache.shared.clear()
        MockURLProtocol.configure(status: 200, body: Data("not-json".utf8))
        let downloader = Ando(type: .json, session: makeSession())
        let url = try #require(URL(string: "https://example.test/invalid-json"))
        do {
            _ = try await downloader.load(from: url)
            Issue.record("Expected JSON decoding failure")
        } catch {
            #expect(ACache.shared.count == 0)
        }
    }

    @Test @MainActor func invalidURLIsReportedOnMainActor() {
        let downloader = Ando(type: .json)
        var code: Int?
        downloader.callback = { code = $0.error?.code }
        downloader.url = "not a URL"
        #expect(code == AError.Code.WrongURL.rawValue)
    }
}
