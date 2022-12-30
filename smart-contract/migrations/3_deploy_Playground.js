const Playground = artifacts.require("./Playground.sol");

module.exports = async function(deployer, network, accounts) {
    await deployer.deploy(Playground,7844);
};
