pragma solidity ^0.4.24;

import "./Modifier.sol";
import "./Base.sol";

contract WaRollPlay is Modifier, Base{

	function doGrid10(uint stakePerLine, uint lineCount, uint expiredBlockNum, bytes32 commit, bytes32 r, bytes32 s) public payable validSignAndBlock(expiredBlockNum, commit, r, s) {
		uint stake = msg.value;
		require(stake >= MIN_STAKE && stake <= MAX_STAKE);
		require(stake == stakePerLine * lineCount);
		BetData storage bet = bets[commit];
		require(bet.player == address(0));
		bet.gameId = TYPE_GRID_10;
		bet.amount = stake;
		bet.player = msg.sender;
		bet.blockNum = block.number;
		bytes memory data = toBytes(stakePerLine, lineCount);
		emit BetEvent(bet.gameId, commit, data, false);
	}

	function doSlot30(uint stakePerLine, uint lineCount, uint expiredBlockNum, bytes32 commit, bytes32 r, bytes32 s) public payable validSignAndBlock(expiredBlockNum, commit, r, s) {
		uint stake = msg.value;
		require(stake >= MIN_STAKE && stake <= MAX_STAKE);
		require(stake == stakePerLine * lineCount);
		BetData storage bet = bets[commit];
		require(bet.player == address(0));
		bet.gameId = TYPE_SLOT_30;
		bet.amount = stake;
		bet.player = msg.sender;
		bet.blockNum = block.number;
		bytes memory data = toBytes(stakePerLine, lineCount);
		emit BetEvent(bet.gameId, commit, data, false);
	}


	function doBasketball(uint expiredBlockNum, bytes32 commit, bytes32 r, bytes32 s) public payable validSignAndBlock(expiredBlockNum, commit, r, s) {
		uint stake = msg.value;
		require(stake >= MIN_STAKE && stake <= MAX_STAKE);
		BetData storage bet = bets[commit];
		require(bet.player == address(0));
		bet.gameId = TYPE_BASKETBALL;
		bet.amount = stake;
		bet.player = msg.sender;
		bet.blockNum = block.number;
		bytes memory data = toBytes(stake);
		emit BetEvent(bet.gameId, commit, data, false);
	}

	function doSangokushiBet(uint mode, uint value, uint expiredBlockNum, bytes32 commit, bytes32 r, bytes32 s) public payable validSignAndBlock(expiredBlockNum, commit, r, s) {
		require(mode == 0 || mode == 1, "invalid mode");
		require(value >= 0 && value <= 2, "invalid value");
		uint stake = msg.value;
		require(stake >= MIN_STAKE && stake <= MAX_STAKE);
		BetData storage bet = bets[commit];
		require(bet.player == address(0));
		bet.gameId = TYPE_SANGOKUSHI;
		bet.value = value;
		bet.amount = stake;
		if(mode == 0){
			bet.possiblePayout = stake * 138 / 100;
		}else if(mode == 1){
			bet.possiblePayout = stake * 276 / 100;
		}
		bet.mode = mode;
		bet.player = msg.sender;
		bet.blockNum = block.number;
		bytes memory data = toBytes(mode, value, bet.possiblePayout);
		emit BetEvent(bet.gameId, commit, data, false);
	}

	function doRollBet(uint value, uint expiredBlockNum, bytes32 commit, bytes32 r, bytes32 s) public payable validSignAndBlock(expiredBlockNum, commit, r, s) {
		require(value >= 1 && value <= ROLL_MAX_MOD - 3, "invalid value");
		uint stake = msg.value;
		require(stake >= MIN_STAKE && stake <= MAX_STAKE);
		BetData storage bet = bets[commit];
		require(bet.player == address(0));
		bet.gameId = TYPE_ROLL;
		bet.value = value;
		bet.amount = stake;
		bet.player = msg.sender;
		bet.blockNum = block.number;
		uint fee = stake / 100 * FEE_PERCENT;
		if (fee < MIN_FEE) {
			fee = MIN_FEE;
		}
		uint jackpotFee = 0;
		bet.triggerJackpot = stake >= JACKPOT_THRESHOLD;
		if(bet.triggerJackpot){
			jackpotFee = JACKPOT_FEE;
			jackpotAmount += JACKPOT_FEE;
		}
		bet.possiblePayout = (stake - fee - jackpotFee) * ROLL_MAX_MOD / value;
		bytes memory data = toBytes(value, bet.possiblePayout);
		emit BetEvent(bet.gameId, commit, data, bet.triggerJackpot);
	}


	function doRouletteBet(bytes data, uint expiredBlockNum, bytes32 commit, bytes32 r, bytes32 s) public payable validSignAndBlock(expiredBlockNum, commit, r, s) {
		uint stake = msg.value;
		validRouletteBetData(data, stake);
		BetData storage bet = bets[commit];
		require(bet.player == address(0));
		bet.gameId = TYPE_ROULETTE;
		bet.betData = data;
		bet.amount = stake;
		bet.player = msg.sender;
		bet.blockNum = block.number;
		emit BetEvent(bet.gameId, commit, data,false);
	}


	function toBytes(uint v1) private pure returns (bytes){
		bytes32 v1Bytes = bytes32(v1);
		bytes memory data = new bytes(v1Bytes.length);
		for(uint i = 0 ; i < v1Bytes.length; i ++){
			data[i] = v1Bytes[i];
		}
		return data;
	}

	function toBytes(uint v1, uint v2) private pure returns (bytes){
		bytes32 v1Bytes = bytes32(v1);
		bytes32 v2Bytes = bytes32(v2);
		bytes memory data = new bytes(v1Bytes.length + v2Bytes.length);
		for(uint i = 0 ; i < v1Bytes.length; i ++){
			data[i] = v1Bytes[i];
		}
		for(uint j = 0 ; j < v2Bytes.length; j ++){
			data[j + v1Bytes.length] = v2Bytes[j];
		}
		return data;
	}

	function toBytes(uint v1, uint v2, uint v3) private pure returns (bytes){
		bytes32 v1Bytes = bytes32(v1);
		bytes32 v2Bytes = bytes32(v2);
		bytes32 v3Bytes = bytes32(v3);
		bytes memory data = new bytes(v1Bytes.length + v2Bytes.length + v3Bytes.length);
		for(uint i = 0 ; i < v1Bytes.length; i ++){
			data[i] = v1Bytes[i];
		}
		for(uint j = 0 ; j < v2Bytes.length; j ++){
			data[j + v1Bytes.length] = v2Bytes[j];
		}
		for(uint k = 0 ; k < v3Bytes.length; k ++){
			data[k + v1Bytes.length + v2Bytes.length] = v3Bytes[k];
		}
		return data;
	}

	function validRouletteBetData(bytes data, uint amount) pure private {
		uint length = uint8(data[0]);
		require(data.length == length * 2 + 1);
		uint total = 0;
		for (uint i = 0; i < length; i ++) {
			total += uint8(data[2 + i * 2]);
		}
		require(total * ROULETTE_BASE_STAKE == amount);
	}

}
