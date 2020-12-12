import Foundation

struct FerrySeats {
    var seats: [[Seat]]
    init(_ data: [String]) {
        var seats = [[Seat]]()
        data.forEach({
            let row = $0.map { Seat(rawValue: $0)! }
            seats.append(row)
        })
        self.seats = seats
    }
    
    func runModel(extended: Bool = false) -> [[Seat]] {
        var prevSeats = self.seats
        var newSeats = self.seats
        repeat {
            prevSeats = newSeats
            newSeats = runRound(prevSeats, extended: extended)
        } while newSeats != prevSeats
        
        return newSeats
    }
    
    func runRound(_ seats: [[Seat]], extended: Bool) -> [[Seat]] {
        var newSeats = seats
        let maxOccupied = (extended ? 5 : 4)
        for row in 0..<seats.count {
            let rowSeats = seats[row]
            for col in 0..<rowSeats.count {
                let seat = rowSeats[col]
                if seat == .floor { continue }
                let max = (seat == .empty ? 1 : maxOccupied)
                let adjacent = adjacentSeats(to: (row, col), in: seats, max: max, extended: extended)
                if seat == .empty && adjacent == 0 {
                    newSeats[row][col] = .occupied
                } else if seat == .occupied && adjacent >= maxOccupied {
                    newSeats[row][col] = .empty
                }
            }
        }
        return newSeats
    }
    
    func adjacentSeats(to position: (Int, Int), in seats: [[Seat]], max: Int, extended: Bool) -> Int {
        var occupied = 0
        let limits = (seats.count-1, seats[0].count-1)
        for rowOffset in [-1,0,1] {
            if position.0 == 0 && rowOffset == -1 { continue }
            if position.0 == limits.0 && rowOffset == 1 { return occupied }
            for colOffset in [-1,0,1] {
                if rowOffset == 0 && colOffset == 0 { continue }
                if position.1 == 0 && colOffset == -1 { continue }
                if position.1 == limits.1 && colOffset == 1 { continue }

                let seat = seats[position.0 + rowOffset][position.1 + colOffset]
                if seat == .occupied {
                    occupied += 1
                } else if extended && seat == .floor {
                    var round = 2
                    var otherOffset: (Int, Int)
                    while true {
                        otherOffset = (position.0 + rowOffset * round, position.1 + colOffset * round)
                        if otherOffset.0 < 0 || otherOffset.1 < 0 || otherOffset.0 > limits.0 || otherOffset.1 > limits.1 {
                            break
                        }
                        let otherSeat = seats[otherOffset.0][otherOffset.1]
                        if otherSeat == .occupied {
                            occupied += 1
                            break
                        }
                        if otherSeat == .empty {
                            break
                        }
                        round += 1
                    }
                    
                }
                if occupied >= max { return occupied }
            }
        }
        return occupied
    }
    
    func occupied(seats: [[Seat]]) -> Int {
        seats.reduce(0, { result, row in
            let occ = row.reduce(0, { result, seat in
                result + (seat == .occupied ? 1 : 0)
            })
            return result + occ
        })
    }
    
    enum Seat: Character {
        case floor = "."
        case empty = "L"
        case occupied = "#"
    }
}
