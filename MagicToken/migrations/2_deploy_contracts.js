const MagicAct = artifacts.require("./MagicAct.sol");
const Audience = artifacts.require("./Audience.sol");
const MagicToken = artifacts.require("./MagicToken.sol");

module.exports = function(deployer) {
  deployer.deploy(MagicAct);
  deployer.link(MagicAct,Audience);
  deployer.deploy(Audience);
  deployer.link(Audience,MagicToken);
  deployer.deploy(MagicToken);
};
