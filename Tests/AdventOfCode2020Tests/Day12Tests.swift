import Foundation

import XCTest
@testable import AdventOfCode2020

final class Day12Tests: XCTestCase {
    func testSample() {
        let input: [String] = Input(name: "12-sample").lines()
        var ferry = FerryNavigation(input)
        
        ferry.navigate()

        XCTAssertEqual(ferry.manhattan, 25)
    }
    
    func testPart1() {
        let input: [String] = Input(name: "12-input").lines()
        var ferry = FerryNavigation(input)
        
        ferry.navigate()

        XCTAssertEqual(ferry.manhattan, 820)
    }
    
    func testPart2Sample() {
        let input: [String] = Input(name: "12-sample").lines()
        var ferry = FerryNavigation(input)
        
        ferry.navigateWaypoint()

        XCTAssertEqual(ferry.manhattan, 286)
    }
    
    func testPart2() {
        let input: [String] = Input(name: "12-input").lines()
        var ferry = FerryNavigation(input)
        
        ferry.navigateWaypoint()

        XCTAssertEqual(ferry.manhattan, 66614)
    }
}

