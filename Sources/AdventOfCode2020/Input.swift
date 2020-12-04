import Foundation

struct Input {
    var name: String
    
    public init(name: String) {
        self.name = name
    }
    
    public var content: String {
        let path = Bundle.module.path(forResource: name, ofType: nil)
        let content: String = try! String(contentsOfFile: path!, encoding: .utf8)
        return content.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    public func lines() -> [String] {
        let lines: [String] = content.lines.compactMap { (line) -> String? in
            return line.isEmpty ? nil : line
        }
        return lines
    }
    
    public func lines() -> [Int] {
        let lines: [Int] = content.lines.compactMap { (line) -> Int? in
            return Int(line)
        }
        return lines
    }
    
    public func blankLineSeparated() -> [String] {
        return content.components(separatedBy: "\n\n").map {
            $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).replacingOccurrences(of: "\n", with: " ")
        }
    }
}
