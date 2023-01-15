# PART 1
# line to pair of tuples
def process_pair(line):
    L, R = map(process_an_elf, line.split(','))
    return (L, R)

# elf string to elf tuple
def process_an_elf(assignment):
    start, end = map(int, assignment.split('-'))
    return (start, end)

# is elf tuple A subset of B
def is_subset(A, B):
    return A[0] >= B[0] and A[1] <= B[1]

full_subsets = 0 # in how many pairs is one of the elves subset of the other one
with open('foo-input.txt', encoding='utf-8') as file:
    for line in file:
        line = line.replace('\n', '')
        
        pair = process_pair(line)
        full_subsets += int(is_subset(pair[0], pair[1]) or is_subset(pair[1], pair[0]))

print(f'full subset pairs: {full_subsets}')
