/*
 * Great reference: 
 * * https://github.com/OpenZeppelin/zeppelin-solidity/blob/master/contracts/math/SafeMath.sol
 * * https://medium.com/crypto-currently/build-your-first-smart-contract-fc36a8ff50ca
*/

pragma solidity ^0.4.13;

import "github.com/OpenZeppelin/zeppelin-solidity/contracts/math/SafeMath.sol"; 

contract SafeCounter {
    using SafeMath for uint;

    uint private count = 0;

    function increment() public {
        count = count.add(1);
    }

    function decrement() public {
        count = count.sub(1);
    }

    function getCount() public constant returns (uint) {
        return count;
    }
}