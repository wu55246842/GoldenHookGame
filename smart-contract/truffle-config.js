
const secret= require('./secret.json');
require('dotenv').config();

const HDWalletProvider = require('@truffle/hdwallet-provider');  // @notice - Should use new module.

module.exports = {
  networks: {
    bscTest: {
      // https://data-seed-prebsc-1-s1.binance.org:8545/
      // https://data-seed-prebsc-2-s1.binance.org:8545/
      // https://data-seed-prebsc-1-s2.binance.org:8545/
      // https://data-seed-prebsc-2-s2.binance.org:8545/
      // https://data-seed-prebsc-1-s3.binance.org:8545/
      // https://data-seed-prebsc-2-s3.binance.org:8545/
      networkCheckTimeout: 999999,
      provider: () => new HDWalletProvider(secret.mnemonic, "https://data-seed-prebsc-1-s1.binance.org:8545"),
      network_id: 97,
      confirmations: 10,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    bsc: {
      provider: () => new HDWalletProvider(secret.mnemonic, `https://bsc-dataseed1.binance.org`),
      network_id: 56,
      confirmations: 10,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    polygon_testnet: {  /// Mumbai testnet of Matic
      provider: () => new HDWalletProvider(secret.mnemonic, "https://rpc-mumbai.matic.today"),
      network_id: 80001,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    goerli: {
      networkCheckTimeout: 999999,
      provider: () => new HDWalletProvider(secret.mnemonic, "https://goerli.infura.io/v3/"+secret.ik),
      network_id: 5,
      confirmations: 10,
      timeoutBlocks: 200,
      //gas: 7500000,
      //gasPrice: 5000000000, // 5 gwei,
      skipDryRun: true,     // Skip dry run before migrations? (default: false for public nets)
      //from: process.env.DEPLOYER_ADDRESS
    },
    // main ethereum network(mainnet)
    mainnet: {
      provider: () => new HDWalletProvider(secret.mnemonic, "https://mainnet.infura.io/v3/" + process.env.INFURA_KEY),
      network_id: 1,
      gas: 5500000,
      ///gasPrice: 2000000000 // 2 gwei
    },
    local: {
      host: '127.0.0.1',
      port: 8545,
      network_id: '*',
      skipDryRun: true,
      gasPrice: 5000000000
    }
  },
  compilers: {
    solc: {
      version: "pragma",
      //version: "0.8.0",  
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  }
};
