/*
 * Credit to: Solidity
 * Orginal source: http://solidity.readthedocs.io/en/v0.4.21/introduction-to-smart-contracts.html
*/

// Version
pragma solidity ^0.4.13;


// Contract Code
contract Storage {
    
    // Variables
    uint data;

    // Setter
    function set(uint x) public {
        data = x;
    }

    // Getter
    function get() public constant returns (uint) {
        return data;
    }
}