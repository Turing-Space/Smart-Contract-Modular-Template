pragma solidity >=0.4.24 <0.6.0;

contract Magic {event __CoverageMagic(string fileName, uint256 lineNumber);
event __FunctionCoverageMagic(string fileName, uint256 fnId);
event __StatementCoverageMagic(string fileName, uint256 statementId);
event __BranchCoverageMagic(string fileName, uint256 branchId, uint256 locationIdx);
event __AssertPreCoverageMagic(string fileName, uint256 branchId);
event __AssertPostCoverageMagic(string fileName, uint256 branchId);


	address payable public magician;
	uint cooldownTime = 1 days;

	struct Audiences {
		uint donation;
		uint32 [4] cooldown;
	}

	mapping (address=>Audiences) public audience;

	constructor() payable public {emit __FunctionCoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',1);

emit __CoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',16);
		emit __StatementCoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',1);
magician = msg.sender;
	}

	modifier checkEnoughDonation(uint _price) {emit __FunctionCoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',2);

emit __CoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',20);
		emit __AssertPreCoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',1);
emit __StatementCoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',2);
require(audience[msg.sender].donation >= _price);emit __AssertPostCoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',1);

emit __CoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',21);
		_;
	}

	function donate() payable public {emit __FunctionCoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',3);

emit __CoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',25);
      	emit __StatementCoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',3);
audience[msg.sender].donation+=msg.value;
  	}

  	function getMagician() public      returns(address) {emit __FunctionCoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',4);

emit __CoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',29);
		emit __StatementCoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',4);
return magician;
	}

  	function getDonation(address _audience) public      returns(uint){emit __FunctionCoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',5);

emit __CoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',33);
  		emit __StatementCoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',5);
return audience[_audience].donation;
  	}

  	function getCooldownTime(uint _type) public      returns(uint32){emit __FunctionCoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',6);

emit __CoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',37);
		emit __StatementCoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',6);
return audience[msg.sender].cooldown[_type];
	}

  	function _triggerCooldown(uint _type) internal {emit __FunctionCoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',7);

emit __CoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',41);
  		emit __StatementCoverageMagic('/Users/hank/Desktop/Blockchain/TCI/Magic/contracts/Magic.sol',7);
audience[msg.sender].cooldown[_type] += uint32(now + cooldownTime);
  	}
}