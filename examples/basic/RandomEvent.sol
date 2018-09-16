pragma solidity ^0.4.21;

contract Random {
    
    event RandHash(uint min, uint max, uint timestamp, uint blockNumber);
    
    function getBlockNum() public constant returns (uint) {
        return block.number;
    }
    
    function getNow() public constant returns (uint) {
        return now;
    }
    
    function randNow(uint min, uint max) public constant returns (uint) {
        return (getNow() % (max - min)) + min; 
    }
    
    function randHash(uint min, uint max) public returns (uint){
        
        emit RandHash(min, max, getNow(), getBlockNum());
        
        bytes32 hash = keccak256(abi.encodePacked(getNow(), getBlockNum()));
        return (uint(hash) % (max - min)) + min; 
    }
}