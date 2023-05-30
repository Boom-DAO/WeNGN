// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import {Wrapped__TOKEN_NAME__} from "../src/Wrapped__TOKEN_NAME__.sol";

contract Wrapped__TOKEN_NAME__Script is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        Wrapped__TOKEN_NAME__ wrapped = new Wrapped__TOKEN_NAME__();
        vm.stopBroadcast();
    }
}
