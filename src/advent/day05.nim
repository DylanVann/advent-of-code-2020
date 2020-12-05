import strutils
import sequtils

proc converge*(input: string, max: int): int =
    var rMin: int = 0
    var rMax: int = max
    for v in input:
        let halfRange: int = (rMax - rMin) div 2
        if v == 'F' or v == 'L': rMax = rMax - halfRange
        if v == 'B' or v == 'R': rMin = rMin + halfRange
    return rMin

proc seatId*(input: string): int =
    let row = input[0..6].converge(128)
    let col = input[^3..^1].converge(8)
    return (row * 8) + col

proc solveA*(input: string): int = input.split("\n").map(seatId).foldl(max(a, b))

proc solveB*(input: string): int =
    let seatIds = input.split("\n").map(seatId)
    let max = seatIds.foldl(max(a, b))
    for id in 0 .. max:
        if not seatIds.contains(id) and seatIds.contains(id - 1) and seatIds.contains(id + 1):
            return id
