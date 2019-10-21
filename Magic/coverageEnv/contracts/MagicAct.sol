pragma solidity >=0.4.24 <0.6.0;

import "./Magic.sol";

contract MagicAct is Magic {event __CoverageMagicAct(string fileName, uint256 lineNumber);
event __FunctionCoverageMagicAct(string fileName, uint256 fnId);
event __StatementCoverageMagicAct(string fileName, uint256 statementId);
event __BranchCoverageMagicAct(string fileName, uint256 branchId, uint256 locationIdx);
event __AssertPreCoverageMagicAct(string fileName, uint256 branchId);
event __AssertPostCoverageMagicAct(string fileName, uint256 branchId);


	event Act(uint _type);
 
	// type 1: Card trick, 2:Party show, 3: Stage magic, 4: Illution
	function act(uint _type) public checkEnoughDonation(_type*100) {emit __FunctionCoverageMagicAct('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/MagicAct.sol',1);

emit __CoverageMagicAct('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/MagicAct.sol',11);
		emit __AssertPreCoverageMagicAct('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/MagicAct.sol',1);
emit __StatementCoverageMagicAct('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/MagicAct.sol',1);
require(audience[msg.sender].cooldown[_type] <= now);emit __AssertPostCoverageMagicAct('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/MagicAct.sol',1);

emit __CoverageMagicAct('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/MagicAct.sol',12);
		emit __StatementCoverageMagicAct('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/MagicAct.sol',2);
_triggerCooldown(_type);
emit __CoverageMagicAct('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/MagicAct.sol',13);
		emit __StatementCoverageMagicAct('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/MagicAct.sol',3);
payMagician(_type);
emit __CoverageMagicAct('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/MagicAct.sol',14);
		emit __StatementCoverageMagicAct('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/MagicAct.sol',4);
emit Act(_type);
	}

  	function payMagician(uint _type) public payable{emit __FunctionCoverageMagicAct('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/MagicAct.sol',2);

emit __CoverageMagicAct('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/MagicAct.sol',18);
  		emit __StatementCoverageMagicAct('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/MagicAct.sol',5);
uint charge=_type*100 finney;
emit __CoverageMagicAct('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/MagicAct.sol',19);
  		emit __StatementCoverageMagicAct('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/MagicAct.sol',6);
magician.transfer(charge);
emit __CoverageMagicAct('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/MagicAct.sol',20);
  		emit __StatementCoverageMagicAct('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/MagicAct.sol',7);
audience[msg.sender].donation-=charge;
  	}
}
