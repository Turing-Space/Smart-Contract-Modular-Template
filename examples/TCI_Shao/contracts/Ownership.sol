pragma solidity^0.5.0;


contract OwnershipChange{
    address public owner;
    
    event OwnershipRenounced(address indexed previousOwner);
    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function renounceOwnership() public onlyOwner {
        emit OwnershipRenounced(owner);
        owner = address(0);
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        _transferOwnership(_newOwner);
    }

    function _transferOwnership(address _newOwner) internal {
        require(_newOwner != address(0));
        emit OwnershipTransferred(owner, _newOwner);
        owner = _newOwner;
    }
}

contract Ownership is OwnershipChange{ 
    constructor() public {
        owner = msg.sender;
    }
    
    function returnOwner() public returns(address){
        return owner;
    }
}


