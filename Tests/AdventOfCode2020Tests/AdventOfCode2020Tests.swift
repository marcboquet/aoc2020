import XCTest
@testable import AdventOfCode2020

final class AdventOfCode2020Tests: XCTestCase {
    func testExample() {
        XCTAssertEqual(Input(name: "test").content, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
