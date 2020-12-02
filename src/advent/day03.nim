import strutils

proc solveA*(map: string, right: int, down: int): int =
    var lines = splitLines(map)
    let width = lines[0].len
    var trees = 0
    var x = 0
    var y = 0
    while y <= lines.len - 1:
        let hasTree = lines[y][x mod width] == '#'
        if (hasTree):
            inc trees
        x += right
        y += down
    return trees

proc solveB*(map: string, slopes: openArray[(int, int)]): int =
    result = 1
    for slope in slopes:
        let (right, down) = slope
        let hitTrees = solveA(map, right, down)
        result *= hitTrees
    return result
