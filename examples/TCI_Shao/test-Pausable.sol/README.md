# Solidity test practices: Pausable.sol


*Testing language: Solidity*

source: [SelfToken-Pausable.sol](https://github.com/selftoken-projects/self-token/blob/master/contracts/openzeppelin-solidity/lifecycle/Pausable.sol)

## Files
- **contracts/Pausable.sol:**
the targetted contract to be tested
- **test/TestPausable.sol**
the testing contract

<br>

## How to run
```
# under test-pausable
npx solidity-coverage

# Everything should go fine and generate an image like the following one:
```

![image](https://github.com/tienshaoku/Smart-Contract-Modular-Template/blob/master/examples/TCI_Shao/test-Pausable.sol/report_in_terminal.png)

<br>

## Inspect the coverage report
```
# under test-pausable/coverage
open index.html

# We can then inspect the detailed coverage report of each line.
```

![image](https://github.com/tienshaoku/Smart-Contract-Modular-Template/blob/master/examples/TCI_Shao/test-Pausable.sol/html_report.png)
