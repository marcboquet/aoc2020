import Foundation

struct TobogganMap {
    var grid: [Row]
    var size: (width: Int, height: Int)
    
    init(map: [String]) {
        self.grid = map.map { Row($0) }
        self.size = (width: self.grid.first!.size, height: self.grid.count)
    }
    
    func coordinate(at: (x: Int, y: Int)) -> Coordinate {
        if (at.y >= size.height) {
            return Coordinate.end
        }

        let point = (x: at.x % size.width, y: at.y)

        return grid[point.y].coordinates[point.x]
    }

    var description: String {
        return grid.map { $0.description }.joined(separator: "\n")
    }

    struct Row {
        var coordinates: [Coordinate]
        var size: Int
        
        init(_ row: String) {
            self.coordinates = row.map { Coordinate(rawValue: $0)! }
            self.size = self.coordinates.count
        }
        
        var description: String {
            return String(coordinates.map{$0.rawValue})
        }
    }

    enum Coordinate: Character {
        case start = "!"
        case empty = "."
        case tree = "#"
        case end = "_"
    }
}

struct Toboggan {
    var map: TobogganMap
    
    func sendIt(slope: (Int, Int)) -> Result {
        var position: (x: Int, y: Int) = (x: 0, y: 0)
        var coordinate = TobogganMap.Coordinate.start
        var result = Result()
        repeat {
            coordinate = map.coordinate(at: position)
            position = (x: position.x + slope.0, y: position.y + slope.1)
            result.add(coordinate)
        } while coordinate != TobogganMap.Coordinate.end

        return result
    }

    struct Result {
        var trees: Int = 0
        
        mutating func add(_ coordinate: TobogganMap.Coordinate) {
            trees += coordinate == TobogganMap.Coordinate.tree ? 1 : 0
        }
    }
}
