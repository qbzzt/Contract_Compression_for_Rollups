//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";


contract DecompressingDeployer {

    // This is a copy and paste from build-code-table/params.sol 
    uint32[256] decompressTable = [
     0x003a0000,
     0x61420000,
     0x604c0000,
     0xff4f0000,
     0x81518000,
     0x56538000,
     0x80550000,
     0x90560000,
     0x50588000,
     0x5b598000,
     0x015e0000,
     0x83608000,
     0x15610000,
     0x51644000,
     0x91648000,
     0x4065c000,
     0x57684000,
     0x826d4000,
     0x206d8000,
     0x526ec000,
     0x1b70c000,
     0x63736000,
     0x8574e000,
     0x6275a000,
     0x9276c000,
     0x8476e000,
     0x02772000,
     0xfd774000,
     0x0477a000,
     0x167d0000,
     0x037e8000,
     0x36802000,
     0x6e804000,
     0x69805000,
     0x6c806000,
     0x87807000,
     0x0880e000,
     0x64830000,
     0x3d835000,
     0x93840000,
     0x1f841000,
     0x54843000,
     0x05869000,
     0x8686a000,
     0x35877000,
     0x06879000,
     0x6587f000,
     0x11880000,
     0xa0883000,
     0x10890000,
     0x738dc000,
     0x148dd000,
     0x7f8eb000,
     0xc3900000,
     0x48900800,
     0x4d90f800,
     0x95914000,
     0x67915800,
     0x66916000,
     0x3e916800,
     0xfe931000,
     0x44932800,
     0x17933800,
     0x1c934800,
     0x7994d800,
     0x33959000,
     0x0d970000,
     0x07976800,
     0x9497c800,
     0x7297e000,
     0x34981000,
     0x74982000,
     0xe0992800,
     0x55993800,
     0x88994800,
     0x24997800,
     0x199d2800,
     0x6f9df000,
     0x129ea000,
     0x13a01000,
     0x2ba01800,
     0x1ea03000,
     0x2ea03400,
     0xc0a03800,
     0x38a03c00,
     0x42a0f400,
     0x8aa15000,
     0x76a17000,
     0xeea17800,
     0xc8a31800,
     0x0ea31c00,
     0xf3a32000,
     0x77a32400,
     0x4ca34000,
     0x18a34400,
     0xfaa42800,
     0x4fa4c000,
     0x41a4c400,
     0x3fa4d400,
     0x97a58000,
     0x0ca58400,
     0x27a58800,
     0x25a58c00,
     0xa1a59800,
     0x21a59c00,
     0xc9a68000,
     0x30a68400,
     0x3ca68c00,
     0x0fa6b400,
     0x22a6b800,
     0xb3a6bc00,
     0xdda70c00,
     0x39a71800,
     0x26a71c00,
     0x23a76000,
     0x2fa76400,
     0x2da78000,
     0x37a78800,
     0x75a7c400,
     0x28a7d000,
     0x71a7d800,
     0xa7a7ec00,
     0x0aa81800,
     0x7ba81c00,
     0xe5a82800,
     0x6da82c00,
     0x96a91400,
     0x46a91800,
     0x31a91c00,
     0xf1a92400,
     0x4ea93000,
     0x1aa93400,
     0x70a94000,
     0x3aa95800,
     0x43a95c00,
     0x89a96400,
     0x45a96800,
     0x32a96c00,
     0x68a97000,
     0x3bad3400,
     0x49ad3800,
     0x53ad3c00,
     0x5aade000,
     0x09adf800,
     0xd7b01400,
     0x7ab01c00,
     0xd8b01e00,
     0x59b0f000,
     0xecb14800,
     0xe8b14a00,
     0xc6b14e00,
     0x9cb15400,
     0x5cb15600,
     0x5eb17400,
     0xc7b17600,
     0x8eb17c00,
     0xafb17e00,
     0x7db33000,
     0xedb33200,
     0x9ab33600,
     0x7cb42000,
     0x78b42200,
     0x2cb42400,
     0xc4b42600,
     0xeab42c00,
     0xa9b42e00,
     0xdbb4c800,
     0xf7b4ca00,
     0xd4b4ce00,
     0x7eb4d000,
     0xb5b68800,
     0xe3b68a00,
     0x47b6b000,
     0x2ab70800,
     0xf2b71000,
     0xefb71400,
     0xa6b71600,
     0xe1b78400,
     0xd1b78c00,
     0xb9b78e00,
     0xb6b7c200,
     0x1db7d400,
     0xaab7dc00,
     0xadb7de00,
     0xf8b7ea00,
     0xe2b92200,
     0xc2b94400,
     0x99b94600,
     0x4ab95000,
     0x8cb95200,
     0x5db95600,
     0xa3b96000,
     0x9bb96200,
     0xd9b97600,
     0x29bd2400,
     0x8bbd2600,
     0x0bbd3000,
     0x98bd3200,
     0xf5bde800,
     0xebbdea00,
     0x8dbdec00,
     0x4bbdfc00,
     0xcebea800,
     0xcdbeaa00,
     0xb0beac00,
     0xfcbeae00,
     0x6ac01600,
     0xbec01700,
     0xd3c0f200,
     0xd0c0f300,
     0xdcc14c00,
     0xbac14d00,
     0xbdc33400,
     0xd6c33500,
     0x58c4cc00,
     0x5fc4cd00,
     0xf9c4d200,
     0x9ec4d300,
     0xa5c6b300,
     0xe7c70a00,
     0x8fc70b00,
     0xacc71200,
     0xdfc71300,
     0x9fc78600,
     0x9dc78700,
     0xcbc7c000,
     0xa2c7c100,
     0xbfc7d600,
     0xcfc7d700,
     0xe4c7e800,
     0xb1c7e900,
     0xb8c91000,
     0xb7c91100,
     0xcac91200,
     0xa4c91300,
     0xd2c92000,
     0xf4c95400,
     0xb2c95500,
     0xccc97400,
     0xfbc97500,
     0xdacd2000,
     0xbbcd2100,
     0xe6cd2200,
     0xdecd2300,
     0x6bcde400,
     0xa8cde500,
     0xc1cde600,
     0xabcde700,
     0xbccdee00,
     0xb4cdef00,
     0xf0cdfe00,
     0xd5cdff00,
     0xf6d6b200,
     0xe9d6b280,
     0xc5d92100,
     0xaed92180
    ];

    uint constant minSymbolLength = 3;
    uint constant maxSymbolLength = 13;
    uint constant compressedSymbolLengthOffset = 20;
    uint constant origSymbolOffset = 24;
    uint constant wordSize = 32;

    // Values calculated from the parameters
    uint constant originalSymbolMask = ~((1 << origSymbolOffset) -1);
    uint constant compressedSymbolLengthMask = 
        ~((1 << compressedSymbolLengthOffset) -1) ^ 
        originalSymbolMask;  
    uint constant compressedSymbolMask =  (1 << compressedSymbolLengthOffset) - 1;          

    // Inform an external account that called us, and the rest of the
    // world, what is the address of the new contract
    event ContractDeployed(address _addr);


    function _getOriginalSymbol(
        uint index_
    ) internal view returns (uint) {
        return (decompressTable[index_] & originalSymbolMask) 
            >> origSymbolOffset;
    }   

    function _getCompressedSymbolLength(
        uint index_
    ) internal view returns (uint) {
        return (decompressTable[index_] & compressedSymbolLengthMask) 
            >> compressedSymbolLengthOffset;
    }   

    function _getCompressedSymbol(
        uint index_
    ) internal view returns (uint) {
        return decompressTable[index_] & compressedSymbolMask;
    }   


    function _getBit(
        uint bitNum_,
        bytes calldata /* uint8[] memory */ compressedData_
    ) internal pure returns (uint) {
        uint byteNum = bitNum_ / 8;
        uint bitInByte = bitNum_ - byteNum*8;
        uint mask = 1 << (7-bitInByte);   // bit0 is more significant than bit7

        require (byteNum < compressedData_.length, "Invalid bit number");

        return (uint8(compressedData_[byteNum]) & mask)/mask;
    }   // function _getBit

    // Look for a symbol in decompressTable, return the symbol or 0xFFFF if you can't
    // find it (meaning it's the prefix for a longer symbol)
    function _findSymbol(
        uint symbol_, 
        uint length_
    ) public view returns (uint) {
        uint lineNum = 0;    // Start from the first line of the array

        // The symbol, but left justified
        uint symbol =  symbol_ <<  (compressedSymbolLengthOffset-length_);   
        
        
        // If we find an answer we return from inside this loop. Otherwise,
        // we go over the entire array and then return.
        while (lineNum < decompressTable.length) {
            uint lineLength = _getCompressedSymbolLength(lineNum);

            // The decompression table is sorted by symbol length. If we are beyond
            // the current length, symbol_ is not really a symbol but merely a prefix
            if (lineLength > length_) {
                return 0xFFFF;
            } 

            // If they are equal, this might be the right line
            if (lineLength == length_) {
                if (_getCompressedSymbol(lineNum) == symbol) {
                    return _getOriginalSymbol(lineNum);
                }
            }    // if (lineLength == length_)

            // If lineLength < length_ this is not the right line, go to the next one

            lineNum = lineNum+1;
        }    // while (lineNum < decompressTable.length) 

        // If we get here, it's not found
        return 0xFFFF;

    }    // function _findSymbol



    // This function is public because it might be useful for other
    // contracts that deal with contracts as data (only contracts because
    // our compression table won't work well for anything else)
    function decompress(
        bytes calldata /* uint8[] memory */ compressedData_,
        uint compressedDataLength_
    ) public view returns (
        uint8[] memory result,
        uint resultLength
    ) {
        uint nextBit = 0;
        result = new uint8[](24*1024);
        resultLength = 0;

        while(nextBit < compressedDataLength_*8) {
            uint symbolRead = 0;
            uint bitsRead = 0;

            // Read the shortest possible symbol
            while ((bitsRead < minSymbolLength) && (nextBit < compressedDataLength_*8)) {
                // Read one more bit
                symbolRead = symbolRead << 1 | _getBit(nextBit, compressedData_);
                nextBit = nextBit + 1;
                bitsRead = bitsRead + 1;
            }    // while bitsRead < minSymbolLength

            uint symbol = _findSymbol(symbolRead, bitsRead);
            while ((symbol == 0xFFFF) && (nextBit < compressedDataLength_*8)) {
                symbolRead = symbolRead << 1 | _getBit(nextBit, compressedData_);
                nextBit = nextBit + 1;
                bitsRead = bitsRead + 1;                
                symbol = _findSymbol(symbolRead, bitsRead);
            }        
            if (symbol != 0xFFFF) {
                result[resultLength++] = uint8(symbol);
            }
        }    // while bitNum < compressedData_.length*8

    }  // function _decompress

/*
    function test(bytes calldata param_, uint len_) public returns (address) {
        emit ContractDeployed(address(0));

        uint8[] memory result;
        uint resultLength;

        (result, resultLength) = decompress(param_, len_);
        for (uint i=0; i<resultLength; i++) {
            console.log(i, result[i]);
        }

        return(address(0));
    }
*/

    // Decompress a contract and deploy it, return the address
    function deployCompressed(
        bytes calldata compressed_
    ) public returns (
        address
    )  {
        uint8[] memory result;
        uint resultLength;

        (result, resultLength) = decompress(compressed_, compressed_.length);
        console.log(resultLength);
        console.log("[");
        for(uint i=0; i<resultLength; i++) {
            console.log(result[i], ",");           
        }
        console.log("]");
        address addr;
        assembly {
            addr := create(0, result, resultLength)
        }
        console.log("New contract at ", addr); 

        // Inform an external account that called us, and the rest of the
        // world, what is the address of the new contract
        emit ContractDeployed(addr);

        return (addr);
    }   // function deployCompressed
    
}    // contract DecompressingDeployer