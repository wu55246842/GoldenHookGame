// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
// import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
// import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";
// import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "./Interfaces/IGame.sol";
import "./Utils/Interfaces/VRFCoordinatorV2Interface.sol";
import "./Utils/VRFConsumerBaseV2.sol";
import "./Utils/ConfirmedOwner.sol";
import "./Utils/ConfirmedOwner.sol";

import "./Utils/Interfaces/IERC20.sol";
import "./Utils/SafeMath.sol";
import "./Utils/Math.sol";
import "./library/GameLibrary.sol";


contract Playground is IGame, VRFConsumerBaseV2, ConfirmedOwner{

    using SafeMath for uint256;
    using GameLibrary for uint256;

    //*---     预言机     ---*/
    struct RequestStatus {
        bool fulfilled; // whether the request has been successfully fulfilled
        bool exists; // whether a requestId exists
        uint requestNum;
        address buyer;
    }
    mapping(uint256 => RequestStatus) public s_requests; /* requestId --> requestStatus */

    VRFCoordinatorV2Interface COORDINATOR;
    // Your subscription ID.
    uint64 s_subscriptionId;
    // past requests Id.
    uint256[] internal requestIds;

    // The gas lane to use, which specifies the maximum gas price to bump to.
    // For a list of available gas lanes on each network,
    // see https://docs.chain.link/docs/vrf/v2/subscription/supported-networks/#configurations
    //bytes32 keyHash = 0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15; //goerli
    //bytes32 keyHash = 0xd4bb89654db74673a187bd804519e65e3f71a52bc55f11da7601a13dcf505314;  //bnbtest

    bytes32 keyHash;

    // Depends on the number of requested values that you want sent to the
    // fulfillRandomWords() function. Storing each word costs about 20,000 gas,
    // so 100,000 is a safe default for this example contract. Test and adjust
    // this limit based on the network that you select, the size of the request,
    // and the processing of the callback request in the fulfillRandomWords()
    // function.
    uint32 callbackGasLimit = 100000;

    // The default is 3, but you can set this higher.
    uint16 requestConfirmations = 3;

    // For this example, retrieve 2 random values in one request.
    // Cannot exceed VRFCoordinatorV2.MAX_NUM_WORDS.
    //uint32 numWords = 10;

    /**
     * HARDCODED FOR GOERLI
     * COORDINATOR: 0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D  //goerli
     * COORDINATOR: 0x6A2AAd07396B36Fe02a22b33cf443582f682c82f //bnbtest
     */


    //*---     预言机 END   ---*/

    
    

    struct GameInfo {
        uint256 startAt;
        address creator; 
        bool isExist; 
    }


    IERC20 public immutable token;
    uint256 public userId;
    mapping(address=>uint256) public users;
    uint public tableId; // 游戏数量计数器

    mapping(address => uint256) private playerOwnCards; //所有的玩家和手上的牌，必须是有牌的玩家
    mapping(address => uint256) public playerReward;
    mapping(uint => GameInfo) public allGames;  //游戏数量计数器为ID ，记录每个ID的游戏信息
    mapping (uint => uint) public cardCount; //游戏数量计数器为ID  卡牌数量计数器
    mapping(uint => uint256) public cardSequences; //游戏数量计数器为ID  卡牌数量为ID 卡牌值
    mapping(uint => mapping(uint=> address)) public playerSequences; //游戏数量计数器为ID  卡牌数量为ID 卡牌值

    uint256 public unitValue = 10000000000000000; //0.01
    uint256 public minWithdrawValue  = 300000000000000000; //0.3

    string public constant AUTHORS = "@wu55246842::Laowudi";

    //0x2B8fF854c5e16cF35B9A792390Cc3a2a60Ec9ba2 bnb test
    //0x7af963cF6D228E564e2A0aA0DdBF06210B38615D goerli ethereum


    function deposit() payable public {
    }

    function withdraw() payable public onlyOwner{
        require(msg.sender != address(0), "address is error");
        payable(msg.sender).transfer(address(this).balance);
    }

    function setUnitValue(uint256 _amount) public onlyOwner{
        unitValue = _amount;
    }

    function setMinWithdrawValue(uint256 _amount) public onlyOwner{
        minWithdrawValue = _amount;
    }

    function playerWithdraw() payable external virtual override{
        require(msg.sender != address(0), "address is error");
        require(playerReward[msg.sender]>0,"The address do not have rewards");
        require(SafeMath.mul(unitValue, playerReward[msg.sender]) >minWithdrawValue,"Not enough money to withdraw");
        payable(msg.sender).transfer(SafeMath.mul(unitValue, playerReward[msg.sender]));
    }


    constructor(address _token,
                address _vrfCoordinator,
                bytes32 _keyHash,
                uint64 _subscriptionId) VRFConsumerBaseV2(_vrfCoordinator) ConfirmedOwner(msg.sender){

        token = IERC20(_token);
        keyHash = _keyHash;
        COORDINATOR = VRFCoordinatorV2Interface(_vrfCoordinator);
        s_subscriptionId = _subscriptionId;

        //first user is owner
        userId +=1;
        users[msg.sender] = userId;

        for(uint i=0;i<10;i++){
            _launch(i.add(1)); //发布合约的时候，发布合约的地址（owner）创建第一个游戏
        }
        
    }


    function launch(uint _seed) external virtual override{
        _launch(_seed);
    }

    function _launch(uint _seed) onlyOwner private{
        require(msg.sender != address(0), "address is error");
        tableId += 1; //count 作为每个游戏的ID
        //游戏信息
        allGames[tableId] = GameInfo({
            startAt:block.timestamp,
            isExist:true,
            creator:msg.sender
        });
        //出牌序列，出第一张牌
        cardCount[tableId] =1;
        playerSequences[tableId][cardCount[tableId]] = msg.sender;
        cardSequences[tableId] = _random(100,_seed);
    }


    function buyCards(uint _num) external payable{
        require(msg.sender != address(0), "address is error");
        require(_num>=10 &&_num<=30,"Limit >=10 and <=30");
        require(msg.value >= SafeMath.mul(_num,unitValue),"coin is not enough");
        requestRandomWords(_num);
    }

    function buyCards2(uint _num) external{
        require(msg.sender != address(0), "address is error");
        require(_num>=10 &&_num<=30,"Limit >=10 and <=30");
        playerOwnCards[msg.sender] = playerOwnCards[msg.sender]*(10**(2*_num)) + _random(10**(2*_num),1);
        if(users[msg.sender]!=0){
            userId +=1;
            users[msg.sender] = userId;
        }
    }

    function playingCard(uint _tableId) external virtual override{
        require(msg.sender != address(0), "address is error");
        require(cardSequences[_tableId] > 0, "Game not exist");
        require(SafeMath.mod(GameLibrary.uintLenth(playerOwnCards[msg.sender]),2)==0,"Length must be even");
        uint out = _outCard(_tableId);
        _checkWin(_tableId, out);
       
    }

    function _outCard(uint _tableId) internal returns(uint){
        require(msg.sender != address(0), "address is error");
        uint len = GameLibrary.uintLenth(playerOwnCards[msg.sender]);
        require(len>=2,"Must keep at list one card");
        require(SafeMath.mod(len,2) == 0,"No card exist");

        uint outCard = GameLibrary.lastNDigital(playerOwnCards[msg.sender],2);
        playerOwnCards[msg.sender] /= 100;
        emit E_Outcard(msg.sender,outCard, _tableId);
        return outCard;
    }

    function _checkWin(uint _tableId,uint _out) internal{
        require(cardCount[_tableId]>0,"No card exist");
        require(cardSequences[_tableId]>0 && SafeMath.mod(GameLibrary.uintLenth(cardSequences[tableId]),2)==0,"No card exist");
        require(SafeMath.mod(GameLibrary.uintLenth(playerOwnCards[msg.sender]),2)==0,"Length must be even");

        bool isWin;
        uint matchSeq;
        (isWin,matchSeq) = _win(_tableId,_out);
        if(isWin){
            _reward(_tableId,matchSeq); //获取收益
        }else{
            cardCount[_tableId] += 1;
            cardSequences[_tableId] = SafeMath.add(SafeMath.mul(cardSequences[_tableId], 100), _out); 
            playerSequences[_tableId][cardCount[_tableId]] = msg.sender;
        }
    }


    

    function _win(uint _tableId,uint _out) internal view returns(bool,uint){
        require(cardCount[_tableId]>0,"No card exist");
        require(cardSequences[_tableId]>0 && SafeMath.mod(GameLibrary.uintLenth(cardSequences[tableId]),2)==0,"No card exist");
        require(SafeMath.mod(GameLibrary.uintLenth(playerOwnCards[msg.sender]),2)==0,"Length must be even");

        bool isWin ;
        uint matchSeq;
        uint len = GameLibrary.uintLenth(cardSequences[_tableId]);
        for (uint i=1; i<=cardCount[_tableId]; i++) {
            uint divisor = 10**(len-(i*2));
            uint mach = SafeMath.div(cardSequences[_tableId],divisor);
            mach = GameLibrary.lastNDigital(mach,2);
            if(mach == _out){
                isWin = true;
                matchSeq  = i;
                break;
            }

        }

        
        return (isWin,matchSeq);
    }

    function _reward(uint _tableId, uint _matchSeq) internal{
        require(msg.sender != address(0), "address is error");
        uint cc = cardCount[_tableId];
        require(cc > 0,"No card exist");
        require(cardSequences[_tableId] > 0,"No card exist");
        require(cc>=_matchSeq,"");

        uint remainCount =  SafeMath.sub(_matchSeq, 1) ;
        uint rewardCount =  SafeMath.sub(cc, _matchSeq).add(1); //没有算出的那张牌，留给合约作为付费
        uint divisor = 10**(SafeMath.mul(rewardCount, 2));

        
        for(uint i=_matchSeq;i<=cc;i++){
           delete playerSequences[_tableId][i];
        }

        if(remainCount == 0){
            cardCount[_tableId] = 1;
            cardSequences[_tableId] = _random(100, 1);
        }else{
            cardCount[_tableId] = remainCount;
            cardSequences[_tableId] /= divisor;
        }
        playerReward[msg.sender] += rewardCount;

        emit E_PlayerReward(msg.sender,rewardCount,_tableId);
        
    }


    function requestRandomWords(uint _num) private returns(uint256 requestId){
        require(msg.sender != address(0), "address is error");
        // Will revert if subscription is not set and funded.
        requestId = COORDINATOR.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            1
        );

        s_requests[requestId] = RequestStatus({
            exists: true,
            fulfilled: false,
            requestNum:_num,
            buyer:msg.sender
        });

        requestIds.push(requestId);
        emit E_RequestSent(requestId, true);
        return requestId;
    }

    function fulfillRandomWords(
        uint256 _requestId,
        uint256[] memory _randomWords
    ) internal override {
        require(s_requests[_requestId].exists, "request not found");
        address buyer = s_requests[_requestId].buyer;
        require(buyer!=address(0),"address is error");
        uint num = s_requests[_requestId].requestNum;
        uint lastNumDigital = GameLibrary.lastNDigital(_randomWords[0], SafeMath.mul(num,2));
        playerOwnCards[buyer] =SafeMath.add(SafeMath.mul(playerOwnCards[buyer],10** SafeMath.mul(num,2)) , lastNumDigital) ;

        if(users[buyer]!=0){
            userId +=1;
            users[buyer] = userId;
        }

        s_requests[_requestId].fulfilled = true;
        emit E_RequestFulfilled(_requestId, true);
        emit E_Buycard(buyer,num);
        uint256 t_amount = SafeMath.mul(num,unitValue);
        if(token.totalSupply()>=t_amount){
            token.transfer(buyer, t_amount);
            emit E_ReceiveToken(buyer,t_amount);
        }else{
            emit E_ReceiveToken(buyer,0);
        }
        
    }


    // function getRandomCards(uint256 value,uint num,address buyer) private{
    //     while (value != 0){
    //         uint v = lastNDigital(value,2);
    //         playerOwnCards[buyer].push(v);
    //         value /= 100;
    //         num--;
    //         if(num==0) break;
    //     }
    // }

    function playerOwnCardsCounts() external view virtual override returns(uint){
        if(playerOwnCards[msg.sender] == 0){
            return 0;
        }
        uint len = GameLibrary.uintLenth(playerOwnCards[msg.sender]);
        require(SafeMath.mod(len,2) == 0 ,"Length must be even");
        return SafeMath.div(len,2);
    }

   

    uint256 public constant EAA_PM_START = 100;
    uint256 public constant EAA_PM_STEP = 1;
    uint256 public constant EAA_RANK_STEP = 100_000;

    function _calculateEAARate() internal view returns (uint256) {
        // EAA_PM_STEP = 1
        // EAA_RANK_STEP = 100000
        uint256 decrease = (EAA_PM_STEP * userId) / EAA_RANK_STEP;
        // EAA_PM_START = 100
        // 也就是说，如果参与人数大于 1000 万，返回 0
        if (decrease > EAA_PM_START) return 0;
        // 否则返回 100 - 人数 / 100000
        return EAA_PM_START - decrease;
    }

   


    //--------------------test function----------------------

    // function getRequestStatus(
    //     uint256 _requestId
    // ) public view onlyOwner returns (bool) {
    //     require(s_requests[_requestId].exists, "request not found");
    //     RequestStatus memory request = s_requests[_requestId];
    //     return request.fulfilled;
    // }

    function getPlayerOwnCards() external view returns(uint){
        return playerOwnCards[msg.sender];
    }

    function _random(uint _number,uint256 _seed) public view returns(uint256) {
        bytes32 randomBytes = keccak256(abi.encodePacked(block.number, msg.sender, blockhash(block.timestamp-1)));
        return  SafeMath.mod(SafeMath.div(uint256(randomBytes), _seed), _number);  
    }

    


    function testMsgSender() public view returns(address){
        return msg.sender;
    }

    function testTokenTransfer(uint _num) payable public{
        token.transfer(msg.sender, SafeMath.mul(_num,unitValue));
    }

}