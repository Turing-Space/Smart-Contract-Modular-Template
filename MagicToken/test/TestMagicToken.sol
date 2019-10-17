pragma solidity >=0.4.25 <0.6.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/MagicToken.sol";

contract TestMagicToken {

  function testInitialBalanceUsingDeployedContract() public {
    MagicToken magic = MagicToken(DeployedAddresses.MagicToken());

    uint expected = 1e4 * (1e18);

    Assert.equal(magic.balanceOf(tx.origin), expected, "Owner should have 10000 MagicToken initially");
  }

}
