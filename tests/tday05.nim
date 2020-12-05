import unittest
import ./advent/day05

const example = """BFFFBBFRRR
FFFBBBFRRR
BBFFBBFRLL"""

const input = readFile("tests/tday05.txt")

suite "day05":
    test "example a":
        check(converge("BFFFBBF", 128) == 70)
        check(converge("FFFBBBF", 128) == 14)
        check(converge("BBFFBBF", 128) == 102)
        check(converge("RRR", 8) == 7)
        check(converge("RLL", 8) == 4)
        check(seatId("BFFFBBFRRR") == 567)
        check(solveA(example) == 820)
    test "solution a":
        check(solveA(input) == 953)
    test "example b":
        check(solveB(example) == 0)
    test "solution b":
        check(solveB(input) == 615)
