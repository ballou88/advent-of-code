with open("input.txt") as file:
    input = file.read()
print(input)
# input = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53\nCard 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19\nCard 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1\nCard 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83\nCard 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36\nCard 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11"
total = 0

for line in input.split("\n")[:-1]:
    win_num, nums = line.split(": ")[1].split(" | ")
    win_num = win_num.split(" ")
    nums = nums.split()
    count = 0
    for num in nums:
        if num in win_num:
            count += 1
    if count > 0:
        total += 2 ** (count - 1)


print(total)
