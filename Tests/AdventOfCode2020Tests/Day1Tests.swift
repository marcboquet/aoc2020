import XCTest
@testable import AdventOfCode2020

final class Day1Tests: XCTestCase {
    func testPart1() {
        let report = ExpenseReport(expenses: AdventOfCode2020(name: "1-input").lines())
        let numbers: (Int, Int) = report.findSum(sum: 2020)
        XCTAssertEqual(numbers.0 * numbers.1, 878724)
    }
    
    func testPart2() {
        let report = ExpenseReport(expenses: AdventOfCode2020(name: "1-input").lines())
        let numbers: (Int, Int, Int) = report.findSum(sum: 2020)
        XCTAssertEqual(numbers.0 * numbers.1 * numbers.2, 201251610)
    }
}
