import Foundation

struct PortComputer {
    var memory = [Int: Int]()
    var instructions: [Instruction]

    init(_ data: [String]) {
        instructions = data.map { Instruction($0) }
    }
    
    mutating func run() {
        var currentMask: Mask?
        for instruction in instructions {
            switch instruction {
            case .mask(let mask):
                currentMask = Mask(mask)
            case .mem(let address, let value):
                memory[address] = currentMask?.apply(to: value)
            }
        }
    }
    
    mutating func runV2() {
        var currentMask: MaskV2?
        for instruction in instructions {
            switch instruction {
            case .mask(let mask):
                currentMask = MaskV2(mask)
            case .mem(let address, let value):
                for addr in currentMask!.apply(to: address) {
                    memory[addr] = value
                }
            }
        }
    }
    
    var memsum: Int {
        memory.reduce(0, { $0 + $1.value } )
    }
    
    struct Mask {
        var mask: String
        var ones: UInt64
        var zeros: UInt64

        init(_ string: String) {
            mask = string
            let onlyOnes = mask.replacingOccurrences(of: "X", with: "0")
            ones = UInt64(onlyOnes, radix: 2)!
            let onlyZeros = mask.replacingOccurrences(of: "X", with: "1")
            zeros = UInt64(onlyZeros, radix: 2)!
        }
        
        func apply(to value: Int) -> Int {
            let bits: UInt64 = UInt64(value)
            let result = (bits | ones) & zeros
            return Int(result)
        }
    }
    
    struct MaskV2 {
        var mask: String
        
        init(_ string: String) {
            // Make v2 mask combinations compatible with v1
            mask = string.replacingOccurrences(of: "X", with: "?").replacingOccurrences(of: "0", with: "X")
        }
        
        func apply(to value: Int) -> [Int] {
            let maskCombos = masks(mask)
            let results = maskCombos.map { $0.apply(to: value) }
            return results
        }
        
        func masks(_ currentMask: String) -> [Mask] {
            guard let index = currentMask.firstIndex(of: "?") else { return [Mask(currentMask)] }
            let replaced = ["0","1"].map { currentMask.replacingCharacters(in: index...index, with: $0) }
            let allCombinations = replaced.flatMap({ masks($0) })
            return allCombinations
        }
        
    }
    
    enum Instruction {
        case mask(String)
        case mem(Int, Int)

        init(_ ins: String) {
            let comp = ins.components(separatedBy: " = ")
            if comp[0] == "mask" {
                self = .mask(comp[1])
            } else {
                let chars = CharacterSet(charactersIn: "mem[]")
                let address = Int(comp[0].trimmingCharacters(in: chars))!
                let value = Int(comp[1])!
                self = .mem(address, value)
            }
        }
    }
}
