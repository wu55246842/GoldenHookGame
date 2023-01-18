// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../Utils/SafeMath.sol";
import "../Utils/Math.sol";

library GameLibrary {

     function lastNDigital(uint256 _value,uint n) internal pure returns(uint){
        require(uintLenth(_value)>=n ,"require number is too long");
        return SafeMath.mod(_value, 10**n);
    } 

    function uintLenth(uint256 _value) internal pure returns(uint){
        require(_value > 0,"no value");
        return Math.log10(_value) + 1;
    }

}