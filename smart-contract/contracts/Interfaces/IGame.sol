// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGame {

    event E_RequestSent(uint256 requestId, bool b);
    event E_RequestFulfilled(uint256 requestId, bool b);
    event E_Buycard(address player,uint numbers);
    event E_Outcard(address player,uint cardNumber,uint tableId);
    event E_PlayerReward(address player,uint rewardCount,uint tableId);
    event E_ReceiveToken(address player,uint256 amount);

    function launch(uint _seed) external;

    function playingCard(uint _tableId) external;

    function playerOwnCardsCounts() external view returns(uint);

    function playerWithdraw() payable external;

}