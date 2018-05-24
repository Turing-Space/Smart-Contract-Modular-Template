/*
 * Credit to: Ethereum
 * Orginal source: https://www.ethereum.org/token
*/

pragma solidity ^0.4.21;

contract Token {
    mapping (address => uint256) private balances;
    
    function getBalance(address _account) public constant returns (uint256) {
        return balances[_account];
    }

    function Token(uint256 _initialSupply) public {
        balances[msg.sender] = _initialSupply;
    }

    function transfer(address _to, uint256 _value) public {
        require(balances[msg.sender] >= _value);
        require(balances[_to] + _value >= balances[_to]);   // Avoid overflows
        balances[msg.sender] -= _value;
        balances[_to] += _value;
    }
}
