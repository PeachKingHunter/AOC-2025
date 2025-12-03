input = "1-29,22-33,17-99,19-19,19-21,4185961-4199999, 565656-565659,1111111100-1111111122,121125654-123123188"


def haveTwice(valStr):
    # Remove inferior to 10
    if len(valStr) == 1:
        return 0

    # Remove zeros
    min = 0
    while (valStr[min] == 0):
        min += 1

    size = len(valStr) - min

    # for groups of size / i character that duplicate
    for i in range(2, int(size)+1):
        if size % i != 0:
            continue

        areaSize = size / i
        nbPb = 0

        # cmp all groups
        lastStr = valStr[min: int(areaSize) + min]
        for n in range(i):
            newStr = valStr[min + int(areaSize) *
                            n: int(areaSize) * (n+1) + min]
            if newStr == lastStr:
                nbPb += 1

        # a group of size / i is repeated in the whole valStr
        if nbPb == i:
            print(valStr)
            return 1
    return 0

    # # part 1
    # cuttedStr1 = valStr[min:int(size/2+min-1)+1]
    # cuttedStr2 = valStr[int(size/2+min):min+size]
    # if cuttedStr1 == cuttedStr2:
    #     return 1
    # return 0


# ---- Main ---- #
splited = input.split(',')

cpt = 0
listNums = []

# For each interval in the input
for interval in splited:
    reSplit = interval.split('-')

    # All numbers of the interval -> verif
    for val in range(int(reSplit[0]), int(reSplit[1])+1):
        valStr = str(val)

        if haveTwice(valStr) == 1:
            listNums.append(int(valStr))

# How much invalids
print("-> " + str(len(listNums)))

# Sum all invalids && print the result
res = 0
for val in listNums:
    res += val
print(res)
