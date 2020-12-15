import Foundation

import XCTest
@testable import AdventOfCode2020

final class Day15Tests: XCTestCase {
    func testSample() {
        let input: [Int] = [0,3,6]
        
        var game = NumbersGame(input)
        game.run(2020)

        XCTAssertEqual(game.lastNumber, 436)
    }

    func testPart1() {
        let input: [Int] = [1,0,16,5,17,4]
        
        var game = NumbersGame(input)
        game.run(30000000)

        XCTAssertEqual(game.lastNumber, 573522)
    }
}

