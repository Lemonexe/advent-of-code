import numpy as np

filepath = 'input.txt'

lines = []
with open(filepath, encoding='utf-8') as file:
    for line in file:
        lines.append(line)
lines = [np.array(line.rstrip().split(' '), dtype=np.int64) for line in lines if line.rstrip()]

# go through list of vectors (original + diffs) to predict
def predict(row):
    for i in range(len(row)-2, -1, -1):
        delta = row[i][-1] + row[i+1][-1]
        row[i] = np.append(row[i], delta)
        # print(f'{i} {delta} {row[i]}')
    return row[0][-1]

# np vector to list of vectors (original + diffs)
def get_diffs(vec):
    tol = 1e-8
    ls = [vec]
    while np.any(abs(ls[-1]) > tol):
        ls.append(np.diff(ls[-1]))
    return ls

def solve():
    sum1 = 0
    rows = [get_diffs(vec) for vec in lines]
    for row in rows:
        sum1 += predict(row)

    print(f'1st task: sum = {sum1}')


solve()