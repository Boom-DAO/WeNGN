// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/WrappedENaira.sol";

// todo:
// check why msg.sender amount is 0
// msg.sender amount should equals initial amount
// check only owner should be able to mint

contract WrappedTest is Test {
    WrappedENaira public wrapped;

    function setUp() public {
        wrapped = new WrappedENaira();
    }

    function testName() public {
        assertEq(wrapped.name(), "WrappedENaira");
    }

    function testSymbol() public {
        assertEq(wrapped.symbol(), "WENGN");
    }

    function testInitialSupply() public {
        assertEq(wrapped.totalSupply(), 1000 * 10 ** wrapped.decimals());
    }

    function testBalanceMinter() public {
        console2.log("amount is: ");
        console2.log(wrapped.balanceOf(msg.sender));
        assertEq(wrapped.totalSupply(), wrapped.balanceOf(msg.sender));
    }

    function testMint() public {
        uint256 value = 100 * 10 ** wrapped.decimals();
        wrapped.mint(msg.sender, value);
        assertEq(wrapped.totalSupply(), 1100 * 10 ** wrapped.decimals());
    }

    function testBurn() public {
        uint256 value = 100 * 10 ** wrapped.decimals();
        wrapped.burn(value);
        assertEq(wrapped.totalSupply(), 900 * 10 ** wrapped.decimals());
    }
}
