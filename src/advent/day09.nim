import strutils
import system
import sequtils
import itertools

proc getInvalidNumber(input: string, window: int = 5): int =
    let lines = input.splitLines.map(parseInt)
    for numbers in lines.windowed(window + 1):
        let allowedNumbers = numbers[0..^2]
        let checkNumber = numbers[^1]
        var foundNumber = false
        for allowedNumber in allowedNumbers:
            let target = checkNumber - allowedNumber
            if allowedNumbers.contains(target):
                foundNumber = true
        if not foundNumber:
            return checkNumber

proc solveA*(input: string, window: int = 25): int = 
    return getInvalidNumber(input, window)

proc solveB*(input: string, window: int = 25): int =
    let lines = input.splitLines.map(parseInt)
    let invalidNumber = getInvalidNumber(input, window)
    for i in 0..(lines.len-1):
        var index = i
        var sum = 0
        var smallest = high(int)
        var largest = -high(int)
        while true:
            if i > lines.len - 1: break
            let nextNum = lines[index]
            if nextNum == invalidNumber: break
            sum += nextNum
            if nextNum > largest: largest = nextNum
            if nextNum < smallest: smallest = nextNum
            if sum == invalidNumber:
                return smallest + largest
            if sum > invalidNumber:
                break
            inc index
