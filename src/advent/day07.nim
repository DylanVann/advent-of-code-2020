import strutils
import sets
import tables
import sequtils
import re

type Bag = object
    name: string
    parents: ref Table[string, ref Bag]
    children: ref Table[string, (ref Bag, int)]

type BagRef = ref Bag

proc newBagRef(name: string): BagRef =
    BagRef(name: name, parents: newTable[string, BagRef](), children: newTable[string, (BagRef, int)]())

proc parseBags(input: string): Table[string, BagRef] =
    var bags = initTable[string, BagRef]()
    for line in input.splitLines:
        let matches = findAll(line, re"([[:digit:]]? ?\w* \w*) bag")
        let outerBagKey = matches[0][0..^5]
        var outerBag = bags.mgetOrPut(outerBagKey, newBagRef(outerBagKey))
        for bag in matches.filterIt(Digits.contains(it[0])):
            let count: int = parseInt($bag[0]) 
            let bagKey: string = bag[2..^5]
            var bag = bags.mgetOrPut(bagKey, newBagRef(bagKey))
            bag.parents[outerBagKey] = outerBag
            outerBag.children[bagKey] = (bag, count)
    return bags

proc solveA*(input: string): int = 
    let bags = parseBags(input)
    var uniqueParents = initHashSet[string]()
    proc getParents(parents: TableRef[string, BagRef]): bool {.discardable.} =
        for p in parents.values:
            if not uniqueParents.contains(p.name):
                uniqueParents.incl(p.name)
                discard getParents(p.parents)
    discard getParents(bags.getOrDefault("shiny gold").parents)
    return uniqueParents.len

proc solveB*(input: string): int =
    let bags = parseBags(input)
    proc getChildCount(children: TableRef[string, (BagRef, int)]): int =
        for c in children.values:
            let (bag, count) = c
            result += count + count * getChildCount(bag.children)
    return getChildCount(bags.getOrDefault("shiny gold").children)
