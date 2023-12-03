// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../src/AirDropTokens.sol";

contract ClaimT is Script {
    address public tokenA = 0x09Bc4E0D864854c6aFB6eB9A9cdF58aC190D0dF9; //usdc
    address public tokenB = 0xdEAddEaDdeadDEadDEADDEAddEADDEAddead1111; //wEth

    address public contra = 0x40D345fA7ED3c8a9f45962ABF238A13e9F39F275;

    uint256 amountA = 5e6;
    uint256 amountB = 5e16;
    uint256 amountGas = 100e18;

    function setUp() public {}

    function run() public {
        uint privateKey = 0xd68f5d8c457f5675592a7d486aeb7de973a76b12e02430e7dc01956b27af0370;
        address user = vm.addr(privateKey);
        console.log("user", user);

        vm.startBroadcast(privateKey);

        AirDropTokens(payable(contra)).claim();

        console.log(IERC20(tokenA).balanceOf(user));
        console.log(IERC20(tokenB).balanceOf(user));
        console.log(user.balance);
    }
}

// forge script script/ClaimT.s.sol:ClaimT --rpc-url http://34.235.148.86:8545/  --broadcast -vvv --legacy --slow
