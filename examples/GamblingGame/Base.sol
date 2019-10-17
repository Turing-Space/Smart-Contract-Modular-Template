solidity ^0.4.24;

contract Base{
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

	uint constant internal FEE_PERCENT = 1;
	uint constant internal MIN_FEE = 0.0003 ether;

	uint constant internal MIN_STAKE = 0.001 ether;
	uint constant internal MAX_STAKE = 10 ether;

	uint constant public JACKPOT_NUM = 777;
	uint constant internal JACKPOT_THRESHOLD = 0.1 ether;
	uint constant internal JACKPOT_FEE = 0.001 ether;
	uint constant internal JACKPOT_MOD = 1000;

	uint internal jackpotAmount = 0;

	uint constant internal ROULETTE_BASE_STAKE = 0.01 ether;

	uint constant internal TYPE_ROLL = 0;
	uint constant internal TYPE_ROULETTE = 1;
	uint constant internal TYPE_SANGOKUSHI = 2;
	uint constant internal TYPE_BASKETBALL = 3;
	uint constant internal TYPE_SLOT_30 = 4;
	uint constant internal TYPE_GRID_10 = 5;


	uint constant internal ROLL_MAX_MOD = 100;
	uint constant internal ROULETTE_MAX_MOD = 37;


	mapping(bytes32 => BetData) internal bets;

	event BetEvent(uint gamdId, bytes32 commit, bytes data, bool triggerJackpot);
	event RollPayment(address player, uint gameId, uint payAmount, uint value, uint result, uint betAmount, uint betValue, uint jackpotAmount, bytes32 betTx);
	event RoulettePayment(address player, uint gameId, uint payAmount, uint value, uint result, uint betAmount, bytes32 betTx,bytes betData);
	event SangokushiPayment(address player, uint gameId, uint mode, uint payAmount, uint value, uint result, uint betAmount, uint betValue, bytes32 betTx);
	event BasketballPayment(address player, uint gameId, uint payAmount, uint value, uint data, uint betAmount, bytes32 betTx);
	event Slot30Payment(address player, uint gameId, uint payAmount, uint value, uint data, uint betAmount, bytes32 betTx);
	event Grid10Payment(address player, uint gameId, uint payAmount, uint value, uint data, uint betAmount, bytes32 betTx);
	event PaymentFail(address player, uint amount);


	function getJackpotAmount() public view returns(uint){
		return jackpotAmount;
	}

}
