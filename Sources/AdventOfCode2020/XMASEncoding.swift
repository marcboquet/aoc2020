import Foundation

struct XMASEncoding {
    var numbers: [Int]
    var preambleSize: Int

    init(_ input: [Int], preambleSize: Int = 25) {
        self.numbers = input
        self.preambleSize = preambleSize
    }
    
    func isValid(index: Int) -> Bool {
        let preamble = Array(numbers[index - preambleSize..<index])
        for i in 0..<preamble.count {
            for j in i..<preamble.count {
                if preamble[i] + preamble[j] == numbers[index] {
                    return true
                }
            }
        }
        return false
    }
    
    func firstInvalid() -> Int {
        for i in preambleSize..<numbers.count {
            if !isValid(index: i) {
                return numbers[i]
            }
        }
        return 0
    }
    
    func findWeakness() -> Int {
        let number = firstInvalid()
        var index = 0
        var size = 2
        repeat {
            let sum = numbers[index..<index+size].reduce(0, +)
            if sum == number {
                return numbers[index..<index+size].max()! + numbers[index..<index+size].min()!
            }
            if sum < number {
                size += 1
            } else {
                size = 2
                index += 1
            }
        } while index < numbers.count
        
        return 0
    }
}
