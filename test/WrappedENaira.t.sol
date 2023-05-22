// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/WrappedENaira.sol";

contract WrappedTest is Test {
    WrappedENaira public wrapped;
    address public deployer;
    uint256 public initialAmount;

    function setUp() public {
        wrapped = new WrappedENaira();
        deployer = 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496;
        initialAmount = 1000 * 10 ** wrapped.decimals();
    }

    function testName() public {
        assertEq(wrapped.name(), "WrappedENaira");
    }

    function testSymbol() public {
        assertEq(wrapped.symbol(), "WENGN");
    }

    function testDecimals() public {
        assertEq(wrapped.decimals(), 18);
    }

    function testInitialSupply() public {
        assertEq(wrapped.totalSupply(), initialAmount);
    }

    function testBalanceMinter() public {
        assertEq(initialAmount, wrapped.balanceOf(deployer));
        assertEq(wrapped.totalSupply(), wrapped.balanceOf(deployer));
    }

    function testMint() public {
        uint256 value = 100 * 10 ** wrapped.decimals();
        uint256 newValue = initialAmount + value;
        wrapped.mint(deployer, value);
        assertEq(wrapped.totalSupply(), newValue);
        assertEq(wrapped.balanceOf(deployer), newValue);
    }
    
    function test_When_MinterIsNotOwner() public {
        uint256 value = 100 * 10 ** wrapped.decimals();
        vm.expectRevert("Ownable: caller is not the owner");
        vm.prank(address(0));
        wrapped.mint(deployer, value);
    }
    
    function testBurn() public {
        uint256 value = 100 * 10 ** wrapped.decimals();
        uint256 newValue = initialAmount - value;
        wrapped.burn(value);
        assertEq(wrapped.totalSupply(), newValue);
    }
}
