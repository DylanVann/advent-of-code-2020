import strutils
import strscans
import tables

type MinMaxCount = tuple
    min: int
    max: int
    count: int

proc solveA*(input: string): int =
    var lines = splitLines(input)
    var validPasswords = 0
    for line in lines:
        var rulesString: string
        var passwordString: string
        discard scanf(line, "$+: $+", rulesString, passwordString)
        var letter: string
        var min: int
        var max: int
        discard scanf(rulesString, "$i-$i $w", min, max, letter)
        var rules = initTable[char, MinMaxCount]()
        rules[letter[0]] = (min, max, 0)
        for letter in passwordString:
            if (rules.contains(letter)):
                var rule = rules.getOrDefault(letter)
                rules[letter] = (rule.min, rule.max, rule.count + 1)
        for letter, rule in rules.pairs:
            if (rule.count >= rule.min and rule.count <= rule.max):
                inc validPasswords
    return validPasswords

type RuleInfo = tuple
    posA: int
    posB: int
    count: int

proc solveB*(input: string): int =
    var lines = splitLines(input)
    var validPasswords = 0
    for line in lines:
        var rulesString: string
        var passwordString: string
        discard scanf(line, "$+: $+", rulesString, passwordString)
        var letter: string
        var posA: int
        var posB: int
        discard scanf(rulesString, "$i-$i $w", posA, posB, letter)
        var rules = initTable[char, RuleInfo]()
        rules[letter[0]] = (posA - 1, posB - 1, 0)
        var isValid = true
        for letter, rule in rules.pairs:
            if (passwordString[rule.posA] == letter and passwordString[rule.posB] == letter):
                isValid = false
                break
            if (passwordString[rule.posA] != letter and passwordString[rule.posB] != letter):
                isValid = false
                break
        if (isValid):
            inc validPasswords
    return validPasswords