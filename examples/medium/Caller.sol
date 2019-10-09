pragma solidity ^0.4.0;

// For more info about calling function from another contract, refer to:
// https://ethereum.stackexchange.com/questions/9733/calling-function-from-deployed-contract

 
contract Callee{
    uint data = 10;
     
    function increaseData(uint _val) public returns (uint){
        return data += _val;
    }
    
    function getData() public view returns (uint){
        return data;
    }

}

contract Caller{
   
   function callCallee(address _addr) public returns(bool){
       bytes4 methodId = bytes4(keccak256("increaseData(uint256)"));
       
       // the second parameter 1 is the parameter sent to the function increaseData() as _val
       return _addr.call(methodId, 1);
   } 
   
}
