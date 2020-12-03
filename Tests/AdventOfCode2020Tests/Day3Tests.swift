import XCTest
@testable import AdventOfCode2020

final class Day3Tests: XCTestCase {
    func testParsing() {
        let input = Input(name: "3-sample")
        let map = TobogganMap(map: input.lines())
        XCTAssertEqual(map.description, input.content)
    }
    
    func testSample() {
        let input = Input(name: "3-sample")
        let map = TobogganMap(map: input.lines())
        let toboggan = Toboggan(map: map)
        let result = toboggan.sendIt(slope: (3,1))
        XCTAssertEqual(result.trees, 7)
    }
    
    func testPart1() {
        let input = Input(name: "3-input")
        let map = TobogganMap(map: input.lines())
        let toboggan = Toboggan(map: map)
        let result = toboggan.sendIt(slope: (3,1))
        XCTAssertEqual(result.trees, 292)
    }
    
    func testPart2() {
        let input = Input(name: "3-input")
        let map = TobogganMap(map: input.lines())
        let toboggan = Toboggan(map: map)
        let results = [(1,1), (3,1), (5,1), (7,1), (1,2)].map { toboggan.sendIt(slope: $0).trees }
        XCTAssertEqual(results.reduce(1, *), 9354744432)
    }
}
