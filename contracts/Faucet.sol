//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Faucet {
    //0.1 token
    uint256 public amountAllowed = 1000000000000000000000;
    address public tokenContract;
    mapping(address => bool) public requestedAddress;

    event SendToken(address indexed Receiver, uint256 indexed Amount);

    constructor(address _tokenContract) {
        tokenContract = _tokenContract; // set token contract
    }

    function requestTokens() external {
        require(!requestedAddress[msg.sender], "Can't Request Multiple Times!");
        IERC20 token = IERC20(tokenContract);
        require(
            token.balanceOf(address(this)) >= amountAllowed,
            "Faucet Empty!"
        );

        token.transfer(msg.sender, amountAllowed);
        requestedAddress[msg.sender] = true;

        emit SendToken(msg.sender, amountAllowed);
    }
}
