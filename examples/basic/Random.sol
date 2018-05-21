pragma solidity ^0.4.13;

contract Random {

    function getNow() public constant returns (uint) {
        return now; // or block.timestamps
    }
    
    function getBlockNum() public constant returns (uint) {
        return block.number;
    }
    
    function generateRandom(uint min, uint max) public constant returns (uint) {
        return (now % (max - min)) + min; 
    }
    
    function generateRandomNum(string input) returns (uint){
        bytes32 hash = keccak256(input);
        return (uint(hash) + now) % 100;
    }

}
