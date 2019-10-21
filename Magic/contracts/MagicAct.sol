pragma solidity >=0.4.24 <0.6.0;

import "./Magic.sol";

contract MagicAct is Magic {

	event Act(uint _type);
 
	// type 1: Card trick, 2:Party show, 3: Stage magic, 4: Illution
	function act(uint _type) public checkEnoughDonation(_type*100) {
		require(audience[msg.sender].cooldown[_type] <= now);
		_triggerCooldown(_type);
		payMagician(_type);
		emit Act(_type);
	}

  	function payMagician(uint _type) public payable{
  		uint charge=_type*100 finney;
  		magician.transfer(charge);
  		audience[msg.sender].donation-=charge;
  	}
}
