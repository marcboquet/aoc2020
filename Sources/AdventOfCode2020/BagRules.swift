import Foundation

struct BagRule {
    var color: String
    var holds: [String: Int]
    
    init(_ data: String) {
        let range = NSRange(location: 0, length: data.utf16.count)
        let pattern = #"(\w+ \w+) bags contain (.*)\."#
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let match = regex.firstMatch(in: data, options: [], range: range)!

        let colorRange = Range(match.range(at: 1), in: data)!
        self.color = String(data[colorRange])

        let restRange = Range(match.range(at: 2), in: data)!
        let restData = String(data[restRange])
        
        if restData == "no other bags" {
            self.holds = [String: Int]()
        } else {
            self.holds = [String: Int]()
            let restRules = restData.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
            for rule in restRules {
                let separated = rule.split(separator: " ")
                let bagCount = Int(separated[0])
                let bagColor = String(separated[1] + " " + separated[2])
                self.holds[bagColor] = bagCount
            }
        }
    }
}

struct BagRules {
    var rules: [String: BagRule]
    
    init(_ data: [String]) {
        self.rules = [String: BagRule]()
        data.map { BagRule($0) }.forEach {
            self.rules[$0.color] = $0
        }
    }
    
    func howMany(color: String, in ruleColor: String) -> Int {
        let rule = rules[ruleColor]!
        var holding = rule.holds[color] ?? 0
        rule.holds.keys.forEach {
            holding += howMany(color: color, in:$0) * rule.holds[$0]!
        }
        return holding
    }
    
    func howMany(in ruleColor: String) -> Int {
        return self.rules.keys.map { howMany(color: $0, in: ruleColor) }.reduce(0, +)
    }
    
    func containing(color: String) -> [String] {
        return self.rules.keys.filter { howMany(color: color, in: $0) > 0 }
    }
}
