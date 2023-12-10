const fs = require('fs');
const file_path = 'input.txt';
const data = fs.readFileSync(file_path, 'utf-8');
const lines = data.split('\n').map(line => line.replace(/[\r\n]+$/, '')).filter(Boolean);
const nR = lines.length;
const nC = lines[0].length;

const findS = () => {
    for(let i = 0; i < lines.length; i++) {
        const j = lines[i].indexOf('S');
        if (j > -1) {
            return [i, j];
        }
    }
    throw 'S not found';
};
// [x,y]
const S = findS();

// direction: 0 = up, 1 = right, 2 = down, 3 = left
// directions as vector of movement to
const dirs = [[-1, 0], [0, 1], [1, 0], [0, -1]];

// map (direction to) to (direction from)
const dirsFrom = [2, 3, 0, 1];

// get new coords from movement
const move = (x,y,d) => {
    const [dx, dy] = dirs[d];
    return [x+dx, y+dy];
}

// pipe segments, where each pipe lists possible directions TO WHICH IT GOES (not from)
const pipes = {
    '|': [0, 2],
    '-': [1, 3],
    'L': [0, 1],
    'J': [0, 3],
    '7': [2, 3],
    'F': [1, 2],
    '.': [],
}

// take a walk from x,y towards d
const walk = (x, y, d) => {
    const loop = [[x,y]];
    while(loop.length === 1 || lines[x][y] !== 'S') {
        if(loop.length > nR*nC) throw `iteration ${nR*nC}`;

        // get next coords
        [x, y] = move(x,y,d);
        const dFrom = dirsFrom[d];

        const letter = lines[x][y];
        if(letter === 'S') break;

        // if the place is connected, get the direction where next
        const pipe = pipes[letter];
        const i = pipe.indexOf(dFrom);
        // console.log(`i=${loop.length}\t${x+1},${y+1}\tto ${d} from ${dFrom}\t${letter} [${pipe.join(',')}] ${i}`);
        if(i === -1) return null;
        d = pipe[1-i];

        loop.push([x,y]);
    }
    console.log(`Found loop of ${loop.length} pipe segments.`);
    return loop;
};

const getTheLoopBrother = () => {
    for(let d = 0; d < 4; d++) {
        console.log(`I WALK A LONELY ROAD → ${d}`);
        let [x,y] = S;
        let res = walk(x,y,d);
        if(res !== null) {return res;}
    }
};
const loop = getTheLoopBrother();
console.log(`1st task: ${loop.length/2} steps`);
