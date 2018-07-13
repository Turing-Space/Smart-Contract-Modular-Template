pragma solidity ^0.4.24;

contract DelegateCallee {
    uint public n;
    function setN(uint _n) public {
        n = _n;
    }
}