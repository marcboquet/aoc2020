import XCTest
@testable import AdventOfCode2020

final class AdventOfCode2020Tests: XCTestCase {
    func testExample() {
        XCTAssertEqual(AdventOfCode2020().testRead(name: "test"), "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
