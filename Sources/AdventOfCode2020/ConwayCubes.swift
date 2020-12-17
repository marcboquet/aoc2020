import Foundation

struct ConwayCubes {
    var activeCubes = [Coordinate : Cube]()
    var minCoord = Coordinate()
    var maxCoord = Coordinate()
    var hyper = false

    init(_ data: [String], hyper: Bool = false) {
        for y in 0..<data.count {
            let line = data[y]
            for x in 0..<line.count {
                if line[line.index(line.startIndex, offsetBy: x)] == "#" {
                    let coord = Coordinate(coordinate: (x: x, y: y, z: 0, w: 0))
                    activeCubes[coord] = .active
                    maxCoord.replaceMax(coord: coord)
                    minCoord.replaceMin(coord: coord)
                }
            }
        }
        self.hyper = hyper
    }
    
    mutating func simulate(cycles: Int) {
        for _ in 1...cycles {
            var newActiveCubes = activeCubes
            var newMaxCoord = maxCoord
            var newMinCoord = minCoord
            for x in minCoord.coordinate.x!-1...maxCoord.coordinate.x!+1 {
                for y in minCoord.coordinate.y!-1...maxCoord.coordinate.y!+1 {
                    for z in minCoord.coordinate.z!-1...maxCoord.coordinate.z!+1 {
                        var wRange = 0...0
                        if hyper {
                            wRange = minCoord.coordinate.w!-1...maxCoord.coordinate.w!+1
                        }
                        for w in wRange {
                            let coord = Coordinate(coordinate: (x: x, y: y, z: z, w: w), hyper: hyper)
                            let cube = activeCubes[coord, default: .inactive]
                            var activeNeighbors = 0
                            for neighbor in coord.adjacent() {
                                if activeCubes[neighbor] == .some(.active) {
                                    activeNeighbors += 1
                                    if activeNeighbors > 3 { break }
                                }
                            }
                            if cube == .inactive && activeNeighbors == 3 {
                                newActiveCubes[coord] = .active
                                newMaxCoord.replaceMax(coord: coord)
                                newMinCoord.replaceMin(coord: coord)
                            } else if cube == .active && activeNeighbors != 2 && activeNeighbors != 3 {
                                newActiveCubes.removeValue(forKey: coord)
                            }
                        }
                    }
                }
            }
            activeCubes = newActiveCubes
            maxCoord = newMaxCoord
            minCoord = newMinCoord
        }
    }
    
    struct Coordinate : Hashable {
        var coordinate: (x: Int?, y: Int?, z: Int?, w: Int?)
        var hyper = false
        
        init() {
            self.coordinate = (x: nil, y: nil, z: nil, w: nil)
        }
        init(coordinate coord: (x: Int, y: Int, z: Int)) {
            self.coordinate = (x: coord.x, y: coord.y, z: coord.z, w: nil)
        }
        init(coordinate coord: (x: Int, y: Int, z: Int, w: Int)) {
            self.coordinate = (x: coord.x, y: coord.y, z: coord.z, w: coord.w)
            self.hyper = true
        }
        init(coordinate coord: (x: Int, y: Int, z: Int, w: Int), hyper: Bool) {
            self.coordinate = (x: coord.x, y: coord.y, z: coord.z, w: coord.w)
            self.hyper = hyper
        }

        static func == (lhs: ConwayCubes.Coordinate, rhs: ConwayCubes.Coordinate) -> Bool {
            return lhs.coordinate == rhs.coordinate
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(coordinate.x)
            hasher.combine(coordinate.y)
            hasher.combine(coordinate.z)
            hasher.combine(coordinate.w)
        }
        
        func adjacent() -> [Coordinate] {
            var coords = [Coordinate]()
            for x in coordinate.x!-1...coordinate.x!+1 {
                for y in coordinate.y!-1...coordinate.y!+1 {
                    for z in coordinate.z!-1...coordinate.z!+1 {
                        var wRange = 0...0
                        if hyper {
                            wRange = coordinate.w!-1...coordinate.w!+1
                        }
                        for w in wRange {
                            let neighbor = Coordinate(coordinate: (x: x, y: y, z: z, w: w))
                            if neighbor != self {
                                coords.append(neighbor)
                            }
                        }
                    }
                }
            }
            return coords
        }
        
        mutating func replaceMax(coord: Coordinate) {
            if coordinate.x ?? Int.min < coord.coordinate.x! {
                coordinate.x = coord.coordinate.x
            }
            if coordinate.y ?? Int.min < coord.coordinate.y! {
                coordinate.y = coord.coordinate.y
            }
            if coordinate.z ?? Int.min < coord.coordinate.z! {
                coordinate.z = coord.coordinate.z
            }
            if coordinate.w ?? Int.min < coord.coordinate.w! {
                coordinate.w = coord.coordinate.w
            }
        }
        
        mutating func replaceMin(coord: Coordinate) {
            if coordinate.x ?? Int.max > coord.coordinate.x! {
                coordinate.x = coord.coordinate.x
            }
            if coordinate.y ?? Int.max > coord.coordinate.y! {
                coordinate.y = coord.coordinate.y
            }
            if coordinate.z ?? Int.max > coord.coordinate.z! {
                coordinate.z = coord.coordinate.z
            }
            if coordinate.w ?? Int.max > coord.coordinate.w! {
                coordinate.w = coord.coordinate.w
            }
        }
    }
    
    enum Cube {
        case active
        case inactive
    }
}
