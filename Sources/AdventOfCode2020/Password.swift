import Foundation

struct PasswordList {
    var passwords: [Password]

    init(list: [String]) {
        self.passwords = list.map { Password(policyAndPassword: $0) }
    }
    
    func valid() -> [Password] {
        return passwords.filter { $0.isValid() }
    }
}

struct Password {
    var policy: PasswordPolicy
    var password: String

    init(policyAndPassword: String) {
        let parts = policyAndPassword.split(separator: ":").map { String($0) }
        self.policy = PasswordPolicy(policy: parts.first!)
        self.password = parts.last!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func isValid() -> Bool {
        let occurrences = password.filter { $0 == policy.letter }.count
        return policy.range.contains(occurrences)
    }
}

struct PasswordPolicy {
    var range: ClosedRange<Int>
    var letter: Character

    init(policy: String) {
        let parts = policy.split(separator: " ")
        let ranges: [Int] = parts[0].split(separator: "-").map { Int($0)! }
        self.range = ranges[0]...ranges[1]
        self.letter = parts[1].first!
    }
}
