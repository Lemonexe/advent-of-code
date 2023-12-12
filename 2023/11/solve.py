import numpy as np

filepath = 'input.txt'

lines = []
with open(filepath, encoding='utf-8') as file:
    for line in file:
        lines.append(line.rstrip().replace('.', '0').replace('#', '1'))
lines = [list(line) for line in lines if line]
M = np.array(lines, dtype=np.int32)
print(f'M is {M.shape}')

def expand(M):
    i = 0
    j = 0
    while i < M.shape[0]:
        if not M[i, :].any():
            M = np.insert(M, i, np.zeros(M.shape[1]), axis=0)
            i += 1
        i += 1
    while j < M.shape[1]:
        if not M[:, j].any():
            M = np.insert(M, j, np.zeros(M.shape[0]), axis=1)
            j += 1
        j += 1
    return M

def dump(M):
    rep = lambda x: ['.', '#'][x]
    return '\n'.join(''.join(map(rep, row)) for row in M)

def solve1(M):
    idxs = np.nonzero(M)
    n = len(idxs[0])
    sum1 = 0
    for i in range(n):
        for j in range(i,n):
            sum1 += abs(idxs[0][i]-idxs[0][j]) + abs(idxs[1][i]-idxs[1][j])
    print(f'1st task: sum = {sum1}')

M = expand(M)
print(f'M is {M.shape} after expansion')
solve1(M)
# print(dump(M))
