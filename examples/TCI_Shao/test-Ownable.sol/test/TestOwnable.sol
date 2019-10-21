pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Ownable.sol";

contract TestOwnable {
  address public ownerOfThis;
  Ownable ownable = Ownable(DeployedAddresses.Ownable());

  // The above line implies that there's actually another address
  // that deploys the Ownable contract, rather than this TestOwnable contract. 
  // Therefore, get the address that deploys Ownable and TestOwnable with constructor()

  constructor () public {
    ownerOfThis = msg.sender;
  }

  function testConstructor() public {
    address returnedOwner = ownable.owner();

    /*
    string memory expectedOwner_s = addressToString(address(this));    
    string memory returnedOwner_s = addressToString(returnedOwner);
    string memory a = "address 1: ";
    string memory b = "; address 2: ";
    string memory f = append(a, returnedOwner_s, b, expectedOwner_s);
    */

    //Assert.equal(returnedOwner, ownerOfThis, f);
    Assert.equal(returnedOwner, ownerOfThis, "so damn complicated :(");
  }

  function addressToString(address _addr) public pure returns(string memory) {
    bytes32 value = bytes32(uint256(_addr));
    bytes memory alphabet = "0123456789abcdef";

    bytes memory str = new bytes(42);
    str[0] = '0';
    str[1] = 'x';
    for (uint i = 0; i < 20; i++) {
        str[2+i*2] = alphabet[uint(uint8(value[i + 12] >> 4))];
        str[3+i*2] = alphabet[uint(uint8(value[i + 12] & 0x0f))];
    }
    return string(str);
}

  function append(string memory a, string memory b, string memory c, string memory d) internal pure returns (string memory) {
      return string(abi.encodePacked(a, b, c, d));
  }
}
