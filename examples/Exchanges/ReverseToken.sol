pragma solidity ^0.4.9;

import "./SafeMath.sol";
import "./Token.sol";
import "./Ownable.sol";

contract ReserveToken is StandardToken, SafeMath, Ownable {
	/*
	   address public minter;
	   function ReserveToken() {
	   minter = msg.sender;
	   }
	 */ 
	function create(address account, uint amount) onlyOwner{
		//    if (msg.sender != minter) throw;
		balances[account] = safeAdd(balances[account], amount);
		totalSupply = safeAdd(totalSupply, amount);
	}
	function destroy(address account, uint amount) onlyOwner{
		//    if (msg.sender != minter) throw;
		if (balances[account] < amount) throw;
		balances[account] = safeSub(balances[account], amount);
		totalSupply = safeSub(totalSupply, amount);
	}
}
