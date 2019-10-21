# Solidity test practices: Ownable.sol


*Testing language: Solidity*

source: [SelfToken-Ownable.sol](https://github.com/selftoken-projects/self-token/blob/master/contracts/openzeppelin-solidity/ownership/Ownable.sol)

## Files
- **contracts/Ownable.sol:**
the targetted contract to be tested
- **test/TestOwnable.sol**
the testing contract

<br>

## How to run
```
# under test-pausable
npx solidity-coverage

# Now there should be a report with very low coverage...
```
![image](https://github.com/tienshaoku/Smart-Contract-Modular-Template/blob/master/examples/TCI_Shao/test-Ownable.sol/report.png)

<br>

## Why?
Inside the TestOwnable.sol, I inspect the difference between **msg.sender of constructor()** and the **owner of Ownable contract**
```
# deploy the targetted contract to test with
Ownable ownable = Ownable(DeployedAddresses.Ownable());
address returnedOwner = ownable.owner();
```

```
address public ownerOfThis;
constructor () public {
    ownerOfThis = msg.sender;
}
```
```
# the coding test
Assert.equal(returnedOwner, ownerOfThis, "so damn complicated :(");
```
Why not simply look into the owner of Ownable contract and **the address of current contract**?
```
# Why isn't the result of this line true?
Assert.equal(returnedOwner, address(this), <message>);
```

The reason is that in fact, ***the contract Ownable isn't deployed by contract TestOwnable, but by the same address that deploys TestOwnable***.

Therefore, **address(this) != owner of contract Ownable**.

<br>

## Then where is the deployer address?
To know better the reason behind this, I dig into the directory storing Assert.sol:
```
/usr/local/lib/node_modules/truffle/build
```

![image](https://github.com/tienshaoku/Smart-Contract-Modular-Template/blob/master/examples/TCI_Shao/test-Ownable.sol/directory.png)

but **fail to find DeployedAddresses.sol** ?

Therefore, as usual I turn to Google and find the following article: [Click!](http://www.talkcrypto.org/blog/2019/01/11/where-is-deployedaddresses-sol-when-testing-in-truffle/)
