import unittest
import ./advent/day09

const example = """35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576"""

const input = readFile("tests/tday09.txt")

suite "day09":
    test "example a":
        check(solveA(example, 5) == 127)
    test "solution a":
        check(solveA(input) == 22477624)
    test "example b":
        check(solveB(example, 5) == 62)
    test "solution b":
        check(solveB(input) == 2980044)
