pragma solidity ^0.4.24;

contract ModifierExample {
    
    address owner;
    
    modifier isOwner {
        require(msg.sender == owner);
        _;
    }
    
    constructor() public {
        owner = msg.sender;
    }
    
    function sayHi() public view isOwner returns (string) {
        return "Hi";
    }
    
}
