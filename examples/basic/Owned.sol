pragma solidity >= 0.5.0;
/*
 * Credit to: Ethereum
 * Orginal source: https://www.ethereum.org/token
*/

contract Owned {
    address public owner;

    
    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address newOwner) onlyOwner public {
        owner = newOwner;
    }
}
