import * as fs from "fs";

const file_path = 'input.txt';
const data: string = fs.readFileSync(file_path, 'utf-8');
const lines = data.split('\n').filter(Boolean);

let sum1 = 0;
// how many specimens of card[i] do I have
const cardNums: number[] =  Array(lines.length).fill(1);

lines.forEach((line: string, i) => {
    let count = 0; // number of matches
    const [winCards, haveCards] = line
        .replace(/^Card \d:/, '')
        .replace(/ {2,}/g, ' ')
        .split('|')
        .map(side => side.trim().split(' ')) as [string[], string[]];
    haveCards.forEach(card => winCards.includes(card) && (count++));

    // task 1
    sum1 += count > 0 ? 2**(count-1) : 0;

    // task 2
    for(let j = i + 1; j <= i + count; j++) {
        cardNums[j] += cardNums[i];
    }
})
console.log(`First task sum = ${sum1}`);

const sum2 = cardNums.reduce((acc, o) => acc + o, 0);
console.log(`Second task num = ${sum2}`);
