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
    
    func runModel() -> [[Seat]] {
        var prevSeats = self.seats
        var newSeats = self.seats
        repeat {
            prevSeats = newSeats
            newSeats = runRound(prevSeats)
        } while newSeats != prevSeats
        
        return newSeats
    }
    
    func runRound(_ seats: [[Seat]]) -> [[Seat]] {
        var newSeats = seats
        for row in 0..<seats.count {
            let rowSeats = seats[row]
            for col in 0..<rowSeats.count {
                let seat = rowSeats[col]
                if seat == .floor { continue }
                let adjacent = adjacentSeats(to: (row, col), in: seats)
                if seat == .empty && adjacent.filter({ $0 == .occupied }).count == 0 {
                    newSeats[row][col] = .occupied
                } else if seat == .occupied && adjacent.filter({ $0 == .occupied }).count >= 4 {
                    newSeats[row][col] = .empty
                }
            }
        }
        return newSeats
    }
    
    func adjacentSeats(to position: (Int, Int), in seats: [[Seat]]) -> [Seat] {
        var adjacent = [Seat]()
        for rowOffset in -1...1 {
            for colOffset in -1...1 {
                if rowOffset == 0 && colOffset == 0 { continue }
                if !seats.indices.contains(position.0 + rowOffset) { continue }
                let row = seats[position.0 + rowOffset]
                if !row.indices.contains(position.1 + colOffset) { continue }
                adjacent.append(row[position.1 + colOffset])
            }
        }
        return adjacent
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
