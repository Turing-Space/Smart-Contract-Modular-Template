pragma solidity ^0.4.13;

contract Paybale {
    
    event Donate(address sender, uint amount);
    
    function () payable { }
    
    function donate() payable {
        Donate(msg.sender, msg.value);
    }
    
}