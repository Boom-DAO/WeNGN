// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {WrappedENaira} from "../src/WrappedENaira.sol";
import {UUPSProxy} from "../src/UUPSProxy.sol";

contract WrappedENairaScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY_METAMASK");
        vm.startBroadcast(deployerPrivateKey);
        WrappedENaira wrapped = new WrappedENaira();
        UUPSProxy proxy = new UUPSProxy(address(wrapped), "");
        address(proxy).call(abi.encodeWithSignature("initialize()"));        
        vm.stopBroadcast();
    }
}
