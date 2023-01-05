
export default {
    bsc: {
        default: false,
        network: "binance",
        networkId: 56,
        chainId: 56,
        chainName: 'BSC',
        chainSymbol: 'BNB',
        decimals: 18,
        logo: '',
        rpcUrl: 'https://bsc-dataseed1.binance.org',
        remark:'bsc'
    },
    bscTest: {
        default: true,
        network: "binance",
        networkId: 97,
        chainId: 97,
        chainName: 'BSC-Test',
        chainSymbol: 'BNB',
        decimals: 18,
        logo: '',
        rpcUrl: 'https://data-seed-prebsc-2-s3.binance.org:8545/',
        scanUrl: 'https://testnet.bscscan.com/',
        remark:'bscTest'
    },
    // 使用TRC网络时请在config/wallet.js配置中去除custom-tl配置项的注释
    trc: {
        default: false,
        network: "mainnet",
        chainName: 'TRC',
        chainSymbol: 'TRX',
        decimals: 6,
        logo: '',
        rpcUrl: '',
        remark:'trc'
    },
    trcTest: {
        default: false,
        network: "shasta",
        chainName: 'TRC',
        chainSymbol: 'TRX',
        decimals: 6,
        logo: '',
        rpcUrl: '',
        remark:'trcTest'
    },
    goerli: {
        default: false,
        network: "Goerli Test Network",
        networkId: 5,
        chainId: 5,
        chainName: 'Goerli Test Network',
        chainSymbol: 'GoerliETH',
        decimals: 18,
        logo: '',
        rpcUrl: 'https://goerli.infura.io/v3/1d98ddd3e0e841ecbd16f009ab6808e2',
        scanUrl: 'https://goerli.etherscan.io/',
        remark:'goerli'
    },
    mainnet: {
        default: false,
        network: "Ethereum Mainnet",
        networkId: 1,
        chainId: 1,
        chainName: 'Ethereum Mainnet',
        chainSymbol: 'ETH',
        decimals: 18,
        logo: '',
        rpcUrl: 'https://mainnet.infura.io/v3/1d98ddd3e0e841ecbd16f009ab6808e2',
        scanUrl: 'https://etherscan.io',
        remark:'mainnet'
    },

}
