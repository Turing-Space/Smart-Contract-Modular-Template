pragma solidity >= 0.4.24;

import "./MoneyMarket.sol";
import "./ERC20.sol";

contract Collateral {
    address payable owner;
    ERC20 underlying = ERC20(0x25a01a05C188DaCBCf1D61Af55D4a5B4021F7eeD);
    address payable public compound = 0x2B536482a01E620eE111747F8334B395a42A555E;
    CErc20 cerc20 = CErc20(compound);
    
    function () payable external {}
    
    constructor () payable public {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function withdraw() onlyOwner public {
        owner.transfer(address(this).balance);
    }
    
    function letsGo(uint _amount) onlyOwner public {
        underlying.approve(compound, _amount);
        // problem here
        assert(cerc20.mint(_amount) == 0);
    }
    
    function redeemOK(uint _amount) onlyOwner public {
        require(cerc20.redeem(_amount) == 0, "something went wrong");
    }
    
}
