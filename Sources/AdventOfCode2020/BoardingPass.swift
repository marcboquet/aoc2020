import Foundation

struct BoardingPass {
    var row: Int
    var col: Int
    var sid: Int { row * 8 + col }
    
    init(_ data: String) {
        let separator = data.firstIndex(where: { $0 == "L" || $0 == "R" })!
        
        self.row = decode(data.prefix(upTo: separator))
        self.col = decode(data.suffix(from: separator))
    }
}

func decode(_ data: Substring) -> Int {
    guard let letter = data.first else { return 0 }

    var partition = 0
    if letter == "B" || letter == "R" {
        partition = Int(pow(Double(2), Double(data.count))) / 2
    }
    return partition + decode(data.dropFirst())
}

struct BoardingPassList {
    var boardingPasses: [BoardingPass]
    
    init(data: [String]) {
        self.boardingPasses = data.map { BoardingPass($0) }
    }
    
    func highestSid() -> Int {
        let sids = boardingPasses.map { $0.sid }
        return sids.sorted().last!
    }
    
    func findEmpty() -> Int {
        let valid = boardingPasses.filter { $0.row != 0 && $0.row != 116 }.sorted(by: { $0.sid < $1.sid })
        for i in 1..<valid.count-1 {
            let maybeEmpty = valid[i-1].sid + 1
            if valid[i].sid != maybeEmpty { return maybeEmpty }
        }
        return -1
    }
}
