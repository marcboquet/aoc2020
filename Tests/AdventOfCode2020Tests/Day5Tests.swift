import XCTest
@testable import AdventOfCode2020

final class Day5Tests: XCTestCase {
    func testPass() {
        let pass = BoardingPass("FBFBBFFRLR")
        XCTAssertEqual(pass.row, 44)
        XCTAssertEqual(pass.col, 5)
        XCTAssertEqual(pass.sid, 357)
    }
    
    func testPart1() {
        let input: [String] = Input(name: "5-input").lines()
        let passes = BoardingPassList(data: input)
        XCTAssertEqual(passes.highestSid(), 930)
    }
    
    func testPart2() {
        let input: [String] = Input(name: "5-input").lines()
        let passes = BoardingPassList(data: input)
        XCTAssertEqual(passes.findEmpty(), 515)
    }
}
