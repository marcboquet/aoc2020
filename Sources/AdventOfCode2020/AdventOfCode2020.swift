import Foundation

struct AdventOfCode2020 {
    func testRead(name: String) -> String {
        let path = Bundle.module.path(forResource: name, ofType: nil)
        let content: String = try! String(contentsOfFile: path!, encoding: .utf8)
        return content.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
