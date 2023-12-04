import * as fs from "fs";

const file_path = 'input.txt';
const data: string = fs.readFileSync(file_path, 'utf-8');
const lines = data.split('\n').filter(Boolean);

let sum1 = 0;

lines.forEach((line: string, i) => {
    let count = 0; // number of matches
    const [winCards, haveCards] = line
        .replace(/^Card \d:/, '')
        .replace(/ {2,}/g, ' ')
        .split('|')
        .map(side => side.trim().split(' ')) as [string[], string[]];
    haveCards.forEach(card => winCards.includes(card) && (count++));
    sum1 += count > 0 ? 2**(count-1) : 0;
})
console.log(`First task sum = ${sum1}`);