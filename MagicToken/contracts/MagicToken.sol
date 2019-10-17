pragma solidity >=0.4.24 <0.6.0;
 

import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";

contract MagicToken is ERC20, ERC20Detailed {

  uint256 public constant INITIAL_SUPPLY = 1e4 * (1e18);
  uint cooldownTime = 1 days;

  constructor() public ERC20Detailed("MagicToken", "MAG", 18) {
    _mint(msg.sender, INITIAL_SUPPLY);
  }
}