pragma solidity ^0.4.24;

contract EasyPayAndWithDraw {
    
    mapping (address => uint) public balances;
    
    // fallback
    function () payable public {
        balances[msg.sender] = balances[msg.sender] + msg.value;
    }
    
    function withdraw(uint value) public {
        require(balances[msg.sender] >= value);
        require(value > 0);
        
        balances[msg.sender] = balances[msg.sender] - value;
        
        msg.sender.transfer(value);
    }
    
}
