#! /usr/local/bin/node

const { assert } = require("console")
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

// If not we need to add the missing byte values
assert(freqArray.length == 256)

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


// Figure the minimum and maximum symbol lengths
const minLength = codingTable[0][0].length
const maxLength = codingTable[codingTable.length-1][0].length
console.log(`Symbol size: ${minLength}-${maxLength}`)


// If we need more than 30 bytes we can't use a uint256
// (we use one byte for the symbol length, and one for the value being
// encoded)
assert(maxLength <= 256-16)
// <in the notes explain why this isn't an issue, but we still need to
// check it>

const res = codingTable.map(x =>   (BigInt(x[0].length) << 248n) +
                                   (BigInt(parseInt(x[1],16)) << 240n) +
                                   (BigInt(parseInt(x[0], 2)))
                                   )

console.log(res.map(x => x.toString(16)))