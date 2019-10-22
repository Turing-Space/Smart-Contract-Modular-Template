# SmartContract-Gamble
Learn how to modularize programs and test the code

## code-coverage
![image](https://github.com/jerryleetw1992/SmartContract-Gamble/blob/master/code-coverage.png)


## How to install
1. [Truffle](https://www.trufflesuite.com/)
```
$ npm install -g truffle
```
```
$ truffle init
```

2. [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts)
```
$ npm install @openzeppelin/contracts
```
Because our contract will import the Ownable.sol that from OpenZeppelin.

3. write your smart contract in the contracts folder.
In this Example, I just write [Gamble](https://github.com/jerryleetw1992/SmartContract-Gamble/blob/master/contracts/Gamble.sol) and [Leaderboard](https://github.com/jerryleetw1992/SmartContract-Gamble/blob/master/contracts/Leaderboard.sol)

## How to test
* write your test code in the test folder. Like: [gamble.js](https://github.com/jerryleetw1992/SmartContract-Gamble/blob/master/test/gamble.js)
> Truffle teaching: [TESTING YOUR CONTRACTS](https://www.trufflesuite.com/docs/truffle/testing/testing-your-contracts)

## How to show testing coverage
1. Install the solidity-coverage
[solidity-coverage](https://www.npmjs.com/package/solidity-coverage)
```
$ npm install --save-dev solidity-coverage
```

2. Run
```
$ npx solidity-coverage
```
**Note** You can see the details at the coverage/index.html

## How to play
1. The contract owner needs to transfer some ETH to the contract.
2. The player can send ETH to the wannaPlayAGame function.
3. The contract will check the block timestamps. If timestamps is even, the contract will win, and vice versa. 
> Note This is not a good example for judging win or lose. Because the miner will can set the timestamps to let he/she win.
> More Read: oracle
