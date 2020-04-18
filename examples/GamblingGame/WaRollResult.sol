pragma solidity ^0.4.24;

import "./WaRollPlay.sol";

contract WaRollResult is WaRollPlay{

	constructor() public payable {}

	function kill() public ownerOnly {
		selfdestruct(msg.sender);
	}

	function doResult(uint value, bytes32 blockHash, bytes32 betTx, uint payment, uint data) public croupierOnly payable {
		bytes32 commit = keccak256(abi.encodePacked(value));
		BetData storage bet = bets[commit];
		require(blockhash(bet.blockNum) == blockHash);
		if (bet.gameId == TYPE_ROLL) {
			doRollResult(value, bet, betTx);
		}else if (bet.gameId == TYPE_ROULETTE) {
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
