import Foundation

struct ExpenseReport {
    var expenses: [Int]

    init(expenses: [Int]) {
        self.expenses = expenses
    }
    
    func findSum(sum: Int) -> (Int, Int) {
        for (i, first) in expenses.enumerated() {
            for j in i..<expenses.count {
                let second = expenses[j]
                if first + second == sum {
                    return (first, second)
                }
            }
        }
        return (0, 0)
    }
    
    func findSum(sum: Int) -> (Int, Int, Int) {
        for (i, first) in expenses.enumerated() {
            for j in i..<expenses.count {
                for k in j..<expenses.count {
                    let second = expenses[j]
                    let third = expenses[k]
                    if first + second + third == sum {
                        return (first, second, third)
                    }
                }
            }
        }
        return (0, 0, 0)
    }
}
