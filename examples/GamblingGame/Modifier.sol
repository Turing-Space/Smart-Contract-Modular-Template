pragma solidity ^0.4.25;

contract Modifier{

	address private owner;
	address private signer;
	address public croupier;

	constructor() public{
		owner = msg.sender; 
		signer = msg.sender;
		croupier = msg.sender;
	}

	modifier ownerOnly(){
		require(msg.sender == owner, "not owner");
		_;
	}

	modifier croupierOnly(){
		require(msg.sender == croupier, "not croupier");
		_;
	}

	modifier validSignAndBlock(uint blockNum, bytes32 commit, bytes32 r, bytes32 s){
		require(blockNum >= block.number, "commit has expired");
		bytes32 v1 = keccak256(abi.encodePacked(uint40(blockNum), commit));
		require(signer == ecrecover(v1, 27, r, s) || signer == ecrecover(v1, 28, r, s), "signer valid error");
		_;
	}

	function setCroupier(address c) public ownerOnly {
		croupier = c;
	}

	function setSigner(address c) public ownerOnly {
		signer = c;
	}
}
