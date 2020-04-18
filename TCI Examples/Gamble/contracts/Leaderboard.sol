pragma solidity >=0.4.21 <0.6.0;

contract Leaderboard {
    address[] private players;
    mapping (address => uint) public player_ETH;
    address public firstPlacePlayer = address(0);

    function _updateFirstPlace(address _address) private{
        // The ETH that you get needs to be greater than the first place player who is in the first time.
        if (player_ETH[_address] > player_ETH[firstPlacePlayer]) {
            firstPlacePlayer = _address;
        }
    }

    function enterLeaderBoard(address _address, uint winAmount) internal {
        if (!_isInLeaderBoard(_address)) {
            players.push(_address);
        }
        player_ETH[_address] += winAmount;
        _updateFirstPlace(_address);
    }

    function _isInLeaderBoard(address _address) private view returns(bool) {
        for (uint i = 0; i < players.length ; i++) {
            if (players[i] == _address) {
                return true;
            }
        }
        return false;
    }
}