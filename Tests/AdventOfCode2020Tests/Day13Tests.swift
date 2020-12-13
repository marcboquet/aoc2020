import Foundation

import XCTest
@testable import AdventOfCode2020

final class Day13Tests: XCTestCase {
    func testPart1() {
        let input: [String] = Input(name: "13-input").lines()
        
        let schedule = ShuttleSchedule(input)

        XCTAssertEqual(schedule.earliest(), 3269)
    }
    
    func testPart2() {
        let input: [String] = Input(name: "13-input").lines()
        
        let schedule = ShuttleSchedule(input)

        XCTAssertEqual(schedule.earliestMatch(), 672754131923874)
    }
}

