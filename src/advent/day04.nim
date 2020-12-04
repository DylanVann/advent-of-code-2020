import strutils
import strscans
import tables
import sequtils

let requiredFields = [
    "byr",
    "iyr",
    "eyr",
    "hgt",
    "hcl",
    "ecl",
    "pid",
]

proc checkNumber*(value: string, min: int, max: int): bool =
    var v: int
    return scanf(value, "$i", v) and v >= min and v <= max

proc isValidField*(attr: string, value: string): bool =
    case attr:
    of "byr": return value.checkNumber(1920, 2002)
    of "iyr": return value.checkNumber(2010, 2020)
    of "eyr": return value.checkNumber(2020, 2030)
    of "hgt":
        return (value.endsWith("cm") and value[0..^3].checkNumber(150, 193)) or
            (value.endsWith("in") and value[0..^3].checkNumber(59, 76))
    of "hcl":
        return value.startsWith("#") and value.len == 7 and
            value[1..^1].allIt(HexDigits.contains(it))
    of "ecl":
        return ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(value)
    of "pid":
        return value.len == 9 and value.allIt(Digits.contains(it))
    return true


proc solveA*(input: string, validate: bool = false): int =
    return input.split("\n\n").filter(proc (passportString: string): bool =
        var passport = initTable[string, string]()
        for line in passportString.splitLines:
            for attrAndValue in line.split(" "):
                var attr, value: string
                discard scanf(attrAndValue, "$+:$+", attr, value)
                passport[attr] = value
        for attr in requiredFields:
            if not passport.hasKey(attr):
                return false
            if validate and not isValidField(attr, passport.getOrDefault(attr)):
                return false
        return true
    ).len

proc solveB*(input: string): int =
    return solveA(input, true)
