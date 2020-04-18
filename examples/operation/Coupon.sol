pragma solidity ^0.4.13;

// 票卷所有權轉移
contract Coupon {
  // Configuration
  uint256 public ID;
  address public issuer;
  address public owner;
  uint256 public startTime;
  uint256 public endTime;
  uint256 public value;

  // event
  event ChangeOwnerToEvent(address new_owner);

  // Functions with this modifier can only be executed by the owner
  modifier onlyOwner(){
      assert(owner == msg.sender);
      _;
  }

  // Functions with this modifier can only be executed by the issuer
  modifier onlyIssuer() {
    assert(issuer == msg.sender);
    _;
  }

  // Check whether the redeem time is between the span of startTime and endTime.
  modifier isValidRedeemTime(){
    require(startTime <= now);
    require(endTime >= now);
    _;
  } 

  // Constructor
  function Coupon(uint256 id, uint256 _startTime, uint256 _endTime, uint256 _value, address _issuer) {
    require(_endTime >= _startTime);

    ID = id;
    issuer =  _issuer;   // issuer is default to be the owner of the coupon
    owner = _issuer;
    startTime =  _startTime;
    endTime =  _endTime;
    value =  _value;
  }

  // receiver is the owner to be changed to 
  function changeOwnerTo(address receiver) public onlyOwner {
    owner = receiver;
    ChangeOwnerToEvent(receiver);
  }

  // transfer the coupon ownership
  function transfer(address receiver) public onlyOwner {
    changeOwnerTo(receiver);
  }
}