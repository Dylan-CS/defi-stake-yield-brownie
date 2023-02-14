// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract TokenFarm is Ownable {
    // stakeTokens  done!
    // unStakeTokens
    // issueTokens  done!
    // addAllowedTokens done!
    // getEthValue  done!

    //mapping token address -> staker address -> amount
    mapping(address => mapping(address => uint256)) public stakingBalance;
    mapping(address => uint256) public uniqueTokensStaked;
    mapping(address => address) public tokenPriceFeedMapping ;
    address[] public stakers;
    //100 ETH 1:1 for every 1 ETH, we give 1 DappToken
    //50 ETH and 50 DAI staked, and we want to give a reward of 1 DAPP/ 1 DAI
    address[] public allowedTokens;
    IERC20 public dappToken;

    constructor(address _dappTokenAddress) public {
        dappToken = IERC20(_dappTokenAddress);
    }

    function stakeTokens(uint256 _amount, address _token) public {
        //what tokens can they stake?
        //how much cant they seake?
        require(_amount > 0, "Amount must be more than 0");
        require(tokenIsAllowed(_token), "Currently the token is not allowed");
        IERC20(_token).transferFrom(msg.sender, address(this), _amount);
        UpdateUniqueTokensStaked(msg.sender, _token);
        stakingBalance[_token][msg.sender] =
            stakingBalance[_token][msg.sender] +
            _amount;
        if (uniqueTokensStaked[msg.sender] == 1) {
            stakers.push(msg.sender);
        }
    }

    function unstakeTokens(address _token) public{
        uint256 balance = stakingBalance[_token][msg.sender];
        require(balance>0,"Staking balance can't be 0 ");
        IERC20(_token).transfer(msg.sender, balance);
        stakingBalance[_token][msg.sender]= 0;
        uniqueTokensStaked[msg.sender] = uniqueTokensStaked[msg.sender]-1;
    }

    function UpdateUniqueTokensStaked(address _user, address _token) internal {
        if (stakingBalance[_token][_user] <= 0) {
            uniqueTokensStaked[_user] = uniqueTokensStaked[_user] + 1;
        }
    }

    function addAllowedTokens(address _token) public onlyOwner {
        allowedTokens.push(_token);
    }

    function tokenIsAllowed(address _token) public view returns (bool) {
        for (
            uint256 allowedTokensIndex = 0;
            allowedTokensIndex < allowedTokens.length;
            allowedTokensIndex++
        ) {
            if (allowedTokens[allowedTokensIndex] == _token) return true;
        }
        return false;
    }

    function issueTokens() public onlyOwner {
        //issue tokens to all stakers
        for (
            uint256 stakersIndex = 0;
            stakersIndex < stakers.length;
            stakersIndex++
        ) {
            address recipient = stakers[stakersIndex];
            uint256 userTotalValue = getUserTotalValue(recipient);
            // send then  a token reward based on their alue locked
            // dappToken.transfer(recipient, ????);
            dappToken.transfer(recipient, userTotalValue);
        }
    }

    function getUserTotalValue(address _user) public view returns (uint256) {
        uint256 totalValue = 0;
        require(uniqueTokensStaked[_user]>0,"Bro, no token staked!");
        for (
            uint256 allowedTokensIndex = 0;
            allowedTokensIndex < allowedTokens.length;
            allowedTokensIndex++
        ) {
            totalValue =totalValue+ getUserSingleTokenValue(_user,allowedTokens[allowedTokensIndex]);
        }
        return totalValue;
    }

    function getUserSingleTokenValue(address _user,address _token) public view returns(uint256){
        //1  ETH   =   2000$
        //200 DAI  =  200$
        if(uniqueTokensStaked[_user]<=0){
            return 0;
        }
        // price of the token * stakingBalance [_token][user]
        (uint256 price,uint256 decimals) = getTokenValue(_token);
        return (stakingBalance[_token][_user]*price/10**decimals);
    }

    function getTokenValue(address _token)public view returns(uint256,uint256){
        //pricefeedaddress
        address priceFeedAddress = tokenPriceFeedMapping[_token];
        AggregatorV3Interface priceFeed = AggregatorV3Interface(priceFeedAddress);
         (
            /* uint80 roundID */,
            int256 price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) =priceFeed.latestRoundData();
        uint256 decimals = uint(priceFeed.decimals());
        return (uint256(price),decimals);
    }

    function setPriceFeedContract(address _token, address _priceFeed) public onlyOwner{
        tokenPriceFeedMapping [_token]= _priceFeed;
    } 

}
