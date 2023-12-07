// DEV
// const testData =[{"hand": "32T3K", "bid": "765"}, {"hand": "T55J5", "bid": "684"}, {"hand": "KK677", "bid": "28"}, {"hand": "KTJJT", "bid": "220"}, {"hand": "QQQJA", "bid": "483"}];
// window.onload = solve1;

function handleFileUpload(event) {
    const file = event.target.files[0];
    if(!file) {return;}
    let reader = new FileReader();
    reader.onload = function() {
        const rawData = reader.result;
        solve1(rawData);
    };
    reader.readAsText(file);
}

/*
0 = high card
1 = one pair
2 = two pair
3 = three of a kind
4 = full house
5 = four of a kind
6 = five of a kind
*/
function getHandType(hand) {
    hand = hand.split('').sort().join('');
    if(hand.match(/(\S)\1\1\1\1/)) return 6;
    if(hand.match(/(.)\1\1\1/)) return 5;
    if(hand.match(/(.)\1\1(.)\2/) || hand.match(/(.)\1(.)\2\2/)) return 4;
    if(hand.match(/(.)\1\1/)) return 3;
    if(hand.match(/(.)\1.?(.)\2/)) return 2;
    if(hand.match(/(.)\1/)) return 1;
    return 0;
}

// compare fn for hands of equal type
function compareEqualTypeHands(a,b) {
    a = a.split('');
    b = b.split('');
    for(let i = 0; i < a.length; i++) {
        if(b[i] > a[i]) return 1;
        if(a[i] > b[i]) return -1;
    }
    return 0; // that should not happen, means the hands are same?
}

// first part
function solve1(rawData) {
    // parse raw file data
    let lines = rawData.split(/[\r\n]+/).filter(Boolean).map(item => {
        const [hand, bid] = item.split(' ');
        return {hand, bid};
    });

    // DEV
    // lines = testData;

    // for purposes of comparison, these cards will be remapped to A B C D E
    let cardsToSanitize = ['A', 'K', 'Q', 'J', 'T'];
    lines.forEach(line => {
        line.hand = line.hand.split('').map(char => {
            const i = cardsToSanitize.indexOf(char);
            return i === -1 ? char : String.fromCharCode(65+cardsToSanitize.length-i);
        }).join('');
    });

    // sum of weighted bids
    let sum1 = 0;

    lines.forEach(line => {
        const {hand, bid} = line;
        line.type = getHandType(hand);
    })

    lines = lines.sort((a,b) => {
        if(b.type !== a.type) return b.type - a.type;
        return compareEqualTypeHands(a.hand, b.hand);
    });
    for(let i = 0; i < lines.length; i++) {
        sum1 += lines[i].bid * (lines.length-i);
    }

    // DEV
    // console.log(JSON.stringify(lines,null,2));
    document.getElementById('res1').innerHTML = sum1.toFixed();
}
