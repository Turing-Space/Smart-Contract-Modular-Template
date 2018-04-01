pragma solidity ^0.4.13;

import "github.com/OpenZeppelin/zeppelin-solidity/contracts/math/SafeMath.sol";

contract Voting {
    using SafeMath for uint;
    
    uint[] candidateList; // list (optional)
    
    mapping (uint => uint) public candidates; // ID -> votes
    mapping (address => bool) public voted; 
    
    modifier isValidCandidate(uint candidateID){
        require(candidateID>=0 && candidateID<3); // 0, 1, 2
        _;
    }
    
    modifier hasNotVoted(){
        require(!voted[msg.sender]);
        // require(voted[msg.sender] == false);
        _;
    }
    
    function Voting() public { // constructor
        candidates[0] = 0;
        candidates[1] = 0;
        candidates[2] = 0;
        candidateList = [0, 0, 0]; // list init (optional)
    }
    
    function vote(uint candidateID) public isValidCandidate(candidateID) hasNotVoted() {
        candidates[candidateID] = candidates[candidateID].add(1); // one vote
        voted[msg.sender] = true;
    }
    
    function getVote(uint candidateID) public isValidCandidate(candidateID) constant returns (uint) {
        return candidates[candidateID];
    }
    
}