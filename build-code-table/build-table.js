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
console.log(JSON.stringify(codingTable, null, 4))