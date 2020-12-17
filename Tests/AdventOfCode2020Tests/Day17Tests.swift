import Foundation

import XCTest
@testable import AdventOfCode2020

final class Day17Tests: XCTestCase {
    func testSample() {
        let input: [String] = Input(name: "17-sample").lines()
        
        var cubes = ConwayCubes(input)
        cubes.simulate(cycles: 6)

        XCTAssertEqual(cubes.activeCubes.count, 112)
    }

    func testPart1() {
        let input: [String] = Input(name: "17-input").lines()
        
        var cubes = ConwayCubes(input)
        cubes.simulate(cycles: 6)

        XCTAssertEqual(cubes.activeCubes.count, 391)
    }
    
    func testPart2Sample() {
        let input: [String] = Input(name: "17-sample").lines()
        
        var cubes = ConwayCubes(input, hyper: true)
        cubes.simulate(cycles: 6)

        XCTAssertEqual(cubes.activeCubes.count, 848)
    }
    
    func testPart2() {
        let input: [String] = Input(name: "17-input").lines()
        
        var cubes = ConwayCubes(input, hyper: true)
        cubes.simulate(cycles: 6)

        XCTAssertEqual(cubes.activeCubes.count, 2264)
    }
}
