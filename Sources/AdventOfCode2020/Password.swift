import Foundation

struct PasswordList {
    var passwords: [Password]

    init(list: [String], policyType: PasswordPolicyProtocol.Type = PasswordPolicy.self) {
        self.passwords = list.map { Password(policyAndPassword: $0, policyType: policyType) }
    }
    
    func valid() -> [Password] {
        return passwords.filter { $0.isValid() }
    }
}

struct Password {
    var policy: PasswordPolicyProtocol
    var password: String

    init(policyAndPassword: String, policyType: PasswordPolicyProtocol.Type = PasswordPolicy.self) {
        let parts = policyAndPassword.split(separator: ":").map { String($0) }
        self.policy = policyType.init(policy: parts.first!)
        self.password = parts.last!.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func isValid() -> Bool {
        return policy.isValid(password: password)
    }
}

protocol PasswordPolicyProtocol {
    init(policy: String)
    func isValid(password: String) -> Bool
}

struct PasswordPolicy: PasswordPolicyProtocol {
    var range: ClosedRange<Int>
    var letter: Character

    init(policy: String) {
        let parts = policy.split(separator: " ")
        let ranges: [Int] = parts[0].split(separator: "-").map { Int($0)! }
        self.range = ranges[0]...ranges[1]
        self.letter = parts[1].first!
    }
    
    func isValid(password: String) -> Bool {
        let occurrences = password.filter { $0 == letter }.count
        return range.contains(occurrences)
    }
}

struct NewPasswordPolicy: PasswordPolicyProtocol {
    var positions: [Int]
    var letter: Character

    init(policy: String) {
        let parts = policy.split(separator: " ")
        self.positions = parts[0].split(separator: "-").map { Int($0)! - 1 }
        self.letter = parts[1].first!
    }
    
    func isValid(password: String) -> Bool {
        let occurrences = positions.filter { password[String.Index(utf16Offset: $0, in: password)] == letter }.count
        return occurrences == 1
    }
}
