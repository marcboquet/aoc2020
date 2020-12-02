import XCTest
@testable import AdventOfCode2020

final class Day2Tests: XCTestCase {
    func testPolicy() {
        let policy = PasswordPolicy(policy: "1-3 a")
        XCTAssertEqual(policy.range, 1...3)
        XCTAssertEqual(policy.letter, "a")
    }
    
    func testPassword() {
        XCTAssertEqual(Password(policyAndPassword: "1-3 a: abc").isValid(), true)
        XCTAssertEqual(Password(policyAndPassword: "1-3 a: aaa").isValid(), true)
        XCTAssertEqual(Password(policyAndPassword: "1-3 a: bcd").isValid(), false)
        XCTAssertEqual(Password(policyAndPassword: "1-3 a: aaaa").isValid(), false)
    }
    
    func testPasswordList() {
        let passwordList = PasswordList(list: ["1-3 a: abc", "1-4 b: cba", "1-2 b: bbb"])
        XCTAssertEqual(passwordList.valid().count, 2)
    }
    
    func testPart1() {
        let list = PasswordList(list: Input(name: "2-input").lines())
        XCTAssertEqual(list.valid().count, 548)
    }
    
    func testPart2() {
        let list = PasswordList(list: Input(name: "2-input").lines(), policyType: NewPasswordPolicy.self)
        XCTAssertEqual(list.valid().count, 502)
    }
}
