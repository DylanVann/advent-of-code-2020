import strutils
import sequtils

proc solveA*(input: string): int = 
    var uniquesInGroups = 0
    let groups = input.split("\n\n")
    for group in groups:
        let uniques = group.filterIt(it != '\n').deduplicate().len
        uniquesInGroups += uniques
    return uniquesInGroups

proc solveB*(input: string): int =
    result = 0
    let groups = input.split("\n\n")
    for group in groups:
        let people = group.split("\n")
        let uniqueAnswers = group.filterIt(it != '\n').deduplicate()
        for answer in uniqueAnswers:
            let allPeopleAnswered = people.allIt(it.contains(answer))
            if allPeopleAnswered:
                result += 1
