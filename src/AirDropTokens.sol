// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract AirDropTokens {
    address public tokenA;
    address public tokenB;
    address public owner;

    uint256 amountA;
    uint256 amountB;
    uint256 amountGas;

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the Owner");
        _;
    }

    constructor(
        address _tokenA,
        address _tokenB,
        uint256 _amountA,
        uint256 _amountB,
        uint256 _amountG
    ) {
        tokenA = _tokenA;
        tokenB = _tokenB;
        owner = msg.sender;

        amountA = _amountA;
        amountB = _amountB;
        amountGas = _amountG;
    }

    receive() external payable {}

    function claim() public {
        (bool success, ) = payable(msg.sender).call{value: amountGas}("");
        require(success);

        IERC20(tokenA).transfer(msg.sender, amountA);
        IERC20(tokenB).transfer(msg.sender, amountB);
    }

    function emptyAll() public onlyOwner {
        (bool success, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(success);
        uint256 balA = IERC20(tokenA).balanceOf(address(this));
        uint256 balB = IERC20(tokenB).balanceOf(address(this));
        IERC20(tokenA).transfer(msg.sender, balA);
        IERC20(tokenB).transfer(msg.sender, balB);
    }
}
