pragma solidity ^0.5.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Pausable.sol";

contract TestPausable{
    Pausable pausable = Pausable(DeployedAddresses.Pausable());

    function testPause() public {
        Assert.isFalse(pausable.unpause(), "?");
        
        pausable.pause();
        bool returnedPaused = pausable.paused();
        Assert.equal(returnedPaused, true, "really? ");
        
    }

    function testUnpause() public {
        pausable.unpause();
        bool returnedPaused = pausable.paused();

        Assert.equal(returnedPaused, false, "really? ");


    }

}
