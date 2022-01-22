#! /usr/local/bin/node

// Word size
const wordSize = 32

// Bits to identify an uncompressed symbol
const origSymbolLengthBits = 8

// Bits to write the length of a compressed symbol
const compressedSymbolLengthBits = 4

// The maximum number of bits we can support in an encoded symbol
const maxEncodedBits = wordSize - 
  (origSymbolLengthBits + compressedSymbolLengthBits)


// ****** NEW CODE

// For simplicity require the word size to be an even number of bytes
if (wordSize % 8 != 0) {
    console.error(`Word size should be divisible by 8, not ${wordSize}`)
    process.exit(-1)
}

// The EVM doesn't support uints with more than 256 bits
if (wordSize > 256) {
    console.error(`Word size should fit in a 256 bit word, ${
        wordSize} does not`)
    process.exit(-1)
}


const fs = require("fs")
const contractData = fs.readFileSync(0).toString() // STDIN_FILENO = 0
const contractBytes = contractData.match(/.{2}/g)

const freqTable = contractBytes.reduce((acc, item) => {
    acc[item] = (acc[item] || 0) + 1
    return acc
}, 
{})  // contractBytes.reduce

const freqKeys = Object.keys(freqTable)

// The frequencies array
let freqArray = freqKeys.map(x => [x, freqTable[x]])
freqArray.sort((a,b) => b[1]-a[1])

// Make sure all the possible symbols are covered
if (freqArray.length != 1<<origSymbolLengthBits) {
    console.error(`The frequency array should have ${
        1<<origSymbolLengthBits} symbols, but instead it has ${
        freqArray.length} symbols.`)
    process.exit(-1)
}

// The Huffman coding algorithm
while(freqArray.length > 1) {
   const lowFreq1 = freqArray.pop()
   const lowFreq2 = freqArray.pop()
   const newElem = [
       [lowFreq1[0], lowFreq2[0]],
       lowFreq1[1] + lowFreq2[1]
   ]
   freqArray.push(newElem)
   freqArray.sort((a,b) => b[1]-a[1])
} // while(freqArray.length > 1)


const encode = tree => {
    let encode0, encode1
    if (typeof tree[0] == 'string')
        encode0 = [["0", tree[0]]]
    else
        encode0 = encode(tree[0]).map(x => ["0"+x[0], x[1]])

    if (typeof tree[1] == 'string')
        encode1 = [["1", tree[1]]]
    else
        encode1 = encode(tree[1]).map(x => ["1"+x[0], x[1]])

    return encode0.concat(encode1)
}  // encode

const codingTable = encode(freqArray[0][0])
// sort by encoded symbol length
   .sort((a,b) => a[0].length-b[0].length)   



// Create the compression table
let compressTable = {}
codingTable.map(x => compressTable[x[1]] = x[0])
fs.writeFileSync('compressTable.json', 
    JSON.stringify(compressTable, null, 2))



// ****** NEW CODE


// Figure the minimum and maximum symbol lengths
const minLength = codingTable[0][0].length
const maxLength = codingTable[codingTable.length-1][0].length


if (maxLength > (1<<compressedSymbolLengthBits)-1) {
    console.error(`Maximum symbol length is ${
        maxLength}, this length cannot be written in just ${
        compressedSymbolLengthBits} bits`)
    process.exit(-1)
}

if (maxLength > maxEncodedBits) {
    console.error(`We have ${
        maxEncodedBits} bits for each symbol. The longest symbol is ${
        maxLength} bits. It doesn't fit.`)
    process.exit(-1)
}

// Bit locations in the decompression table
const origSymbolOffset = wordSize - origSymbolLengthBits
const compressedSymbolLengthOffset = 
         origSymbolOffset - compressedSymbolLengthBits


const decompressTable = codingTable.map(x =>   
    (BigInt(x[0].length) << BigInt(compressedSymbolLengthOffset)) |
    (BigInt(parseInt(x[1],16)) << BigInt(origSymbolOffset)) |
    (BigInt(parseInt(x[0], 2)) << (BigInt(compressedSymbolLengthOffset)-BigInt(x[0].length)) )
                                   )
// It isn't necessary to left justify the numbers, but it makes the
// code more readable.                                  
const num2Hex = x =>  '     0x'+x.toString(16).padStart(wordSize/4, "0")+',\n'
const solidityList = decompressTable.map(num2Hex)
      .reduce((a,b) => a+b).slice(0,-2)     // Remove the last comma

const solidityCode = `
    uint${wordSize}[${decompressTable.length}] decompressTable = [
${solidityList}
    ];

    uint minSymbolLength = ${minLength};
    uint maxSymbolLength = ${maxLength};
    uint compressedSymbolLengthOffset = ${compressedSymbolLengthOffset};
    uint origSymbolOffset = ${origSymbolOffset};
    uint wordSize = ${wordSize};
`

console.log(solidityCode)