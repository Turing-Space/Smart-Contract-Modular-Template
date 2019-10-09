/*
 * Great reference:
 * * https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol
 * * https://medium.com/crypto-currently/build-your-first-smart-contract-fc36a8ff50ca
*/
pragma solidity >=0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/math/SafeMath.sol";

contract SafeCounter {
    using SafeMath for uint;

    uint private count = 0;

    function increment() public {
        count = count.add(1);
    }

    function decrement() public {
        count = count.sub(1);
    }

    function getCount() public view returns (uint) {
        return count;
    }
}
