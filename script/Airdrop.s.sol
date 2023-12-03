// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console2.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "../src/AirDropTokens.sol";

contract DeployContract is Script {
    address public tokenA = 0x09Bc4E0D864854c6aFB6eB9A9cdF58aC190D0dF9; //usdc
    address public tokenB = 0xdEAddEaDdeadDEadDEADDEAddEADDEAddead1111; //wEth

    uint256 amountA = 5e6;
    uint256 amountB = 5e16;
    uint256 amountGas = 100e18;

    function setUp() public {}

    function run() public {
        uint privateKey = 0xfc2f8cc0abd2d9d05229c8942e8a529d1ba9265eb1b4c720c03f7d074615afbb;
        address owner = vm.addr(privateKey);
        console.log("Owner", owner);

        vm.startBroadcast(privateKey);

        AirDropTokens airC = new AirDropTokens(
            tokenA,
            tokenB,
            amountA,
            amountB,
            amountGas
        );

        console.log("contract ", address(airC));

        IERC20(tokenA).transfer(address(airC), 10e6);
        IERC20(tokenB).transfer(address(airC), 10e16);
        (bool sent, ) = payable(address(airC)).call{value: 1000e18}("");
    }
}

// forge script script/Airdrop.s.sol:DeployContract --rpc-url http://34.235.148.86:8545/  --broadcast -vvv --legacy --slow
