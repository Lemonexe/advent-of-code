import re

verb = False

lines = []
with open('input.txt', encoding='utf-8') as file:
    for line in file:
        lines.append(line)
lines = [line.rstrip() for line in lines if line.rstrip()]

def hashify(line):
    [key, LR_vals] = line.split(' = ')
    LR_vals = re.sub(r'\(|\)', '', LR_vals).split(', ')
    return key, {'L': LR_vals[0], 'R': LR_vals[1]}

LR_seq = lines[0]  # sequence of left/right moves
n_seq = len(LR_seq)
maze = [hashify(line) for line in lines[1:]]
maze = {key: value for key,value in maze}

def solve():
    n = 0  # number of moves
    cursor = 'AAA'
    while cursor != 'ZZZ':
        next_move = LR_seq[n % n_seq]
        cursor = maze[cursor][next_move]
        verb and print(f'{next_move} {cursor}')
        n += 1

    print(f'1st task: {n} moves')

solve()
