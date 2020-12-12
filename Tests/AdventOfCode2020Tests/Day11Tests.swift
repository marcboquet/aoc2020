import Foundation

import XCTest
@testable import AdventOfCode2020

final class Day11Tests: XCTestCase {
    func testSample() {
        let input: [String] = Input(name: "11-sample").lines()
        let ferry = FerrySeats(input)

        XCTAssertEqual(ferry.occupied(seats: ferry.runModel()), 37)
    }

    func testPart1() {
        let input: [String] = Input(name: "11-input").lines()
        let ferry = FerrySeats(input)

        XCTAssertEqual(ferry.occupied(seats: ferry.runModel()), 2310)
    }
    
    func testPart2Sample() {
        let input: [String] = Input(name: "11-sample").lines()
        let ferry = FerrySeats(input)

        XCTAssertEqual(ferry.occupied(seats: ferry.runModel(extended: true)), 26)
    }
    
    func testPart2() {
        let input: [String] = Input(name: "11-input").lines()
        let ferry = FerrySeats(input)

        XCTAssertEqual(ferry.occupied(seats: ferry.runModel(extended: true)), 2074)
    }
}

