// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {WrappedENaira} from "../src/WrappedENaira.sol";

contract WrappedTest is Test {
    WrappedENaira public wrapped;
    address public deployer;
    uint256 public initialAmount;

    function setUp() public {
        wrapped = new WrappedENaira();
        deployer = 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496;
        initialAmount = 1300000000000 * 10 ** wrapped.decimals(); // 1.3 trillion (1 300 000 000 000)
    }

    function testName() public {
        assertEq(wrapped.name(), "Wrapped eNaira");
    }

    function testSymbol() public {
        assertEq(wrapped.symbol(), "WeNGN");
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
