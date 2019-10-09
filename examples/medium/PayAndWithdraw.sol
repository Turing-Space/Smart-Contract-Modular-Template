pragma solidity ^0.4.13;

contract PayAndWithdraw {
    
    address owner;

    event Donate(address sender, uint amount);
    
    // Set the owner of this contract.
    constructor () public {
        owner = msg.sender;
    }

    // Limit the access to owner only
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    // Pay "value" money
    function donate() payable public {
        emit Donate(msg.sender, msg.value);
    }
    
    // Withdraw a certain amount to OWNER (OnlyOwner)
    function withdrawToOwner(uint amount) onlyOwner public returns(bool) {
        require(amount < address(this).balance);
        owner.transfer(amount);
        return true;
    }
    
    // Withdraw a certain amount to SOMEONE (Private/Internal)
    function withdrawToSomeone(uint amount, address someone) private returns(bool) {
        require(amount < address(this).balance);
        someone.transfer(amount);
        return true;
    }
    
    // Get current balance
    function getBalanceContract() constant public returns(uint){
        return address(this).balance;
    }
    
    // Call internal function
    function announceWinner(uint amount, address someone) onlyOwner public returns(bool) {
        return withdrawToSomeone(amount, someone);
    } 
    
}
