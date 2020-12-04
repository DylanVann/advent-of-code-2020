import unittest
import ./advent/day03

const example = """..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#"""

const input = readFile("tests/tday03.txt")

suite "day03":
    test "example a":
        check(solveA(example) == 7)
    test "solution a":
        check(solveA(input) == 167)
    test "example b":
        check(solveB(example) == 336)
    test "solution b":
        check(solveB(input) == 736527114)
