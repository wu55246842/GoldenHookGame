// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
// import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
// import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";
// import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "./Utils/Interfaces/VRFCoordinatorV2Interface.sol";
import "./Utils/VRFConsumerBaseV2.sol";
import "./Utils/ConfirmedOwner.sol";
import "./Utils/ConfirmedOwner.sol";

import "./Utils/Interfaces/IERC20.sol";
import "./Utils/SafeMath.sol";
import "./Utils/Math.sol";


contract Playground is VRFConsumerBaseV2, ConfirmedOwner{

    using SafeMath for uint256;

    modifier notAddress(address _useAdd){
        require(_useAdd != address(0), "address is error");
        _;
    }


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
    uint256[] private requestIds;

    // The gas lane to use, which specifies the maximum gas price to bump to.
    // For a list of available gas lanes on each network,
    // see https://docs.chain.link/docs/vrf/v2/subscription/supported-networks/#configurations
    bytes32 keyHash = 0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15;

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
     * COORDINATOR: 0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D
     */


    //*---     预言机 END   ---*/

    
    event E_RequestSent(uint256 requestId, bool b);
    event E_RequestFulfilled(uint256 requestId, bool b);
    event E_Buycard(address buyer,uint32 cardNumber,uint256 amount);

    struct GameInfo {
        uint256 startAt;
        address creator; 
        bool isExist; 
    }


    IERC20 public immutable token;
    uint public tableId; // 游戏数量计数器

    mapping(address => uint256) private playerOwnCards; //所有的玩家和手上的牌，必须是有牌的玩家
    mapping(address => uint256) public playerReward;

    mapping(uint => GameInfo) public allGames;  //游戏数量计数器为ID ，记录每个ID的游戏信息

    // mapping(uint => address[]) public playerSequences;  //游戏数量计数器为ID ，记录每个游戏的出牌逻辑
    // mapping(uint => uint[]) public cardSequences;  //游戏数量计数器为ID ，记录每个游戏的出牌逻辑


    mapping (uint => uint) public cardCount; //游戏数量计数器为ID  卡牌数量计数器
    // mapping(uint => mapping(uint=> uint)) public cardSequences; //游戏数量计数器为ID  卡牌数量为ID 卡牌值
    mapping(uint => uint256) public cardSequences; //游戏数量计数器为ID  卡牌数量为ID 卡牌值
    mapping(uint => mapping(uint=> address)) public playerSequences; //游戏数量计数器为ID  卡牌数量为ID 卡牌值

    uint256 public unitValue = 100000000000000; //0.001
    uint256 public minValue = 100000000000000000; //0.1

    //0x2B8fF854c5e16cF35B9A792390Cc3a2a60Ec9ba2 bnb test
    //0x7af963cF6D228E564e2A0aA0DdBF06210B38615D goerli ethereum

    // constructor(address _token,address vrfCoordinator) VRFConsumerBaseV2(vrfCoordinator){
    //     token = IERC20(_token);
    //     _launch(msg.sender); //发布合约的时候，发布合约的地址（owner）创建第一个游戏
    // }


    function deposit() payable public {
    }

    function withdraw() payable public onlyOwner notAddress(msg.sender)  {
         payable(msg.sender).transfer(address(this).balance);
    }

    function setUnitValue(uint256 _amount) public onlyOwner{
        unitValue = _amount;
    }

    function setMinValue(uint256 _amount) public onlyOwner{
        minValue = _amount;
    }

    function playerWithdraw() payable public notAddress(msg.sender){
        require(playerReward[msg.sender]>0,"The address do not have rewards");
        require(SafeMath.mul(100000000000000, playerReward[msg.sender]) >minValue,"Not enough money to withdraw");
        payable(msg.sender).transfer(SafeMath.mul(100000000000000, playerReward[msg.sender]));
    }



    /**
     * HARDCODED FOR GOERLI
     * COORDINATOR: 0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D
     */
    
    constructor(uint64 subscriptionId) VRFConsumerBaseV2(0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D) ConfirmedOwner(msg.sender){
        //owner = msg.sender;
        token = IERC20(0x7af963cF6D228E564e2A0aA0DdBF06210B38615D);

        COORDINATOR = VRFCoordinatorV2Interface(0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D);
        s_subscriptionId = subscriptionId;

        for(uint i=0;i<10;i++){
            _launch(msg.sender,i.add(1)); //发布合约的时候，发布合约的地址（owner）创建第一个游戏
        }
        
    }


    function _launch(address _creator,uint _seed) internal notAddress(_creator){
        tableId += 1; //count 作为每个游戏的ID
        //游戏信息
        allGames[tableId] = GameInfo({
            startAt:block.timestamp,
            isExist:true,
            creator:_creator
        });
        //出牌序列，出第一张牌
        cardCount[tableId] =1;
        playerSequences[tableId][cardCount[tableId]] = _creator;
        cardSequences[tableId] = _random(100,_seed);
    }

    // function _cancel(uint _tableId) internal notAddress(msg.sender){
    //     require(allGames[_tableId].creator == msg.sender,"only creator can cancel the game");
    //     require(playerSequences[_tableId][1] != address(0),"the game stll have other players");
    //     require(cardSequences[_tableId] > 0,"the game stll have other players");
    //     delete allGames[_tableId];
    //     for(uint i=1 ;i<=cardCount[_tableId];i++){
    //         delete playerSequences[_tableId][i];
    //         delete cardSequences[_tableId];
    //     }
    //     delete cardCount[_tableId];
        
    // }

    function lanuchTable() public onlyOwner notAddress(msg.sender){
        _launch(msg.sender,1);
    }

    function buyCards(uint32 _num) external payable notAddress(msg.sender){
        require(_num<=30,"Limit exceeded");
        require(msg.value >= SafeMath.mul(_num,1000000000000000),"coin is not enough");
        requestRandomWords(_num);
        //uint amount = _num * 1000000000000000; //0.001eth
        //token.transferFrom(msg.sender, address(this),amount);
        emit E_Buycard(msg.sender,_num,msg.value);
    }

    function buyCards2(uint _num) external notAddress(msg.sender){
        playerOwnCards[msg.sender] = playerOwnCards[msg.sender]*(10**(2*_num)) + _random(10**(2*_num),1);
    }

    function playingCard(uint _tableId) external notAddress(msg.sender){
        require(cardSequences[_tableId] > 0, "Game not exist");
        require(playerSequences[_tableId][1] != address(0), "Game not exist");
        require(SafeMath.mod(uintLenth(playerOwnCards[msg.sender]),2)==0,"Length must be even");
        uint out = _outCard();
        _checkWin(_tableId, out);
       
    }

    function _outCard() private notAddress(msg.sender) returns(uint){
        uint len = uintLenth(playerOwnCards[msg.sender]);
        require(len>0 && SafeMath.mod(len,2) == 0,"No card exist");

        uint outCard = lastNDigital(playerOwnCards[msg.sender],2);
        playerOwnCards[msg.sender] /= 100;
        return outCard;
    }

    function _checkWin(uint _tableId,uint _out) public{
        require(cardCount[_tableId]>0,"No card exist");
        require(cardSequences[_tableId]>0 && SafeMath.mod(uintLenth(cardSequences[tableId]),2)==0,"No card exist");
        require(SafeMath.mod(uintLenth(playerOwnCards[msg.sender]),2)==0,"Length must be even");

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


    

    function _win(uint _tableId,uint _out) public view returns(bool,uint){
        require(cardCount[_tableId]>0,"No card exist");
        require(cardSequences[_tableId]>0 && SafeMath.mod(uintLenth(cardSequences[tableId]),2)==0,"No card exist");
        require(SafeMath.mod(uintLenth(playerOwnCards[msg.sender]),2)==0,"Length must be even");

        bool isWin ;
        uint matchSeq;
        uint len = uintLenth(cardSequences[_tableId]);
        for (uint i=1; i<=cardCount[_tableId]; i++) {
            uint divisor = 10**(len-(i*2));
            uint mach = SafeMath.div(cardSequences[_tableId],divisor);
            mach = lastNDigital(mach,2);
            if(mach == _out){
                isWin = true;
                matchSeq  = i;
                break;
            }

        }

        
        return (isWin,matchSeq);
    }

    function _reward(uint _tableId, uint _matchSeq) internal notAddress(msg.sender){
        require(cardCount[_tableId] > 0,"No card exist");
        require(cardSequences[_tableId] > 0,"No card exist");
        require(playerSequences[_tableId][1] != address(0),"No players involved");
        require(cardCount[_tableId]>=_matchSeq,"");

        uint remainCount =  SafeMath.sub(_matchSeq, 1) ;
        uint rewardCount =  SafeMath.sub(cardCount[_tableId], _matchSeq).add(1); //没有算出的那张牌，留给合约作为付费
        uint divisor = 10**(SafeMath.mul(rewardCount, 2));

        
        for(uint i=_matchSeq;i<=cardCount[_tableId];i++){
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
        
    }



    //预言机
    // Assumes the subscription is funded sufficiently.
    function requestRandomWords(uint _num) private notAddress(msg.sender) returns(uint256 requestId){
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
        uint lastNumDigital = lastNDigital(_randomWords[0], SafeMath.mul(num,2));
        playerOwnCards[buyer] =SafeMath.add(SafeMath.mul(playerOwnCards[buyer],10** SafeMath.mul(num,2)) , lastNumDigital) ;

        s_requests[_requestId].fulfilled = true;
        emit E_RequestFulfilled(_requestId, true);
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

    function playerOwnCardsCounts() external view returns(uint){
        if(playerOwnCards[msg.sender] == 0){
            return 0;
        }
        uint len = uintLenth(playerOwnCards[msg.sender]);
        require(SafeMath.mod(len,2) == 0 ,"Length must be even");
        return SafeMath.div(len,2);
    }

    function lastNDigital(uint256 _value,uint n) private pure returns(uint){
        require(uintLenth(_value)>=n ,"require number is too long");
        return SafeMath.mod(_value, 10**n);
    } 

    function uintLenth(uint256 _value) private pure returns(uint){
        require(_value > 0,"no value");
        return Math.log10(_value) + 1;
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


}