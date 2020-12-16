import Foundation

import XCTest
@testable import AdventOfCode2020

final class Day16Tests: XCTestCase {
    func testSample() {
        let input: [String] = Input(name: "16-sample").lines()
        
        let validation = TicketValidation(input)

        XCTAssertEqual(validation.errorRate, 71)
    }
    
    func testPart1() {
        let input: [String] = Input(name: "16-input").lines()
        
        let validation = TicketValidation(input)

        XCTAssertEqual(validation.errorRate, 27898)
    }
    
    func testPart2() {
        let input: [String] = Input(name: "16-input").lines()
        
        let validation = TicketValidation(input)

        XCTAssertEqual(validation.departureValues(), 2766491048287)
    }
}
