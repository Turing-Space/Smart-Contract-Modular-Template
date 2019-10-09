pragma solidity >=0.5.0;

contract Random {
    
    event RandHash(uint min, uint max, uint timestamp, uint blockNumber);
    
    function getBlockNum() public view returns (uint) {
        return block.number;
    }
    
    function getNow() public view returns (uint) {
        return now;
    }
    
    function randNow(uint min, uint max) public view returns (uint) {
        return (getNow() % (max - min)) + min; 
    }
    
    function randHash(uint min, uint max) public returns (uint){
        
        emit RandHash(min, max, getNow(), getBlockNum());
        
        // Using 0.4.21, "abi" will result in a DeclarationError: Undeclared identifier.
        // Therefore, use a newer version of compiler > 0.4.21.
        // Starting from 0.4.22, there won't be such abi problem.
        bytes32 hash = keccak256(abi.encodePacked(getNow(), getBlockNum()));
        return (uint(hash) % (max - min)) + min; 
    }
}
