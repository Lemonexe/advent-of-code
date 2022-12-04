const fs = require('fs');
const path = require('path');
const address = path.join(__dirname,'input.txt');
const file = fs.readFileSync(address);
const fileContent = file.toString();

const lineToNumber = line => {
    const num = parseInt(line);
    return isNaN(num) ? 0 : num;
}
const maxItem = arr => arr.reduce((max, elf) => (elf > max) ? elf : max, 0);
const arrSum = arr => arr.reduce((sum,item) => sum+item,0);

const elves = fileContent
    .split('\n\n')
    .map(elf => elf
        .split('\n')
        .reduce((sum, line) => sum + lineToNumber(line), 0)
    );
const topThree = elves.reduce(
    (sums, elf) => {
        const idx = sums.findIndex(item => item < elf);
        if(idx < 0) return sums;
        sums.splice(idx, 0, elf);
        sums.pop();
        return sums;
    },
    [0,0,0]
);
const maxElf = maxItem(elves);
console.log(`elf_max = ${maxElf} cal`);
console.log(`top three: [${topThree.join(',')}] cal\ntheir sum: ${arrSum(topThree)} cal`);
