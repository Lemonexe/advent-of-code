import numpy as np

filepath = 'input.txt'

patterns = [None]
with open(filepath, encoding='utf-8') as file:
    for line in file:
        l = line.rstrip()
        if len(l) == 0:
            patterns.append(None)
            continue
        l = l.replace('.', '0').replace('#', '1')
        row = np.array([list(l)], dtype=np.int32)
        p_last = patterns[-1]
        patterns[-1] = row if p_last is None else np.append(p_last, row, axis=0)

H_multiplier = 100

# investigate pattern p, its p_i, L = i of the vertical line
def investigate_V(p, p_i, L):
    n_C = p.shape[1]
    i_C = L
    other = lambda i: L+(L-i)+1
    while i_C >= 0 and other(i_C) < n_C:
        if (p[:, i_C] != p[:, other(i_C)]).any():
            return 0
        i_C -= 1
    print(f'p{p_i} {L+1}')
    return L+1

# investigate pattern p, its p_i, L = i of the horizontal line
def investigate_H(p, p_i, L):
    n_R = p.shape[0]
    i_R = L
    other = lambda i: L + (L - i) + 1
    while i_R >= 0 and other(i_R) < n_R:
        if (p[i_R, :] != p[other(i_R), :]).any():
            return 0
        i_R -= 1
    print(f'p{p_i} {(L+1) * H_multiplier}')
    return L+1

def solve_pattern(p, p_i):
    n_R, n_C = p.shape
    sum_p = 0
    for i_C in range(n_C-1):
        if (p[:, i_C] == p[:, i_C+1]).all():
            # print(f'p{p_i} ?V@{i_C + 1}')
            sum_p += investigate_V(p, p_i, i_C)
    for i_R in range(n_R-1):
        if (p[i_R, :] == p[i_R+1, :]).all():
            # print(f'p{p_i} ?H@{i_R + 1}')
            sum_p += investigate_H(p, p_i, i_R) * H_multiplier
    return sum_p

def solve1():
    sum_all = 0
    for p_i,p in enumerate(patterns):
        sum_all += solve_pattern(p, p_i)
    print(f'1st task num = {sum_all}')
solve1()
