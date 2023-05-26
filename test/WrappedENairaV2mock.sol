// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {WrappedENaira} from "../src/WrappedENaira.sol";

contract WrappedENairaV2mock is WrappedENaira
{
    function mockfn() public pure returns(string memory) {
        return "mock";
    }
}
