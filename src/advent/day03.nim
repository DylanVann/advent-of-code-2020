import strutils

proc solveA*(map: string, right: int = 3, down: int = 1): int =
    let lines = splitLines(map)
    let width = lines[0].len
    var trees, x, y: int
    while y <= lines.len - 1:
        let hasTree = lines[y][x mod width] == '#'
        if hasTree: inc trees
        x += right
        y += down
    return trees

proc solveB*(map: string, slopes: openArray[(int, int)] = [
            (1, 1),
            (3, 1),
            (5, 1),
            (7, 1),
            (1, 2),
        ]): int =
    result = 1
    for slope in slopes:
        let (right, down) = slope
        let hitTrees = solveA(map, right, down)
        result *= hitTrees
    return result
