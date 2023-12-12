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
        if not (M[i, :] == 1).any():
            M = np.insert(M, i, np.full(M.shape[1], 2), axis=0)
            i += 1
        i += 1
    while j < M.shape[1]:
        if not (M[:, j] == 1).any():
            M = np.insert(M, j, np.full(M.shape[0], 2), axis=1)
            j += 1
        j += 1
    return M

def dump(M):
    rep = lambda x: ['.', '#', ' '][x]
    return '\n'.join(''.join(map(rep, row)) for row in M)

# EF = expansion factor
def solve(M, EF):
    idxs = np.where(M == 1)
    n = len(idxs[0])
    sum1 = 0
    for i in range(n):
        for j in range(i+1,n):
            x1, y1 = idxs[0][i], idxs[1][i]
            x2, y2 = idxs[0][j], idxs[1][j]
            if x1 > x2: x1, x2 = x2, x1
            if y1 > y2: y1, y2 = y2, y1
            len_ij = x2-x1 + y2-y1
            path_x = M[(x1+1):x2, y1]
            path_y = M[x1, (y1+1):y2]
            gaps_x = np.count_nonzero(path_x == 2)
            gaps_y = np.count_nonzero(path_y == 2)
            # I don't understand at all why EF-2, it should be EF-1 but this yields correct answer
            sum1 += len_ij + gaps_x*(EF-2) + gaps_y*(EF-2)

    print(f'With expansion factor {EF} sum = {sum1}')

M = expand(M)
print(f'M is {M.shape} after expansion')
solve(M, 2)  # see note above
solve(M, 1000000)
# print(dump(M))
