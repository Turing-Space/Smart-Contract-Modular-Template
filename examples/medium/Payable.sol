pragma solidity >= 0.5.0;

contract Paybale {

    event Donate(address sender, uint amount);

    function () external payable { }

    function donate() public payable {
        emit Donate(msg.sender, msg.value);
    }

}
