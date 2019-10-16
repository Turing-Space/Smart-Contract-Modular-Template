pragma solidity 0.4.24;

import { ERC777Token } from "../ERC777/ERC777Token.sol";

// 批量操作
contract BatchSendOperator {
  /// @notice Send tokens to multiple recipients.
  /// @param _recipients The addresses of the recipients
  /// @param _amounts The numbers of tokens to be transferred
  function batchSend(address _tokenContract, address[] _recipients, uint256[] _amounts, bytes _userData) external {
    require(_recipients.length == _amounts.length, "The lengths of _recipients and _amounts should be the same.");

    ERC777Token tokenContract = ERC777Token(_tokenContract);
    for (uint256 i = 0; i < _recipients.length; i++) {
      tokenContract.operatorSend(msg.sender, _recipients[i], _amounts[i], _userData, "");
    }
  }
}
