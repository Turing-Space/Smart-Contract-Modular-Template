var Ownable = artifacts.require("../contracts/Ownable.sol");

module.exports = function(deployer) {
  deployer.deploy(Ownable);
};

