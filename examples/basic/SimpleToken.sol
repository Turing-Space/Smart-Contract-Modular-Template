pragma solidity ^0.6.0;

import "https://raw.githubusercontent.com/OpenZeppelin/openzeppelin-contracts/master/contracts/token/ERC20/ERC20.sol";


/**
 * @title SimpleToken
 * @dev Very simple ERC20 Token example, where all tokens are pre-assigned to the creator.
 * Note they can later distribute these tokens as they wish using `transfer` and other
 * `ERC20` functions.
 * Referenced from: https://github.com/OpenZeppelin/openzeppelin-solidity/blob/master/contracts/examples/SimpleToken.sol
 */
contract SimpleToken is ERC20 {

  uint256 public constant INITIAL_SUPPLY = 1e4 * (1e18);

  /**
   * @dev Constructor that gives msg.sender all of existing tokens.
   */
  constructor() public ERC20("TaiyakiToken", "TYK") {
    _mint(msg.sender, INITIAL_SUPPLY);
  }

}
