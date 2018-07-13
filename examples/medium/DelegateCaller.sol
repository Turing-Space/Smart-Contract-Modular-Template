pragma solidity ^0.4.24;

contract DelegateCaller {
    uint public n;
    function delegatecallSetN(address _e, uint _n) public {
        if (! _e.delegatecall(bytes4(keccak256("setN(uint256)")), _n))
            revert();
    }
}