pragma solidity ^0.4.21;

contract Random {

    function getNow() public constant returns (uint) {
        return block.timestamp;
    }
    
    function getBlockNum() public constant returns (uint) {
        return block.number;
    }
    
    function randNow(uint min, uint max) public constant returns (uint) {
        return (getNow() % (max - min)) + min; 
    }
    
    function randHash(uint min, uint max) public constant returns (uint){
        bytes32 hash = keccak256(getNow(), getBlockNum());
        return ((uint(hash) + now) % (max - min)) + min; 
    }
}
