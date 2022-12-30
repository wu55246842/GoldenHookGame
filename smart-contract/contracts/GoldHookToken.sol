// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Ownable } from "./Utils/Ownable.sol";
import { ERC20 } from "./Utils/ERC20.sol";

contract GoldHookToken is ERC20, Ownable {

    constructor() ERC20("Golden Hood Token", "GHT") {
        uint initialSupply = 1e11 * 1e18;  /// 1 billion   1e8 * 1e18 1 million
        address initialReceiver = msg.sender;
        _mint(initialReceiver, initialSupply);
    }    

    function mint(address to, uint mintAmount) public onlyOwner{
        _mint(to, mintAmount);    
    }

}
