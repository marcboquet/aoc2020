import Foundation

struct JoltageAdapters {
    var adapters: [Int]
    var sorted: [Int]
    
    init(_ data: [Int]) {
        self.adapters = data + [0] + [data.max()! + 3]
        self.sorted = self.adapters.sorted()
    }
    
    
    func differentialsValue() -> Int {
        var differentials = [Int: Int]()
        var prev = 0
        for joltage in sorted {
            let diff = joltage - prev
            differentials[diff, default: 0] += 1
            prev = joltage
        }
        return differentials[1]! * differentials[3]!
    }
    
    var groupsOf3: [Int] {
        // get sizes of groups of 3 or more values with difference of 1
        // [1,2,3,4,11,12,13] returns [5,3]
        var groups = [Int]()
        var prev = 0
        var currentGroup = 0
        for joltage in sorted[1...] {
            let diff = joltage - prev
            prev = joltage
            currentGroup += 1
            if diff > 1 {
                if currentGroup > 2 { groups.append(currentGroup) }
                currentGroup = 0
                continue
            }
        }
        return groups
    }
    
    var combinations: Int {
        // each group of 3 allows 2 combinations.
        // A group of 5 is like 3 groups of 3:
        // [1,2,3,4,5] -> [1,2,3] + [2,3,4] + [3,4,5]
        // Combinations are 2**3 = 8
        let groupCombinations: [Int] = groupsOf3.map { (group) -> Int in
            var combos: Int = NSDecimalNumber(decimal: pow(2, group - 2)).intValue
            if group > 4 {
                // groups larger than 4 have some invalid combinations
                // [1,2,3,4,5] can't allow the combination that would result in [1,5]
                combos -= group - 4
            }
            return combos
        }
        return groupCombinations.reduce(1, *)
    }
}
