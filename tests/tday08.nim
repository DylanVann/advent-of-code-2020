import unittest
import ./advent/day08

const example = """nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6"""

const input = readFile("tests/tday08.txt")

suite "day08":
    test "example a":
        check(solveA(example) == 5)
    test "solution a":
        check(solveA(input) == 1610)
    test "example b":
        check(solveB(example) == 8)
    test "solution b":
        check(solveB(input) == 1703)
