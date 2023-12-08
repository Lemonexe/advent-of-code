import re
import math


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

def solve(start, is_end):
    n_moves = 0
    cursor = start
    while not is_end(cursor):
        next_move = LR_seq[n_moves % n_seq]
        cursor = maze[cursor][next_move]
        # print(f'{next_move} {cursor}')
        n_moves += 1
    return n_moves

def solve1():
    n_moves = solve('AAA', lambda c: c == 'ZZZ')
    print(f'1st task: {n_moves} moves')

def solve2():
    cursors = [key for key in maze if re.match(r'..A', key)]
    is_end = lambda c: re.match(r'..Z', c)
    n_moves = [solve(c, is_end) for c in cursors]
    lcm = math.lcm(*n_moves)
    print(f'2st task: {lcm:.0f} moves')

solve1()
solve2()
