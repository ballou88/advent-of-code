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

    while i < len(arr):
        # look for number
        while j < len(arr[i]):
            if arr[i][j] not in VALID_NUMS:
                if is_part and start is not None:
                    part_nums.append(int("".join(arr[i][start:j])))
                start = None
                is_part = False
                j += 1
                continue
            if arr[i][j] in VALID_NUMS:
                if start is None:
                    start = j
                if borders_symbol(arr, (i, j)):
                    is_part = True
            j += 1
        if is_part and start is not None:
            part_nums.append(int("".join(arr[i][start:j])))
            start = None
            is_part = False
        i += 1
        j = 0
    print(sum(part_nums))

    # until a adjacent symbol is found proceed through number
    # if adjacent symbol found add number to list


def borders_symbol(arr, point):
    y, x = point
    # up
    if y > 0 and arr[y - 1][x] not in NON_SYM:
        return True
    # up-left
    if y > 0 and x > 0 and arr[y - 1][x - 1] not in NON_SYM:
        return True
    # left
    if x > 0 and arr[y][x - 1] not in NON_SYM:
        return True
    # down-left
    if y < len(arr) - 2 and x > 0 and arr[y + 1][x - 1] not in NON_SYM:
        return True
    # down
    if y < len(arr) - 2 and arr[y + 1][x] not in NON_SYM:
        return True
    # down-right
    if y < len(arr) - 2 and x < len(arr[0]) - 2 and arr[y + 1][x + 1] not in NON_SYM:
        return True
    # right
    if x < len(arr[0]) - 2 and arr[y][x + 1] not in NON_SYM:
        return True
    # up-right
    if y > 0 and x < len(arr[0]) - 2 and arr[y - 1][x + 1] not in NON_SYM:
        return True
    return False


input = "467..114..\n...*......\n..35..633.\n......#...\n617*......\n.....+.58.\n..592.....\n......755.\n...$.*....\n.664.598.."
with open("input.txt") as file:
    input = file.read()
run(input)
