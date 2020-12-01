import XCTest
@testable import AdventOfCode2020

final class Day1Tests: XCTestCase {
    func testExample() {
        let report = ExpenseReport(expenses: AdventOfCode2020(name: "1-input").lines())
        let numbers = report.findSum(sum: 2020)
        XCTAssertEqual(numbers.0 * numbers.1, 878724)
    }
}
