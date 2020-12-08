import Foundation

class Console {
    var bootCode: [Instruction]
    var accumulator: Int = 0
    var ip: Int = 0
    var seenIps = Set<Int>()

    init(_ bootData: [String]) {
        self.bootCode = bootData.map { Instruction($0) }
    }
    
    func boot() throws {
        self.ip = 0
        self.seenIps = []
        self.accumulator = 0
        
        repeat {
            if seenIps.contains(ip) {
                throw RuntimeError.infiniteLoop(accumulator: self.accumulator)
            }
            self.seenIps.insert(ip)

            let result = bootCode[ip].run()
            self.accumulator += result.accChange
            self.ip += result.ipChange
        } while ip < bootCode.count

        throw RuntimeError.eof(ip: ip, size: bootCode.count, accumulator: accumulator)
    }
    
    func repair() throws {
        for index in 0..<bootCode.count {
            if bootCode[index].op == .acc { continue }
            let previousOp = bootCode[index].op
            
            if bootCode[index].op == .jmp {
                bootCode[index].op = .nop
            } else {
                bootCode[index].op = .jmp
            }
            do {
                try boot()
            } catch RuntimeError.eof {
                if ip == bootCode.count {
                    throw RuntimeError.eof(ip: ip, size: bootCode.count, accumulator: accumulator)
                }
            } catch { }

            bootCode[index].op = previousOp
        }
    }
    
    enum RuntimeError: Error {
        case infiniteLoop(accumulator: Int)
        case eof(ip: Int, size: Int, accumulator: Int)
    }
}

struct Instruction {
    var op: Op
    var arg: Int
    
    init(_ instruction: String) {
        let parts = instruction.split(separator: " ").map(String.init)
        self.op = Op(rawValue: parts[0])!
        self.arg = Int(parts[1])!
    }
    
    func run() -> InstructionResult {
        switch op {
        case .acc:
            return InstructionResult(accChange: arg, ipChange: 1)
        case .jmp:
            return InstructionResult(accChange: 0, ipChange: arg)
        case .nop:
            return InstructionResult()
        }
    }

    enum Op: String {
        case nop
        case acc
        case jmp
    }
    
    struct InstructionResult {
        var accChange: Int = 0
        var ipChange: Int = 1
    }
}
