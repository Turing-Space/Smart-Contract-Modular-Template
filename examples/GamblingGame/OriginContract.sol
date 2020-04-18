/**
 *Submitted for verification at Etherscan.io on 2019-10-17
 *Contract address : 0x0a1014c911A0134F49f16DCf750d8AAadBE9a957
 */

pragma solidity ^0.4.24;

contract WaRoll {

	struct BetData {
		uint gameId;
		address player;
		uint amount;
		uint possiblePayout;
		uint mode;
		uint value;
		uint blockNum;
		bool triggerJackpot;
		bytes betData;
	}

	uint constant private FEE_PERCENT = 1;
	uint constant private MIN_FEE = 0.0003 ether;

	uint constant private MIN_STAKE = 0.001 ether;
	uint constant private MAX_STAKE = 10 ether;

	uint constant public JACKPOT_NUM = 777;
	uint constant private JACKPOT_THRESHOLD = 0.1 ether;
	uint constant private JACKPOT_FEE = 0.001 ether;
	uint constant private JACKPOT_MOD = 1000;

	uint private jackpotAmount = 0;

	uint constant private ROULETTE_BASE_STAKE = 0.01 ether;

	uint constant private TYPE_ROLL = 0;
	uint constant private TYPE_ROULETTE = 1;
	uint constant private TYPE_SANGOKUSHI = 2;
	uint constant private TYPE_BASKETBALL = 3;
	uint constant private TYPE_SLOT_30 = 4;
	uint constant private TYPE_GRID_10 = 5;


	uint constant private ROLL_MAX_MOD = 100;
	uint constant private ROULETTE_MAX_MOD = 37;

	mapping(bytes32 => BetData) private bets;

	address private owner;
	address private signer;
	address public croupier;

	event BetEvent(uint gamdId, bytes32 commit, bytes data, bool triggerJackpot);
	event RollPayment(address player, uint gameId, uint payAmount, uint value, uint result, uint betAmount, uint betValue, uint jackpotAmount, bytes32 betTx);
	event RoulettePayment(address player, uint gameId, uint payAmount, uint value, uint result, uint betAmount, bytes32 betTx,bytes betData);
	event SangokushiPayment(address player, uint gameId, uint mode, uint payAmount, uint value, uint result, uint betAmount, uint betValue, bytes32 betTx);
	event BasketballPayment(address player, uint gameId, uint payAmount, uint value, uint data, uint betAmount, bytes32 betTx);
	event Slot30Payment(address player, uint gameId, uint payAmount, uint value, uint data, uint betAmount, bytes32 betTx);
	event Grid10Payment(address player, uint gameId, uint payAmount, uint value, uint data, uint betAmount, bytes32 betTx);
	event PaymentFail(address player, uint amount);

	constructor() public payable {
		owner = msg.sender; 
		signer = msg.sender;
		croupier = msg.sender;
	}

	modifier ownerOnly(){
		require(msg.sender == owner, "not owner");
		_;
	}

	modifier croupierOnly(){
		require(msg.sender == croupier, "not croupier");
		_;
	}

	modifier validSignAndBlock(uint blockNum, bytes32 commit, bytes32 r, bytes32 s){
		require(blockNum >= block.number, "commit has expired");
		bytes32 v1 = keccak256(abi.encodePacked(uint40(blockNum), commit));
		require(signer == ecrecover(v1, 27, r, s) || signer == ecrecover(v1, 28, r, s), "signer valid error");
		_;
	}

	function getJackpotAmount() public view returns(uint){
		return jackpotAmount;
	}

	function setCroupier(address c) public ownerOnly {
		croupier = c;
	}

	function setSigner(address c) public ownerOnly {
		signer = c;
	}

	function kill() public ownerOnly {
		selfdestruct(owner);
	}

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

	function validRouletteBetData(bytes data, uint amount) pure private {
		uint length = uint8(data[0]);
		require(data.length == length * 2 + 1);
		uint total = 0;
		for (uint i = 0; i < length; i ++) {
			total += uint8(data[2 + i * 2]);
		}
		require(total * ROULETTE_BASE_STAKE == amount);
	}

	function doResult(uint value, bytes32 blockHash, bytes32 betTx, uint payment, uint data) public croupierOnly payable {
		bytes32 commit = keccak256(abi.encodePacked(value));
		BetData storage bet = bets[commit];
		require(blockhash(bet.blockNum) == blockHash);
		if (bet.gameId == TYPE_ROLL) {
			doRollResult(value, bet, betTx);
		} else if (bet.gameId == TYPE_ROULETTE) {
			doRouletteResult(value, bet, betTx, payment);
		}else if (bet.gameId == TYPE_SANGOKUSHI) {
			doSangokushiResult(value, bet, betTx);
		}else if (bet.gameId == TYPE_BASKETBALL){
			doBasketballResult(value, bet, betTx, payment, data);
		}else if(bet.gameId == TYPE_SLOT_30){
			doSlot30Result(value, bet, betTx, payment, data);
		}else if(bet.gameId == TYPE_GRID_10){
			doGrid10Result(value, bet, betTx, payment, data);
		}
	}

	function doGrid10Result(uint value, BetData bet, bytes32 betTx, uint payment, uint data) private croupierOnly {
		if(bet.player.send(payment)){
			emit Grid10Payment(bet.player, bet.gameId, payment, value, data, bet.amount, betTx);
		} else {
			emit PaymentFail(bet.player, payment);
		}
	}

	function doSlot30Result(uint value, BetData bet, bytes32 betTx, uint payment, uint data) private croupierOnly {
		if(bet.player.send(payment)){
			emit Slot30Payment(bet.player, bet.gameId, payment, value, data, bet.amount, betTx);
		} else {
			emit PaymentFail(bet.player, payment);
		}
	}

	function doBasketballResult(uint value, BetData bet, bytes32 betTx, uint payment, uint data) private croupierOnly {
		if(bet.player.send(payment)){
			emit BasketballPayment(bet.player, bet.gameId, payment, value, data, bet.amount, betTx);
		} else {
			emit PaymentFail(bet.player, payment);
		}
	}

	function doSangokushiResult(uint value, BetData bet, bytes32 betTx) private croupierOnly {
		uint result = value % 3;
		bool win = false;
		uint betValue = bet.value;
		uint tmp = 0;
		if(bet.mode == 0){
			tmp = (result + 1) % 3;
			win = betValue != tmp;
		}else if(bet.mode == 1){
			tmp = (result + 2) % 3;
			win = betValue == tmp;
		}
		uint payAmount = win ? bet.possiblePayout : 0;
		if (bet.player.send(payAmount)) {
			emit SangokushiPayment(bet.player, bet.gameId, bet.mode, payAmount, value, result, bet.amount, bet.value, betTx);
		} else {
			emit PaymentFail(bet.player, payAmount);
		}
	}

	function doRollResult(uint value, BetData bet, bytes32 betTx) private croupierOnly {
		uint result = (value % ROLL_MAX_MOD) + 1;
		uint payAmount = result > bet.value ? 0 : bet.possiblePayout;
		uint currentJackpotAmount = jackpotAmount;
		bool hitJackpot =isHitJackpopot(bet, value);
		if(hitJackpot){
			payAmount += jackpotAmount;
			jackpotAmount = 0;
		}
		if (bet.player.send(payAmount)) {
			emit RollPayment(bet.player, bet.gameId, payAmount, value, result, bet.amount, bet.value, currentJackpotAmount, betTx);
		} else {
			emit PaymentFail(bet.player, payAmount);
		}
	}

	function doRouletteResult(uint value, BetData bet, bytes32 betTx, uint paymentMutiplier) private croupierOnly {
		uint result = value % ROULETTE_MAX_MOD;
		uint payAmount = ROULETTE_BASE_STAKE * paymentMutiplier;
		if (bet.player.send(payAmount)) {
			emit RoulettePayment(bet.player, bet.gameId, payAmount, value, result, bet.amount, betTx, bet.betData);
		} else {
			emit PaymentFail(bet.player, payAmount);
		}
	}

	function isHitJackpopot( BetData bet, uint value) private pure returns(bool){
		return bet.triggerJackpot &&  value % JACKPOT_MOD == JACKPOT_NUM;
	}

	function() public payable {
	}

	function withdraw(address add, uint amount) ownerOnly payable public {
		add.transfer(amount);
	}

}
