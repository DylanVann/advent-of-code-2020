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
        check(solveA(example, 3, 1) == 7)
    test "solution a":
        check(solveA(input, 3, 1) == 167)
    test "example b":
        const slopes = [
            (1, 1),
            (3, 1),
            (5, 1),
            (7, 1),
            (1, 2),
        ]
        check(solveB(example, slopes) == 336)
    test "solution b":
        const slopes = [
            (1, 1),
            (3, 1),
            (5, 1),
            (7, 1),
            (1, 2),
        ]
        check(solveB(input, slopes) == 736527114)
