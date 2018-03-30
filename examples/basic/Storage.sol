/*
 * Credit to: Solidity
 * Orginal source: http://solidity.readthedocs.io/en/v0.4.21/introduction-to-smart-contracts.html
*/

pragma solidity ^0.4.13;

contract Storage {
    uint data;

    function set(uint x) public {
        data = x;
    }

    function get() public constant returns (uint) {
        return data;
    }
}