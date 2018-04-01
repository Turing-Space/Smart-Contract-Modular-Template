pragma solidity ^0.4.13;

contract Random {

    function getNow() public constant returns (uint) {
        return now; // or block.timestamps
    }
    
    function getBlockNum() public constant returns (uint) {
        return block.number;
    }
    
    function generateRandom(uint min, uint max) public constant returns (uint) {
        return (getNow() % (max - min)) + min; 
    }

}