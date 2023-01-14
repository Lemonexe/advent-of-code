priority_sum = 0

def process_line(line):
    line2 = line[:-1] if line[-1] == '\n' else line
    left, right = split(line2)
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

sum = 0
with open('input.txt', encoding='utf-8') as file:
    for line in file:
        sum += process_line(line)
print(sum)