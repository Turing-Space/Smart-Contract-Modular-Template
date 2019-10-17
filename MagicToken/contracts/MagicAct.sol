pragma solidity >=0.4.24 <0.6.0;

import "./Audience.sol";

contract MagicAct is Audience {

	event Act(uint _type);

	function cardTrick(uint _amount) public _checkDonation(100) {
		require(audience[msg.sender].cardTrickCooldown <= now);
		audience[msg.sender].cardTrickCooldown += uint32(now + cooldownTime); 
		audience[msg.sender].donation-=_amount;
		emit Act(1);
	}

	function partyShow(uint _amount) public _checkDonation(1000) {
		require(audience[msg.sender].cardTrickCooldown <= now);
		audience[msg.sender].partyShowCooldown += uint32(now + cooldownTime); 
		audience[msg.sender].donation-=_amount;
		emit Act(2);
	}

	function stageShow(uint _amount) public _checkDonation(5000) {
		require(audience[msg.sender].cardTrickCooldown <= now);
		audience[msg.sender].stageShowCooldown += uint32(now + cooldownTime); 
		audience[msg.sender].donation-=_amount;
		emit Act(3);
	}

	function illution(uint _amount) public _checkDonation(10000) {
		require(audience[msg.sender].cardTrickCooldown <= now);
		audience[msg.sender].illutionCooldown += uint32(now + cooldownTime); 
		audience[msg.sender].donation-=_amount;
		emit Act(4);
	}

}
