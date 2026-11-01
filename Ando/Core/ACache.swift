import Foundation

protocol CacheProtocol {
    func addItem(url: String, item: Any)
    func getItem(url: String) -> Any?
}

/// Thread-safe, bounded FIFO cache. Capacity is measured in items, not bytes.
public final class ACache: CacheProtocol, @unchecked Sendable {
    public static let shared = ACache()

    private let lock = NSLock()
    private var maxLength = 100
    private var keys: [String] = []
    private var values: [String: Any] = [:]

    public init() {}

    func getItem(url: String) -> Any? {
        lock.lock()
        defer { lock.unlock() }
        return values[url]
    }

    func addItem(url: String, item: Any) {
        lock.lock()
        defer { lock.unlock() }
        guard maxLength > 0 else { return }
        guard values[url] == nil else { return }
        while keys.count >= maxLength, !keys.isEmpty {
            let removed = keys.removeFirst()
            values.removeValue(forKey: removed)
        }
        keys.append(url)
        values[url] = item
    }

    /// Zero disables caching. Negative capacities are treated as zero.
    public func setMaxLength(_ value: Int) {
        lock.lock()
        defer { lock.unlock() }
        maxLength = max(0, value)
        while keys.count > maxLength {
            let removed = keys.removeFirst()
            values.removeValue(forKey: removed)
        }
    }

    public var count: Int {
        lock.lock()
        defer { lock.unlock() }
        return keys.count
    }

    public func clear() {
        lock.lock()
        defer { lock.unlock() }
        keys.removeAll()
        values.removeAll()
    }
}
