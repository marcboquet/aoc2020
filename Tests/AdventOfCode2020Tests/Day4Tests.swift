import XCTest
@testable import AdventOfCode2020

final class Day4Tests: XCTestCase {
    func testPart1() {
        let input = Input(name: "4-input").blankLineSeparated()
        let passportBath = PassportBatch(batch: input)
        XCTAssertEqual(passportBath.validPassports.count, 170)
    }

    func testValidation() {
        XCTAssertEqual(Passport.Field(data: "byr:1920").isValid, true)
        XCTAssertEqual(Passport.Field(data: "byr:1919").isValid, false)
        XCTAssertEqual(Passport.Field(data: "hgt:59cm").isValid, false)
        XCTAssertEqual(Passport.Field(data: "hgt:150cm").isValid, true)
        XCTAssertEqual(Passport.Field(data: "hgt:200cm").isValid, false)
        XCTAssertEqual(Passport.Field(data: "hgt:150mt").isValid, false)
        XCTAssertEqual(Passport.Field(data: "hgt:150in").isValid, false)
        XCTAssertEqual(Passport.Field(data: "hgt:59in").isValid, true)
        XCTAssertEqual(Passport.Field(data: "hcl:#123abc").isValid, true)
        XCTAssertEqual(Passport.Field(data: "hcl:#123abz").isValid, false)
        XCTAssertEqual(Passport.Field(data: "hcl:123abc").isValid, false)
        XCTAssertEqual(Passport.Field(data: "ecl:brn").isValid, true)
        XCTAssertEqual(Passport.Field(data: "ecl:wat").isValid, false)
        XCTAssertEqual(Passport.Field(data: "pid:000000001").isValid, true)
        XCTAssertEqual(Passport.Field(data: "pid:0123456789").isValid, false)
    }
    
    func testPart2() {
        let input = Input(name: "4-input").blankLineSeparated()
        let passportBath = PassportBatch(batch: input)
        XCTAssertEqual(passportBath.reallyValidPassports.count, 103)
    }
}
