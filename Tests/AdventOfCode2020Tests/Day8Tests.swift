import Foundation

import XCTest
@testable import AdventOfCode2020

final class Day8Tests: XCTestCase {
    func testSample() {
        let input: [String] = Input(name: "8-sample").lines()
        let console = Console(input)

        XCTAssertThrowsError(try console.boot()) { error in
            guard case Console.RuntimeError.infiniteLoop(let value) = error else {
                return XCTFail()
            }
            XCTAssertEqual(value, 5)
        }
    }
    
    func testPart1() {
        let input: [String] = Input(name: "8-input").lines()
        let console = Console(input)

        XCTAssertThrowsError(try console.boot()) { error in
            guard case Console.RuntimeError.infiniteLoop(let value) = error else {
                return XCTFail()
            }
            XCTAssertEqual(value, 1928)
        }
    }
    
    func testSamplePart2() {
        let input: [String] = Input(name: "8-sample").lines()
        let console = Console(input)

        XCTAssertThrowsError(try console.repair()) { error in
            guard case Console.RuntimeError.eof(let ip, let size, let acc) = error else {
                return XCTFail()
            }
            XCTAssertEqual(ip, size)
            XCTAssertEqual(acc, 8)
        }
    }
    
    func testPart2() {
        let input: [String] = Input(name: "8-input").lines()
        let console = Console(input)

        XCTAssertThrowsError(try console.repair()) { error in
            guard case Console.RuntimeError.eof(let ip, let size, let acc) = error else {
                return XCTFail()
            }
            XCTAssertEqual(ip, size)
            XCTAssertEqual(acc, 1319)
        }
    }
}

