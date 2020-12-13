import Foundation

struct ShuttleSchedule {
    var timestamp: Int
    var shuttles: [String]

    init(_ data: [String]) {
        timestamp = Int(data[0])!
        shuttles = data[1].split(separator: ",").map(String.init)
    }
    
    func earliest() -> Int {
        let idDiffs = shuttles.compactMap(Int.init).map({ ($0, timestamp % $0) })
        let first = idDiffs.sorted(by: { $0.0 - $0.1 < $1.0 - $1.1 }).first!
        return first.0 * (first.0 - first.1)
    }
    
    func earliestMatch() -> Int {
        var offset = 1
        var aggregateTime = Int(shuttles[0])!
        var firstOccurrence = 0
        for i in 1..<shuttles.count {
            if let shuttle = Int(shuttles[i]) {
                var times = 1
                while (firstOccurrence + aggregateTime * times + offset) % shuttle != 0 {
                    times += 1
                }
                firstOccurrence += aggregateTime * times
                aggregateTime *= shuttle
            }
            offset += 1
        }
        return firstOccurrence
    }
}
