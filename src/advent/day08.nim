import strutils
import sets
import strscans
import options

proc getLastAccBeforeLoop(input: string): int =
    let lines = input.splitLines
    var foundLines = initHashSet[int]()
    var acc = 0
    var pos = 0
    while true:
        if foundLines.contains(pos):
            return acc
        else:
            foundLines.incl(pos)
        let line = lines[pos]
        var instruction: string
        var value: int
        if line.scanf("$+ $i", instruction, value):
            if instruction == "nop":
                pos += 1
                continue
            if instruction == "acc":
                acc += value
                pos += 1
                continue
            if instruction == "jmp":
                pos += value
                continue

proc getAccAtEnd(lines: seq[string]): Option[int] =
    var foundLines = initHashSet[int]()
    var acc = 0
    var pos = 0
    while true:
        if foundLines.contains(pos):
            return none(int)
        else:
            foundLines.incl(pos)
        if pos == lines.len:
            return some(acc)
        let line = lines[pos]
        var instruction: string
        var value: int
        if line.scanf("$+ $i", instruction, value):
            if instruction == "nop":
                pos += 1
                continue
            if instruction == "acc":
                acc += value
                pos += 1
                continue
            if instruction == "jmp":
                pos += value
                continue

proc solveA*(input: string): int = 
    return getLastAccBeforeLoop(input)

proc solveB*(input: string): int =
    let lines = input.splitLines
    for i in 0..(lines.len - 1):
        let line = lines[i]

        # Parse
        var instruction: string
        var value: int
        discard line.scanf("$+ $i", instruction, value)

        # Modified
        var newLines = lines
        if instruction == "jmp":
            newLines[i] = line.replace("jmp", "nop")
        elif instruction == "nop":
            newLines[i] = line.replace("nop", "jmp")
        else:
            continue

        # Result
        let accAtEnd = getAccAtEnd(newLines)
        if accAtEnd.isSome:
            return accAtEnd.get
