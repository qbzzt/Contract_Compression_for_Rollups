// Compress a contract

const fs = require('fs')

const compressTable = JSON.parse(
    fs.readFileSync(`build-code-table/compressTable.json`).toString())


// Compress a contract
const compressContract = async name => {
    // Read the contract
    const buf = fs.readFileSync(`artifacts/contracts/${name}.sol/${name}.json`)
    const artifact = JSON.parse(buf.toString())

    // Remove the initial 0x and create an array
    const bytecodeArray = artifact.bytecode.slice(2).match(/.{2}/g)

    // Replace bytes by their encoded form (in binary)
    let encodedBytecode = bytecodeArray.map(x => compressTable[x])
        .reduce((a,b) => a+b, "") 

    // Add zeros at the end until there's an integer number of bytes
    while (encodedBytecode.length % 8) 
       encodedBytecode += "0"
    const encodedArray = encodedBytecode.match(/.{4}/g)
    const hexStr = encodedArray.map(x => parseInt(x,2).toString(16))
       .reduce((a,b) => a+b, "")     

    console.log(`${name} reduced from ${artifact.bytecode.length/2} bytes to ${hexStr.length/2} bytes`)

    return hexStr
}    // compressContract



async function main() {
  const send2Chain = await compressContract("Greeter")

  console.log(send2Chain)
}  // main

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });