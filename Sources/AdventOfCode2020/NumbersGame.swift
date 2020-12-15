import Foundation

struct NumbersGame {
    var numbers = [Int]()
    var lastNumber = 0
    var round = 1
    var memos = [Int: Int]()

    init(_ initialNumbers: [Int]) {
        numbers = initialNumbers
        for i in 0..<numbers.count-1 {
            let num = numbers[i]
            memos[num] = i+1
        }
        round = numbers.count
        lastNumber = numbers.last!
    }
    
    mutating func run(_ rounds: Int) {
        while round < rounds {
            let prevNumber = lastNumber
            if let spokenAt = memos[lastNumber] {
                let diff = round - spokenAt
                numbers.append(diff)
                lastNumber = diff
            } else {
                numbers.append(0)
                lastNumber = 0
            }
            memos[prevNumber] = round
            round += 1
        }
    }
}
