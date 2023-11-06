// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {WrappedENaira} from "../src/WrappedENaira.sol";

contract WrappedENairaScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        new WrappedENaira();
        vm.stopBroadcast();
    }
}
