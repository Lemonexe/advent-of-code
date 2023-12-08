import re

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

def solve1():
    n_moves = 0
    cursor = 'AAA'
    while cursor != 'ZZZ':
        next_move = LR_seq[n_moves % n_seq]
        cursor = maze[cursor][next_move]
        # print(f'{next_move} {cursor}')
        n_moves += 1

    print(f'1st task: {n_moves} moves')

def solve2():
    n_moves = 0
    cursors = [key for key in maze if re.match(r'..A', key)]
    # print(cursors)
    while not all(re.match(r'..Z', c) for c in cursors):
        next_move = LR_seq[n_moves % n_seq]
        # print(f'{next_move} ', end='')
        for i,c in enumerate(cursors):
            cursors[i] = maze[c][next_move]
            # print(f' {cursors[i]}', end='')
        # print('')
        n_moves += 1
        if n_moves % 1e6 == 0: print(n_moves)

    print(f'2st task: {n_moves} moves')

solve1()
solve2()
