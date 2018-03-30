/*
 * Credit to: Gerald Nash
 * Orginal source: https://medium.com/crypto-currently/build-your-first-smart-contract-fc36a8ff50ca
*/

pragma solidity ^0.4.13;

contract Counter {
    uint private count = 0;

    function increment() public {
        count += 1;
    }

    function decrement() public {
        count -= 1;
    }

    function getCount() public constant returns (uint) {
        return count;
    }
}