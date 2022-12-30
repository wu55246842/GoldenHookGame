const GoldHookToken = artifacts.require("./GoldHookToken.sol");

module.exports = async function(deployer, network, accounts) {
    await deployer.deploy(GoldHookToken);
};
