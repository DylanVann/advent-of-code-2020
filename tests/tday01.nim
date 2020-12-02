import unittest
import ./advent/day01

const example = """1721
979
366
299
675
1456"""

const input = readFile("tests/tday01.txt")

suite "day01":
    test "example a":
        check(solveA(example) == 514579)
    test "solution a":
        check(solveA(input) == 980499)
    test "example b":
        check(solveB(example) == 241861950)
    test "solution b":
        check(solveB(input) == 200637446)
