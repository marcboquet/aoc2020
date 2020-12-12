import Foundation

struct FerryNavigation {
    var instructions: [Instruction]
    var position: (Int, Int) = (0, 0)
    
    init(_ data: [String]) {
        instructions = data.map { Instruction($0) }
    }
    
    mutating func navigate() {
        position = (0, 0)
        var heading: Direction = (1, 0)
        
        for instruction in instructions {
            (position, heading) = instruction.apply(to: position, heading)
        }
    }
    
    mutating func navigateWaypoint() {
        position = (0, 0)
        var waypoint = (10, 1)
        
        for instruction in instructions {
            (position, waypoint) = instruction.applyWaypoint(to: position, waypoint)
        }
    }
    
    var manhattan: Int { abs(position.0) + abs(position.1) }
    
    typealias Direction = (Int, Int)
    
    struct Instruction {
        var action: Action
        init(_ data: String) {
            let ins = data.first!
            let val = Int(String(data[data.index(after: data.startIndex)...]))!
            switch ins {
            case "N": action = Action.move((0, 1), val)
            case "S": action = Action.move((0,-1), val)
            case "E": action = Action.move((1,0), val)
            case "W": action = Action.move((-1,0), val)
            case "L": action = Action.rotate(-val)
            case "R": action = Action.rotate(val)
            case "F": action = Action.forward(val)
            default: action = Action.none
            }
        }
        
        func apply(to position: (Int, Int), _ heading: Direction) -> ((Int, Int), Direction) {
            var position = position
            var heading = heading
            
            switch action {
            case .move(let direction, let distance):
                position = (position.0 + direction.0 * distance, position.1 + direction.1 * distance)
            case .rotate(let angle):
                let rotations: Int = angle / 90
                switch rotations % 4 {
                case 1, -3:
                    heading = (heading.1, -heading.0)
                case 2, -2:
                    heading = (-heading.0, -heading.1)
                case 3, -1:
                    heading = (-heading.1, heading.0)
                default: break
                }
            case .forward(let distance):
                position = (position.0 + heading.0 * distance, position.1 + heading.1 * distance)
            default: break
            }
            
            return (position, heading)
        }
        
        func applyWaypoint(to position: (Int, Int), _ waypoint: Direction) -> ((Int, Int), Direction) {
            var position = position
            var waypoint = waypoint
            
            switch action {
            case .move(let direction, let distance):
                waypoint = (waypoint.0 + direction.0 * distance, waypoint.1 + direction.1 * distance)
            case .rotate(let angle):
                let rotations: Int = angle / 90
                switch rotations % 4 {
                case 1, -3:
                    waypoint = (waypoint.1, -waypoint.0)
                case 2, -2:
                    waypoint = (-waypoint.0, -waypoint.1)
                case 3, -1:
                    waypoint = (-waypoint.1, waypoint.0)
                default: break
                }
            case .forward(let distance):
                position = (position.0 + waypoint.0 * distance, position.1 + waypoint.1 * distance)
            default: break
            }
            
            return (position, waypoint)
        }
        
        enum Action {
            case move(Direction, Int)
            case rotate(Int)
            case forward(Int)
            
            case none
        }
    }
}
