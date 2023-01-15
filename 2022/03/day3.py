# PART 1 fns
def process_line(line):
    left, right = split(line)
    inter = find_intersect(left, right)
    priority = char_to_priority(inter)
    return priority

# split line to (left, right)
def split(line):
    half = int(len(line)/2)
    return (line[:half], line[half:])

# find character intersects between left and right
def find_intersect(left, right):
    inter = ''
    for char in left:
        if char in right and not char in inter:
            inter += char
    return inter


def char_to_priority(char):
    o = ord(char)
    # a:z 97:122   A:Z 65:90
    return o - 96 if o >= 97 else o - 38

# PART 2 fn
def process_group(line, lineP, linePP):
    inter12 = find_intersect(line, lineP)
    inter123 = find_intersect(inter12, linePP)
    return char_to_priority(inter123)

# EXECUTE
sum = 0 # sum of items shared in both compartments
sum_badges = 0 # sum of badges in every triplet of elves
lineP = '' # previous file line
linePP = '' # preprevious file line
i = 0
with open('input.txt', encoding='utf-8') as file:
    for line in file:
        line_cleaned = line.replace('\n', '')
        i += 1
        
        # part 1
        sum += process_line(line_cleaned)
        
        # part 2
        if i % 3 == 0:
            sum_badges += process_group(line_cleaned, lineP, linePP)
        linePP = lineP
        lineP = line_cleaned

print(f'sum of priorities (part 1): {sum}')
print(f'sum of badges (part 2): {sum_badges}')
