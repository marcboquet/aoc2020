import Foundation

struct TicketValidation {
    var rules: Rules = Rules()
    var mine: Ticket?
    var nearby: [Ticket] = []

    init(_ data: [String]) {
        var i = 0
        while i < data.count {
            let line = data[i]
            i += 1
            if line.starts(with: "your") { break }
            
            let nameAndRanges = line.split(separator: ":")
            let ruleName = String(nameAndRanges.first!)
            let ranges = nameAndRanges.last!.components(separatedBy: "or").map { $0.trimmingCharacters(in: .whitespaces) }.map { $0.split(separator: "-").map { Int($0)! } }.map { $0[0]...$0[1] }
            rules.rules.append(Rule(name: ruleName, ranges: ranges))
        }
        while i < data.count {
            let line = data[i]
            i += 1
            if line.starts(with: "nearby") { break }
            mine = Ticket(values: line.split(separator: ",").map{Int($0)!})
        }
        while i < data.count {
            let line = data[i]
            i += 1
            nearby.append(Ticket(values: line.split(separator: ",").map{Int($0)!}))
        }
    }
    
    var validTickets: [Ticket] {
        [mine!] + nearby.filter { rules.isValid($0) }
    }
    
    func departureValues() -> Int {
        var fields = determineFields()
        var departure = 1
        for i in 0..<fields.count {
            if fields[i].name.starts(with: "departure") {
                departure *= mine!.values[i]
            }
        }
        return departure
    }
    
    func determineFields() -> [Rule] {
        var possibleFields = [[Rule]]()
        mine!.values.forEach({ value in
            possibleFields.append(rules.rules)
        })
        
        for valueIndex in 0..<mine!.values.count {
            var possible = possibleFields[valueIndex]

            for ticket in validTickets {
                if possible.count == 1 { break }
                for rule in possibleFields[valueIndex] {
                    if !rule.isValid(ticket.values[valueIndex]) {
                        possible.removeAll(where: { $0.name == rule.name })
                    }
                }
            }
            possibleFields[valueIndex] = possible
        }
        
        while !possibleFields.allSatisfy({ $0.count == 1 }) {
            var taken = Set<Rule>()
            possibleFields.filter({ $0.count == 1 }).forEach({ taken.insert($0.first!) })
            for i in 0..<possibleFields.count {
                if possibleFields[i].count == 1 { continue }
                possibleFields[i].removeAll(where: { taken.contains($0) })
            }
        }
        return possibleFields.map { $0.first! }
    }
    
    var errorRate: Int {
        return nearby.map { rules.errorRate($0) }.reduce(0,+)
    }
    
    struct Ticket {
        var values: [Int]
    }
    
    struct Rules {
        var rules: [Rule] = []
        
        func errorRate(_ ticket: Ticket) -> Int {
            let invalid = invalidValues(ticket)
            return invalid.reduce(0, +)
        }
        
        func invalidValues(_ ticket: Ticket) -> [Int] {
            return ticket.values.filter({ value in
                return rules.allSatisfy({ !$0.isValid(value)})
            })
        }
        
        func isValid(_ ticket: Ticket) -> Bool {
            return invalidValues(ticket).isEmpty
        }
    }
    
    struct Rule : Hashable {
        var name: String
        var ranges: [ClosedRange<Int>]
        
        func isValid(_ number: Int) -> Bool {
            return ranges.contains(where: { $0.contains(number) })
        }
    }
}
