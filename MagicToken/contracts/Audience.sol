pragma solidity >=0.4.24 <0.6.0;

import "./MagicToken.sol";

contract Audience is MagicToken {

	struct Audiences {
		uint donation;
		uint32 cardTrickCooldown;
		uint32 partyShowCooldown;
		uint32 stageShowCooldown;
		uint32 illutionCooldown;
	}

	mapping (address=>Audiences) public audience;

	modifier _checkDonation(uint _price) {
		require(audience[msg.sender].donation >= _price);
		_;
	}

  	function donate(uint _amount) public {
      	transfer(tx.origin,_amount);
      	audience[msg.sender].donation+=_amount;
  	}

  	function getDonation(address _audience) public view returns(uint){
  		return audience[_audience].donation;
  	}
}
