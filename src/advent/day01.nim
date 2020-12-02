import strutils
import sequtils
import itertools

proc solveA*(input: string): int =
    var lines = splitLines(input)
    var ints = map(lines, parseInt)
    for arr in combinations(ints, 2):
        var a: int = arr[0]
        var b: int = arr[1]
        if (a + b == 2020):
            return a * b

proc solveB*(input: string): int =
    var lines = splitLines(input)
    var ints = map(lines, parseInt)
    for arr in combinations(ints, 3):
        var a: int = arr[0]
        var b: int = arr[1]
        var c: int = arr[2]
        if (a + b + c == 2020):
            return a * b * c