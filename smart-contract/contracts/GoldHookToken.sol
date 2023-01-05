// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Ownable } from "./Utils/Ownable.sol";
import { ERC20 } from "./Utils/ERC20.sol";

contract GoldHookToken is ERC20, Ownable {

    uint private supplyTime = 1;

    constructor() ERC20("Golden Hood Token", "GHT") {
        uint initialSupply = 1e8 * 1e18;
        address initialReceiver = msg.sender;
        require(supplyTime == 1,"can not supply anymore!");
        _mint(initialReceiver, initialSupply);
        supplyTime -= 1;
    }    

    function mint(address to, uint mintAmount) public onlyOwner{
        require(supplyTime == 1,"can not supply anymore!");
        uint256 supply = mintAmount * 1e18;
        _mint(to, supply); 
        supplyTime -= 1;
    }

}
