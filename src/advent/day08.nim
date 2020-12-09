import strutils
import sets
import strscans
import options

proc parseLine(line: string): (string, int) =
    var instruction: string
    var value: int
    if line.scanf("$+ $i", instruction, value): return (instruction, value)

proc getAccAtEnd(lines: seq[string], allowCycle: bool): Option[int] =
    var foundLines = initHashSet[int]()
    var acc = 0
    var pos = 0
    while true:
        if pos == lines.len:
            return some(acc)
        elif foundLines.contains(pos):
            if allowCycle: return some(acc)
            return none(int)
        else:
            foundLines.incl(pos)
        let line = lines[pos]
        let (instruction, value) = line.parseLine
        case instruction:
        of "nop": pos += 1
        of "jmp": pos += value
        of "acc": 
            acc += value
            pos += 1

proc solveA*(input: string): int = 
    return getAccAtEnd(input.splitLines, true).get

proc solveB*(input: string): int =
    let lines = input.splitLines
    for i in 0..(lines.len - 1):
        let line = lines[i]
        let (instruction, value) = line.parseLine
        if not ["jmp", "nop"].contains(instruction): continue
        var modifiedLines = lines
        if instruction == "jmp": modifiedLines[i] = line.replace("jmp", "nop")
        if instruction == "nop": modifiedLines[i] = line.replace("nop", "jmp")
        let accAtEnd = getAccAtEnd(modifiedLines, false)
        if accAtEnd.isSome:
            return accAtEnd.get
