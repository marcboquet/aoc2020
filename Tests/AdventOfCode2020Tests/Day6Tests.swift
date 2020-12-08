import Foundation

import XCTest
@testable import AdventOfCode2020

final class Day6Tests: XCTestCase {
    func testSample() {
        let input = Input(name: "6-sample").blankLineSeparated()
        let groups = CustomDeclarationFormsGroups(input)
        XCTAssertEqual(groups.answersCount, 11)
    }
    
    func testPart1() {
        let input = Input(name: "6-input").blankLineSeparated()
        let groups = CustomDeclarationFormsGroups(input)
        XCTAssertEqual(groups.answersCount, 6587)
    }
    
    func testPart2() {
        let input = Input(name: "6-input").blankLineSeparated()
        let groups = CustomDeclarationFormsGroups(input)
        XCTAssertEqual(groups.allAnswersCount, 3235)
    }
}

