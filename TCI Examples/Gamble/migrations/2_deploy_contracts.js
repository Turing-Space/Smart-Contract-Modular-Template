const Gamble = artifacts.require("Gamble");

module.exports = function(deployer) {
  deployer.deploy(Gamble);
};
