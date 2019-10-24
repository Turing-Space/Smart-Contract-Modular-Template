const magic = artifacts.require("Magic");
const magicAct = artifacts.require("MagicAct");

module.exports = function(deployer) {
  deployer.deploy(magicAct);
  deployer.link(magicAct, magic);
  deployer.deploy(magic);
};