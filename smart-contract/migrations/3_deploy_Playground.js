const Playground = artifacts.require("./Playground.sol");
const GoldHookToken = artifacts.require("./GoldHookToken.sol");

const _goldHookToken = GoldHookToken.address;



// see https://docs.chain.link/docs/vrf/v2/subscription/supported-networks/#configurations


module.exports = async function(deployer, network, accounts) {
    let _vrfCoordinator,_subscriptionId,_keyHash;

    if(network == 'bsc'){
        
    }else if(network == 'bscTest'){
        _vrfCoordinator = '0x6A2AAd07396B36Fe02a22b33cf443582f682c82f'
        _keyHash = '0xd4bb89654db74673a187bd804519e65e3f71a52bc55f11da7601a13dcf505314'
        _subscriptionId = 2400
        
    }else if(network == 'goerli'){
        _vrfCoordinator = '0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D'
        _keyHash = '0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15'
        _subscriptionId = 7844
        
    }else if(network == 'mainnet'){

    }
    await deployer.deploy(Playground,_goldHookToken,_vrfCoordinator,_keyHash,_subscriptionId);

    const playground = await Playground.deployed()
    const goldHookToken = await GoldHookToken.deployed()
    const deployerAddress = accounts[0]
    // let amount = await goldHookToken.balanceOf(deployerAddress)
    // amount = amount*0.8
    const amount = web3.utils.toWei("80000000")
    
    await goldHookToken.transfer(playground.address, amount, { from: deployerAddress })

    let bal = await goldHookToken.balanceOf(playground.address)
    console.log('=== balance of the GoldHookToken in this contract address '+ playground.address +' ===', String(bal))

    if(network == 'bsc'){
        
    }else if(network == 'bscTest'){
        
        await playground.setUnitValue(web3.utils.toWei("0.003"), { from: deployerAddress })
        await playground.setMinWithdrawValue(web3.utils.toWei("0.3"), { from: deployerAddress })

    }else if(network == 'goerli'){

        await playground.setUnitValue(web3.utils.toWei("0.001"), { from: deployerAddress })
        await playground.setMinWithdrawValue(web3.utils.toWei("0.1"), { from: deployerAddress })
        
    }else if(network == 'mainnet'){

    }

};
