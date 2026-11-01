import XCTest
import UIKit
@testable import Ando

final class AndoTests: XCTestCase {
    @MainActor
    func testWrongURL() {
        let downloader = Ando(type: .json)
        let expected = expectation(description: "Invalid URL should invoke completion")
        downloader.callback = { response in
            XCTAssertNil(response.item)
            XCTAssertEqual(response.error?.code, AError.Code.WrongURL.rawValue)
            expected.fulfill()
        }
        downloader.url = "wrong url"
        wait(for: [expected], timeout: 1)
    }

    @MainActor
    func testUIImageViewExtensionReusesDownloader() {
        let imageView = UIImageView()
        XCTAssertTrue(imageView.ando === imageView.ando)
    }

    func testJSONParsing() throws {
        let bytes = Data(#"{"key":"value"}"#.utf8)
        let item = try Item(type: .json).get(bytes)
        XCTAssertEqual((item as? [String: String])?["key"], "value")
    }
}
