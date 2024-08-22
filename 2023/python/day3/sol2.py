from collections import defaultdict


VALID_NUMS = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
NON_SYM = VALID_NUMS + ["."]


def run(input):
    arr = []
    for line in input.split("\n"):
        arr.append(list(line))
    i, j = 0, 0
    start = None
    is_part = False
    part_nums = []
    part_syms = set()
    sym_part_dict = defaultdict(set)
    while i < len(arr):
        # look for number
        while j < len(arr[i]):
            if arr[i][j] not in VALID_NUMS:
                if is_part and start is not None:
                    num = int("".join(arr[i][start:j]))
                    part_nums.append(num)
                    for sym in part_syms:
                        sym_part_dict[sym].add(num)
                start = None
                is_part = False
                j += 1
                part_syms.clear()
                continue
            if arr[i][j] in VALID_NUMS:
                if start is None:
                    start = j
                valid, symbol = borders_symbol(arr, (i, j))
                if valid:
                    part_syms.add(symbol)
                    is_part = True
            j += 1
        if is_part and start is not None:
            num = int("".join(arr[i][start:j]))
            part_nums.append(num)
            is_part = False
            for sym in part_syms:
                sym_part_dict[sym].add(num)
        part_syms.clear()
        i += 1
        j = 0
    print(sym_part_dict)
    gear_product = 0
    for y, x in sym_part_dict.keys():
        if arr[y][x] == "*" and len(sym_part_dict[(y, x)]) == 2:
            k, l = list(sym_part_dict[(y, x)])
            gear_product += k * l
    print(gear_product)

    print(sum(part_nums))

    # until a adjacent symbol is found proceed through number
    # if adjacent symbol found add number to list


def borders_symbol(arr, point):
    y, x = point
    # up
    if y > 0 and arr[y - 1][x] not in NON_SYM:
        return (True, (y - 1, x))
    # up-left
    if y > 0 and x > 0 and arr[y - 1][x - 1] not in NON_SYM:
        return (True, (y - 1, x - 1))
    # left
    if x > 0 and arr[y][x - 1] not in NON_SYM:
        return (True, (y, x - 1))
    # down-left
    if y < len(arr) - 2 and x > 0 and arr[y + 1][x - 1] not in NON_SYM:
        return (True, (y + 1, x - 1))
    # down
    if y < len(arr) - 2 and arr[y + 1][x] not in NON_SYM:
        return (True, (y + 1, x))
    # down-right
    if y < len(arr) - 2 and x < len(arr[0]) - 2 and arr[y + 1][x + 1] not in NON_SYM:
        return (True, (y + 1, x + 1))
    # right
    if x < len(arr[0]) - 2 and arr[y][x + 1] not in NON_SYM:
        return (True, (y, x + 1))
    # up-right
    if y > 0 and x < len(arr[0]) - 2 and arr[y - 1][x + 1] not in NON_SYM:
        return (True, (y - 1, x + 1))
    return (False, None)


# input = "467..114..\n...*......\n..35..633.\n......#...\n617*......\n.....+.58.\n..592.....\n......755.\n...$.*....\n.664.598.."
with open("input.txt") as file:
    input = file.read()
run(input)
