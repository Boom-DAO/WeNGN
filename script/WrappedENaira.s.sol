// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {WrappedENaira} from "../src/WrappedENaira.sol";

contract WrappedENairaScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        WrappedENaira wrapped = new WrappedENaira();
        vm.stopBroadcast();
    }
}
