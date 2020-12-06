import unittest
import ./advent/day06

const example = """abc

a
b
c

ab
ac

a
a
a
a

b"""

const input = readFile("tests/tday06.txt")

suite "day06":
    test "example a":
        check(solveA(example) == 11)
    test "solution a":
        check(solveA(input) == 6291)
    test "example b":
        check(solveB(example) == 6)
    test "solution b":
        check(solveB(input) == 615)
