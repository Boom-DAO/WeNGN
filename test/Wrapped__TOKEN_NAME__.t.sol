// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import {Wrapped__TOKEN_NAME__} from "../src/Wrapped__TOKEN_NAME__.sol";

contract WrappedTest is Test {
    Wrapped__TOKEN_NAME__ public wrapped;
    address public deployer;
    uint256 public initialAmount;

    function setUp() public {
        wrapped = new Wrapped__TOKEN_NAME__();
        deployer = 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496;
        initialAmount = __INITIAL_AMOUNT__ * 10 ** wrapped.decimals();
    }

    function testName() public {
        assertEq(wrapped.name(), __TOKEN_NAME__);
    }

    function testSymbol() public {
        assertEq(wrapped.symbol(), __TOKEN_SYMBOL__);
    }

    function testDecimals() public {
        assertEq(wrapped.decimals(), 18);
    }

    function testInitialSupply() public {
        assertEq(wrapped.totalSupply(), initialAmount);
        assertEq(wrapped.balanceOf(deployer), initialAmount);
    }

    function testMint() public {
        uint256 value = 100 * 10 ** wrapped.decimals();
        uint256 newValue = initialAmount + value;
        wrapped.mint(deployer, value);
        assertEq(wrapped.totalSupply(), newValue);
        assertEq(wrapped.balanceOf(deployer), newValue);
    }
    
    function testMintNotOwner() public {
        uint256 value = 100 * 10 ** wrapped.decimals();
        vm.expectRevert("Ownable: caller is not the owner");
        vm.prank(address(0));
        wrapped.mint(deployer, value);
        assertEq(wrapped.totalSupply(), initialAmount);
        assertEq(wrapped.balanceOf(deployer), initialAmount);
    }
    
    function testBurn() public {
        uint256 value = 100 * 10 ** wrapped.decimals();
        uint256 newValue = initialAmount - value;
        wrapped.burn(value);
        assertEq(wrapped.totalSupply(), newValue);
        assertEq(wrapped.balanceOf(deployer), newValue);
    }

    function testBurnMoreThanSupply() public {
        uint256 value = initialAmount + 1;
        vm.expectRevert("ERC20: burn amount exceeds balance");
        wrapped.burn(value);
    }
}
