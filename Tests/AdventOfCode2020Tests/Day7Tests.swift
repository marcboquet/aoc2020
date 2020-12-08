import Foundation

import XCTest
@testable import AdventOfCode2020

final class Day7Tests: XCTestCase {
    func testSample() {
        let input: [String] = Input(name: "7-sample").lines()
        let rules = BagRules(input)
        
        XCTAssertEqual(rules.howMany(color: "shiny gold", in: "bright white"), 1)
        XCTAssertEqual(rules.howMany(color: "shiny gold", in: "muted yellow"), 2)
        XCTAssertEqual(rules.howMany(color: "shiny gold", in: "dark orange"), 11)
        
        XCTAssertEqual(rules.containing(color: "shiny gold").count, 4)
    }
    
    func testPart1() {
        let input: [String] = Input(name: "7-input").lines()
        let rules = BagRules(input)
        
        XCTAssertEqual(rules.containing(color: "shiny gold").count, 155)
    }
    
    func testPart2() {
        let input: [String] = Input(name: "7-input").lines()
        let rules = BagRules(input)
        
        XCTAssertEqual(rules.howMany(in: "shiny gold"), 54803)
    }
}

