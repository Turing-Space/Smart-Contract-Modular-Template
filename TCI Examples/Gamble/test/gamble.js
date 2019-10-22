const Gamble = artifacts.require("Gamble");
const Web3 = require('web3');
const BN = web3.utils.BN;
var winCount = 0

contract('Gamble', (accounts) => {
    it('Send Banker ETH', async () => {
        const gambleInstance = await Gamble.deployed();
        const amount = Web3.utils.toWei('1', 'ether');
        await gambleInstance.sendTransaction({ from: accounts[0], value: amount })
        const gamblBalance = await gambleInstance.getBalance.call();
        console.log(new BN(gamblBalance).toString());
        assert.equal(gamblBalance, amount, "Gamble balance doesn't equal with " + amount);
    });
    it('Set Return Rate', async () =>{
        const gambleInstance = await Gamble.deployed();
        const amount = 30
        await gambleInstance.setReturnRate.sendTransaction(amount, { from: accounts[0]});
        const returnRate = await gambleInstance.returnRate.call();
        assert.equal(returnRate, amount, "Gamble return rate doesn't equal with " + amount);
    });
    it('Set Return Rate(not owner)', async () =>{
        const gambleInstance = await Gamble.deployed();
        const amount = 30
        let error = ""
        try {
            await gambleInstance.setReturnRate.sendTransaction(amount, { from: accounts[1]});
        } catch (e) {
            error = e.name;
        }
        const returnRate = await gambleInstance.returnRate.call();
        assert.equal(error, "Error", "The accounts[1] shouldn't call this function");
    });
    it('Play (Contract no Ether)', async () =>{
        const gambleInstance = await Gamble.deployed();
        const amount = Web3.utils.toWei('3', 'ether');
        let error = ""
        try {
            await gambleInstance.wannaPlayAGame.sendTransaction({ from: accounts[1], value: amount });
        } catch (e) {
            error = e.name;
        }
        assert.equal(error, "Error", "The contract doesn't have enough ether. It shoun't play.");
    });
    it('Play (Player bet not enough)', async () =>{
        const gambleInstance = await Gamble.deployed();
        const bankerBalance = Web3.utils.toWei('5', 'ether');
        const bet = Web3.utils.toWei('1', 'ether');
        let error = ""
        await gambleInstance.sendTransaction({ from: accounts[0], value: bankerBalance })
        try {
            await gambleInstance.wannaPlayAGame.sendTransaction({ from: accounts[1], value: bet });
        } catch (e) {
            error = e.name;
        }
        assert.equal(error, "Error", "The bet must be greater than or equal to 2. It shoun't play.");
    });
    for ( let i = 0; i< 5; i++) {
        test(accounts);
    }
    it('Get ETH (owner)', async () => {
        const gambleInstance = await Gamble.deployed();
        const contractBalanceBeforeTake = await gambleInstance.getBalance.call();
        const takeETH = Web3.utils.toWei('2', 'wei');
        await gambleInstance.getETH.sendTransaction(takeETH, {from: accounts[0]});
        const contractBalanceAfterTake = await gambleInstance.getBalance.call();

        assert.equal(contractBalanceAfterTake, contractBalanceBeforeTake - takeETH, "The contract balance should be" + contractBalanceBeforeTake - takeETH + ".");
    });
    it('Get ETH (not owner)', async () => {
        const gambleInstance = await Gamble.deployed();

        let error = ""
        try {
            await gambleInstance.getETH.sendTransaction(1, {from: accounts[1]});
        } catch (e) {
            error = e.name;
        }
        assert.equal(error, "Error", "The account shouldn't take ETH.");
    });
    it('Get ETH (over the contract ETH)', async () => {
        const gambleInstance = await Gamble.deployed();
        const contractBalanceBeforeTake = await gambleInstance.getBalance.call();
        const takeETH = Web3.utils.toWei('100', 'ether');
        let error = ""
        try {
            await gambleInstance.getETH.sendTransaction(takeETH, {from: accounts[0]});
        } catch (e) {
            error = e.name;
        }

        assert.equal(error, "Error", "The contract doesn't have enough ETH.");
    });
});

function test(accounts) {
    it('Play', async () =>{
        const gambleInstance = await Gamble.deployed();
        const returnRate = (new BN (await gambleInstance.returnRate.call())).toNumber();
        const bankerBalance = Web3.utils.toWei('5', 'ether');
        const bet = Web3.utils.toWei('3', 'ether');
        let error = ""
        await gambleInstance.sendTransaction({ from: accounts[0], value: bankerBalance })
        const player = accounts[1];
        const result = await gambleInstance.wannaPlayAGame.sendTransaction({ from: player, value: bet });
        const blockNumber = await web3.eth.getBlock(result.receipt.blockNumber);
        const blockTimestamp = blockNumber.timestamp
        console.log(blockTimestamp);
        console.log(result.receipt.logs[0].event);
        if (blockTimestamp % 2 == 0) {
            winCount++;
            assert.equal(result.receipt.logs[0].event, "win", "Should win");
            let winETH = await gambleInstance.player_ETH.call(player);
            winETH = new BN(winETH).toString()
            const shouldTakeETH = (bet * returnRate / 10 * winCount).toString();
            console.log(winETH);
            assert.equal(winETH, shouldTakeETH,"Should get "+ shouldTakeETH);
            const firstPlacePlayer = await gambleInstance.firstPlacePlayer.call();
            assert.equal(firstPlacePlayer, player,"The player account should be the first place.");
        } else {
            assert.equal(result.receipt.logs[0].event, "lost", "Should win");
            let winETH = await gambleInstance.player_ETH.call(player);
            winETH = new BN(winETH).toString()
        }
    });
}