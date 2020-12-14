import Foundation

import XCTest
@testable import AdventOfCode2020

final class Day14Tests: XCTestCase {
    func testPart1() {
        let input: [String] = Input(name: "14-input").lines()
        
        var computer = PortComputer(input)
        computer.run()

        XCTAssertEqual(computer.memsum, 11179633149677)
    }
    
    func testPart2Sample() {
        let input: [String] = Input(name: "14-sample").lines()
        
        var computer = PortComputer(input)
        computer.runV2()

        XCTAssertEqual(computer.memsum, 208)
    }
    
    func testPart2() {
        let input: [String] = Input(name: "14-input").lines()
        
        var computer = PortComputer(input)
        computer.runV2()

        XCTAssertEqual(computer.memsum, 4822600194774)
    }
}

