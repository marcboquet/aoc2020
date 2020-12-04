import Foundation

struct PassportBatch {
    var passports: [Passport]
    
    init(batch: [String]) {
        passports = batch.map { Passport(data: $0) }
    }
    
    var validPassports: [Passport] {
        passports.filter({ $0.isValid })
    }
    
    var reallyValidPassports: [Passport] {
        passports.filter({ $0.isReallyValid })
    }
}

struct Passport {
    var fields: [Field]
    
    init(data: String) {
        let fieldsData = data.split(separator: " ")
        self.fields = fieldsData.map { Field(data: String($0)) }
    }
    
    var isValid: Bool {
        let includedFields = fields.map { $0.key }
        let missing = requiredFields.filter({ !includedFields.contains($0) })
        return missing.isEmpty
    }
    
    var isReallyValid: Bool {
        return isValid && fields.map(\.isValid).allSatisfy { $0 == true }
    }
    
    var requiredFields: [Field.Key] = Field.Key.allCases.filter({ $0 != .countryId })

    struct Field {
        var key: Key
        var value: String
        
        init(data: String) {
            let parts = data.split(separator: ":")
            self.key = Key(rawValue: String(parts.first!))!
            self.value = String(parts.last!)
        }
        
        var isValid: Bool {
            switch key {
            case .birthYear:
                if let year = Int(value), year >= 1920 && year <= 2002 { return true }
            case .issueYear:
                if let year = Int(value), year >= 2010 && year <= 2020 { return true }
            case .expiration:
                if let year = Int(value), year >= 2020 && year <= 2030 { return true }
            case .height:
                if value.hasSuffix("cm") {
                    if let cm = Int(value.components(separatedBy: "cm").first ?? ""), cm >= 150 && cm <= 193 { return true }
                }
                if value.hasSuffix("in") {
                    if let inches = Int(value.components(separatedBy: "in").first ?? ""), inches >= 59 && inches <= 76 { return true }
                }
            case .hairColor:
                if value.first != "#" && value.count != 7 { return false }
                if let color = value.components(separatedBy: "#").last, color.allSatisfy(\.isHexDigit) { return true }
                
            case .eyeColor:
                return "amb blu brn gry grn hzl oth".split(separator: " ").map(String.init).contains(value)

            case .passportId:
                return value.allSatisfy(\.isNumber) && value.count == 9

            case .countryId:
                return true
            }
            return false
        }

        enum Key: String, CaseIterable {
            case birthYear = "byr"
            case issueYear = "iyr"
            case expiration = "eyr"
            case height = "hgt"
            case hairColor = "hcl"
            case eyeColor = "ecl"
            case passportId = "pid"
            case countryId = "cid"
        }
    }
}
