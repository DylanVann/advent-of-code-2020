import unittest
import ./advent/day02

const example = """1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc"""

const input = readFile("tests/tday02.txt")

suite "day02":
    test "example a":
        check(solveA(example) == 2)
    test "solution a":
        check(solveA(input) == 493)
    test "example b":
        check(solveB(example) == 1)
    test "solution b":
        check(solveB(input) == 593)
