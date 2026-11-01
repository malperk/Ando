import XCTest
@testable import Ando

final class CacheTests: XCTestCase {
    func testCapacityAndEviction() {
        let cache = ACache()
        cache.setMaxLength(2)
        cache.addItem(url: "a", item: 1)
        cache.addItem(url: "b", item: 2)
        cache.addItem(url: "c", item: 3)
        XCTAssertEqual(cache.count, 2)
        XCTAssertNil(cache.getItem(url: "a"))
        XCTAssertEqual(cache.getItem(url: "b") as? Int, 2)
        XCTAssertEqual(cache.getItem(url: "c") as? Int, 3)
        cache.setMaxLength(0)
        XCTAssertEqual(cache.count, 0)
    }
}
