import strutils
import strscans
import tables

let requiredFields = [
    "byr",
    "iyr",
    "eyr",
    "hgt",
    "hcl",
    "ecl",
    "pid",
    # "cid",
]

proc checkNumber*(value: string, min: int, max: int): bool =
    var v: int
    if scanf(value, "$i", v):
        if v < min: return false
        if v > max: return false
        return true
    else:
        return false


proc isValidField*(attr: string, value: string): bool =
    case attr:
    of "byr": return checkNumber(value, 1920, 2002)
    of "iyr": return checkNumber(value, 2010, 2020)
    of "eyr": return checkNumber(value, 2020, 2030)
    of "hgt":
        if value.endsWith("cm"):
            return checkNumber(value[0..^3], 150, 193)
        if value.endsWith("in"):
            return checkNumber(value[0..^3], 59, 76)
        return false
    of "hcl":
        if value.startsWith("#"):
            if value.len == 7:
                for c in value[1..^1]:
                    if not HexDigits.contains(c):
                        return false
                return true
        return false
    of "ecl":
        return ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(value)
    of "pid":
        if value.len != 9:
            return false
        for c in value:
            if not Digits.contains(c):
                return false
        return true
    return true


proc solveA*(input: string, validate: bool = false): int =
    let passports = input.split("\n\n")
    var validPassports = 0
    for passportString in passports:
        var passport = initTable[string, string]()
        var isValid = true
        for line in passportString.splitLines:
            for attrAndValue in line.split(" "):
                var attr, value: string
                discard scanf(attrAndValue, "$+:$+", attr, value)
                passport[attr] = value
        for attr in requiredFields:
            let hasField = passport.hasKey(attr)
            if not hasField:
                isValid = false
                break

            if validate:
                let value = passport.getOrDefault(attr)
                let valid = isValidField(attr, value)
                if not valid:
                    isValid = false
                    break
        if isValid:
            inc validPassports
    return validPassports

proc solveB*(input: string): int =
    return solveA(input, true)
