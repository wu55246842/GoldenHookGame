
import {pk,ik} from  "./conf/pk"
require('dotenv').config();

const HDWalletProvider = require('@truffle/hdwallet-provider');  // @notice - Should use new module.
const mnemonic = process.env.MNEMONIC;

module.exports = {
  networks: {
    bsc_testnet: {
      provider: () => new HDWalletProvider(pk, "https://data-seed-prebsc-1-s1.binance.org:8545"),
      network_id: 97,
      confirmations: 10,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    bsc: {
      provider: () => new HDWalletProvider(mnemonic, `https://bsc-dataseed1.binance.org`),
      network_id: 56,
      confirmations: 10,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    polygon_testnet: {  /// Mumbai testnet of Matic
      provider: () => new HDWalletProvider(mnemonic, "https://rpc-mumbai.matic.today"),
      network_id: 80001,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true
    },
    goerli: {
      provider: () => new HDWalletProvider(pk, "https://goerli.infura.io/v3/"+ik),
      network_id: 5,
      gas: 7500000,
      gasPrice: 5000000000, // 5 gwei,
      skipDryRun: true,     // Skip dry run before migrations? (default: false for public nets)
      //from: process.env.DEPLOYER_ADDRESS
    },
    // main ethereum network(mainnet)
    live: {
      provider: () => new HDWalletProvider(mnemonic, "https://mainnet.infura.io/v3/" + process.env.INFURA_KEY),
      network_id: 1,
      gas: 5500000,
      gasPrice: 2000000000 // 2 gwei
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
      //version: "0.5.16",  /// Final version of solidity-v0.5.x
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  }
};
