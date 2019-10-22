pragma solidity >=0.4.21 <0.6.0;

import "../node_modules/@openzeppelin/contracts/ownership/Ownable.sol";
import "./Leaderboard.sol";

contract Gamble is Ownable, Leaderboard {
    uint public returnRate = 20;

    event win(address indexed winner, uint amount);
    event lost(address indexed loster, uint amount);

    function() external payable { }

    function getBalance() external view returns(uint) {
        return address(this).balance;
    }

    function setReturnRate(uint _returnRate) external onlyOwner {
        returnRate = _returnRate;
    }

    function wannaPlayAGame() external payable {
        uint playerMaxReward = msg.value / 10 * returnRate;
        require(address(this).balance > playerMaxReward, "I'm poor. Cannot play with you! Bye!");
        require(msg.value >= 2 ether, "I don't play with the poor! Bye!");

        if (_isBankerWin()) {
            enterLeaderBoard(msg.sender, playerMaxReward);
            msg.sender.transfer(playerMaxReward);
            emit win(msg.sender, playerMaxReward);
        } else {
            emit lost(msg.sender, playerMaxReward);
        }
    }

    function _isBankerWin() private view returns(bool) {
        return (block.timestamp % 2 == 0) ? true : false;
    }

    function getETH(uint amount) external onlyOwner {
        require(address(this).balance > amount, "The contract doesn't have enough ETH.");
        msg.sender.transfer(amount);
    }
}