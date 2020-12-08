import strutils
import sets
import tables
import re

type Bag = object
    name: string
    parents: ref Table[string, ref Bag]
    children: ref Table[string, (ref Bag, int)]

type BagRef = ref Bag

proc newBagRef(name: string): BagRef =
    BagRef(name: name, parents: newTable[string, BagRef](), children: newTable[string, (BagRef, int)]())

proc parseBags(input: string): Table[string, ref Bag] =
    var bags = initTable[string, ref Bag]()
    let lines = input.splitLines
    for line in lines:
        let matches = findAll(line, re"([[:digit:]]? ?\w* \w*) bag")
        let outerBagKey = matches[0][0..^5]
        var outerBag = bags.mgetOrPut(outerBagKey, newBagRef(outerBagKey))
        for bag in matches:
            if bag == " no other bag":
                discard
            elif Digits.contains(bag[0]):
                let count: int = parseInt($bag[0]) 
                let bagKey: string = bag[2..^5]
                var bag = bags.mgetOrPut(bagKey, newBagRef(bagKey))
                bag.parents[outerBagKey] = outerBag
                outerBag.children[bagKey] = (bag, count)
            else:
                discard
    return bags

proc solveA*(input: string): int = 
    let bags = parseBags(input)
    var uniqueParents = initHashSet[string]()
    proc getParents(parents: TableRef[string, ref Bag]): bool {.discardable.} =
        for p in parents.values:
            if not uniqueParents.contains(p.name):
                uniqueParents.incl(p.name)
                discard getParents(p.parents)
    discard getParents(bags.getOrDefault("shiny gold").parents)
    return uniqueParents.len

proc solveB*(input: string): int =
    let bags = parseBags(input)
    proc getChildCount(children: TableRef[string, (BagRef, int)]): int =
        var childCount = 0
        for c in children.values:
            let (bag, count) = c
            childCount += count
            childCount += count * getChildCount(bag.children)
        return childCount
    return getChildCount(bags.getOrDefault("shiny gold").children)
