import Foundation

import XCTest
@testable import AdventOfCode2020

final class Day9Tests: XCTestCase {
    func testSample() {
        let input: [Int] = Input(name: "9-sample").lines()
        let encoding = XMASEncoding(input, preambleSize: 5)
        XCTAssertEqual(encoding.firstInvalid(), 127)
    }
    
    func testPart1() {
        let input: [Int] = Input(name: "9-input").lines()
        let encoding = XMASEncoding(input)
        XCTAssertEqual(encoding.firstInvalid(), 1124361034)
    }
    
    func testPart2Sample() {
        let input: [Int] = Input(name: "9-sample").lines()
        let encoding = XMASEncoding(input, preambleSize: 5)
        XCTAssertEqual(encoding.findWeakness(), 62)
    }
    
    func testPart2() {
        let input: [Int] = Input(name: "9-input").lines()
        let encoding = XMASEncoding(input)
        XCTAssertEqual(encoding.findWeakness(), 129444555)
    }
}
