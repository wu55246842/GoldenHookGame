import ContractConfig from '../config/contract'
import store from '../store'
import UI from '@/utils/ui'
import eventBus from '@/utils/eventBus'
import CommonFunction from "@/utils/commonFunction";
import Task from "@/utils/task";



function loadContract(contractName, contractAddress, networkRemark){
    if(!window.connectedAddress){
        console.log('Error 1004: Wallet not connected')
        return
    }
    const web3 = window.web3
    if(!web3){
        console.log('Error 1002: Web3 is not initialized')
        return
    }
    
    const abiJson = require("@/assets/build/"+networkRemark+"/contracts/" + contractName + ".json")
    if(!contractAddress){
        console.log('Error 1003: The ' + contractName + ' contract address is not configured')
        return
    }
    

    const returnData = {}
    let web3Contract
    if(window.web3.trx){
        web3Contract = window.web3.contract(abiJson.abi, contractAddress)
        returnData.events = {}
    } else if(window.web3.eth) {
        web3Contract = new web3.eth.Contract(abiJson.abi, contractAddress)
        returnData.events = web3Contract.events
    }
    returnData.methods = web3Contract ? web3Contract.methods : null

    return returnData
}

async function getAddress(name){
    const web3 = window.web3
    if(!web3){
        console.log('Error 1002: Web3 is not initialized')
        return
    }
    const networkConfig = await CommonFunction.getCurrentNetwork()
    const abiJson = require("@/assets/build/"+networkConfig.remark+"/contracts/" + name + '.json')
    //const abiJson = require("../assets/build/"+"bscTest"+"/contracts/" + name + ".json")
    const networkId = await web3.eth.net.getId()
    const deployedNetwork = abiJson.networks[networkId.toString()]
    return deployedNetwork && deployedNetwork.address
}

async function init(){
    const _Contract = {}
    const networkConfig = await CommonFunction.getCurrentNetwork()
    for(let k in ContractConfig){
        const contractAddress = await getAddress(k)
        const contractObject = loadContract(k, contractAddress,networkConfig.remark)
        _Contract[k] = {
            address: contractAddress,
            contractName: k,
            methods: contractObject.methods,
            _isReset: false,
            sendValue: 0
        }
        _Contract[k].atAddress = function(_address) {
            this.methods = loadContract(k, _address,networkConfig.remark).methods
            this._isReset = true
            return this
        }
        _Contract[k].send = function(_value) {
            this.sendValue = _value
            return this
        }
        _Contract[k] = _initMethods(contractObject, _Contract, k,networkConfig)
        _Contract[k] = _initEvents(contractObject, _Contract, k,networkConfig)
    }
    Contract = _Contract
    
    // after init
    eventBus.$emit('afterInit')
}

async function _initMethods(contractObject, _Contract, k ,networkConfig){
    for(let funcName in contractObject.methods){
        if(funcName.indexOf('0x') == 0){
            continue
        }
        if(funcName.indexOf(')') == -1 && funcName.indexOf('(') == -1){
            continue
        }
        funcName = funcName.split('(')[0]
        _Contract[k][funcName] = async function(){
            const _func = this.methods[funcName]
            const _params = arguments
            const method = eval(_getMethod(_params))
            let stateMutability = method._method ? method._method.stateMutability : _getStateMutability(k, funcName,networkConfig.remark)
            stateMutability = stateMutability.toLocaleLowerCase()
            const contractAddress = await getAddress(k)
            if(this._isReset && !CommonFunction.isZeroAddress(contractAddress)){
                this.methods = loadContract(k, contractAddress).methods
                this._isReset = false
            }
            if(stateMutability == 'view' || stateMutability == 'pure'){
                return await method.call({ _isConstant: true ,from: store.state.currentAccount})
            } else {
                const _sendValue = this.sendValue
                this.sendValue = 0
                let handle = null
                if(window.web3.trx){
                    handle = new Promise(async (resolve, reject) => {
                        method.send(await _getSend(_sendValue)).then(hash => {
                            Task.add(funcName, hash, k + '.' + funcName, {txId: hash})
                            resolve(hash);
                        }).catch(e => {
                            reject(e)
                        })
                    })
                } else if(window.web3.eth) {
                    handle = method.send(await _getSend(_sendValue)).on('transactionHash', function(hash){
                        Task.add(funcName, hash, k + '.' + funcName, {txId: hash})
                    }).on('receipt', function(receipt){
                        const hash = receipt.transactionHash
                        const status = receipt.status
                        Task.updateStatus(hash, status, 'receipt')
                    }).on('confirmation', function(confirmationNumber, receipt){
                        const hash = receipt.transactionHash
                        const status = receipt.status
                        Task.updateStatus(hash, status, 'confirmation-' + confirmationNumber)
                    })
                }
                return handle
            }
        }
        // other function
        if(funcName == 'approve'){
            _Contract[k].approveTo = async function(address, amount) {
                UI.loading('Approve...')
                const approveValue = await _getApproveValue(this, address, amount)
                if(typeof(approveValue) == 'boolean' && approveValue){
                    return true
                }
                let isApprove = false
                await this.approve(address, approveValue).then(()=>{
                    isApprove = true
                }).catch(async err => {
                    const _approveValue = await _getApproveValue(this, address, amount)
                    if(typeof(_approveValue) == 'boolean' && _approveValue){
                        isApprove = true
                    } else {
                        console.log(err)
                        UI.toast('Approve failed', false)
                        isApprove = false
                    }
                });
                UI.closeLoading()
                isApprove && UI.toast('Approve success')

                return isApprove
            }
        }
    }
    return _Contract[k]
}

async function _getApproveValue(_this, address, amount){
    let approveValue
    if(typeof(_this.getApproved) == 'function'){
        const allowance = await _this.getApproved(amount)
        if(!CommonFunction.isZeroAddress(allowance)){
            UI.closeLoading()
            return true
        }
        approveValue = amount
    } else {
        const allowance = await _this.allowance(window.connectedAddress, address)
        const check = window.web3.trx ? allowance - CommonFunction.toBigNumber(amount) > 0 : allowance - amount > 0
        if(check){
            UI.closeLoading()
            return true
        }
        approveValue = await _this.totalSupply()
    }

    return approveValue
}

function _initEvents(contractObject, _Contract, k){
    return _Contract[k]
}

function _getStateMutability(contractName, funcName,networkRemark){
    // const abiJson = require("@/assets/build/"+networkRemark+"/contracts/" + contractName + ".json")
    const abiJson = require("../assets/build/"+"bscTest"+"/contracts/" + contractName + ".json")
    let item = null
    for(let i in abiJson){
        if(abiJson[i].name == funcName){
            item = abiJson[i]
            break
        }
    }
    return item ? item.stateMutability : null
}

function _getMethod(params){
    let _method = '_func('
    for(let a = 0; a < params.length; a++){
        _method += '_params[' + a + ']' + (a == params.length - 1 ? '' : ',')
    }
    _method += ')'

    return _method
}

async function _getSend(callValue){
    const web3 = window.web3
    let sendData
    if(web3.eth){
        const gasPrice = await window.web3.eth.getGasPrice()
        sendData = {
            from: store.state.currentAccount,
            gasPrice: gasPrice ? gasPrice : window.web3.utils.toWei((15) + '', 'gwei')
        }
    } else if(web3.trx){
        sendData = {
            from: store.state.currentAccount,
            feeLimit: 200000000,
            callValue: callValue ? callValue : 0,
            shouldPollResponse: false
        }
    }

    return sendData
}

export default {
    init
}
