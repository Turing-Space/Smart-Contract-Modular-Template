pragma solidity >=0.4.24 <0.6.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/MagicAct.sol";

contract TestMagicAct {	
	MagicAct magicAct;

	uint public initialBalance = 2 ether;
	uint cooldownTimeofDeployedAddress;

	function beforeEach() public {
		magicAct = MagicAct(DeployedAddresses.MagicAct());
	}

	function testAct() public {
		uint expectedType = 1;
		uint initMagicianBalance = magicAct.getMagician().balance;
		magicAct.donate.value(300 finney)();
		Assert.equal(300 finney, magicAct.getDonation(address(this)), "The audience should donate 300 finney.");
		magicAct.act(expectedType);
		cooldownTimeofDeployedAddress = magicAct.getCooldownTime(expectedType);
		Assert.equal(cooldownTimeofDeployedAddress, now + 1 days, "The cooldown time should be added 1 day.");
		Assert.equal(magicAct.getMagician().balance, initMagicianBalance + 100 finney, "The magician should earn 100 finney.");
		Assert.equal(magicAct.getDonation(address(this)), 200 finney, "The audience should remain 200 finney.");
	}

	function testPayMagician() public {
		uint expectedType = 2;
		uint initMagicianBalance = magicAct.getMagician().balance;
		magicAct.donate.value(300 finney)();
		Assert.equal(magicAct.getDonation(address(this)), 500 finney, "The audience should donate 500 finney(300+200remaining).");
		magicAct.payMagician(expectedType);
		Assert.equal(magicAct.getMagician().balance, initMagicianBalance + 200 finney, "The magician should earn 200 finney.");
		Assert.equal(magicAct.getDonation(address(this)), 300 finney, "The audience should remain 300 finney.");
	}

	function testCheckEnoughDonationThrow() public {
      	magicAct = new MagicAct(); 
      	ThrowProxy throwproxy = new ThrowProxy(address(magicAct)); 
      	MagicAct(address(throwproxy)).act(4);
      	(bool r, ) = throwproxy.execute.gas(200000)(); 
      	Assert.isFalse(r, "Should be false because is should throw!");
  	}

  	function testCooldownThrow() public {
  		magicAct = new MagicAct();
      	ThrowProxy throwproxy = new ThrowProxy(address(magicAct));
      	MagicAct(address(throwproxy)).freeAct(1);
      	(bool r, ) = throwproxy.execute.gas(200000)(); 
      	Assert.isTrue(r, "Should be true because is should throw!");
      	MagicAct(address(throwproxy)).freeAct(1);
      	(r, ) = throwproxy.execute.gas(200000)(); 
      	Assert.isFalse(r, "Should be true because is should throw!");
  	}

}

// Proxy contract for testing throws
contract ThrowProxy {
 	address public target;
  	bytes data;


  	constructor(address _target) payable public{
  		target = _target;
  	}

 	 //prime the data using the fallback function.
  	function() external{
  	  	data = msg.data;
  	}

 	function execute() public returns (bool, bytes memory) {
 		return target.call(data);
 	}
}