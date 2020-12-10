import Foundation

import XCTest
@testable import AdventOfCode2020

final class Day10Tests: XCTestCase {
    func testSample() {
        let input: [Int] = Input(name: "10-sample").lines()
        let adapters = JoltageAdapters(input)

        XCTAssertEqual(adapters.differentialsValue(), 220)
    }

    func testPart1() {
        let input: [Int] = Input(name: "10-input").lines()
        let adapters = JoltageAdapters(input)

        XCTAssertEqual(adapters.differentialsValue(), 2775)
    }
    
    func testPart2Sample() {
        let input: [Int] = Input(name: "10-sample").lines()
        let adapters = JoltageAdapters(input)

        XCTAssertEqual(adapters.combinations, 19208)
    }
    
    func testPart2() {
        let input: [Int] = Input(name: "10-input").lines()
        let adapters = JoltageAdapters(input)

        XCTAssertEqual(adapters.combinations, 518344341716992)
    }
}

