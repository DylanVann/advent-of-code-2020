import strutils
import sequtils
import itertools

proc solveA*(input: string): int =
    let ints = input.splitLines.map(parseInt)
    for arr in ints.combinations(2):
        var a: int = arr[0]
        var b: int = arr[1]
        if a + b == 2020:
            return a * b

proc solveB*(input: string): int =
    let ints = input.splitLines.map(parseInt)
    for arr in ints.combinations(3):
        var a: int = arr[0]
        var b: int = arr[1]
        var c: int = arr[2]
        if a + b + c == 2020:
            return a * b * c