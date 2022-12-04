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

const elves = fileContent
    .split('\n\n')
    .map(elf => elf
        .split('\n')
        .reduce((sum, line) => sum + lineToNumber(line), 0)
    );
const maxElf = maxItem(elves);

console.log(`elf_max = ${maxElf} cal`);
