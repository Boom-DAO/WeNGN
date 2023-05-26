// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {WrappedENaira} from "../src/WrappedENaira.sol";
import {UUPSProxy} from "../src/UUPSProxy.sol";
import {WrappedENairaV2mock} from "./WrappedENairaV2mock.sol";

contract WrappedTest is Test {
    UUPSProxy proxy;
    address deployer;
    uint256 initialAmount;
    uint256 dec;
    uint256 val;

    function setUp() public {
        WrappedENaira wrapped = new WrappedENaira();
        // deploy proxy contract and point it to implementation
        proxy = new UUPSProxy(address(wrapped), "");
        // initialize implementation contract
        (bool b, ) = address(proxy).call(abi.encodeWithSignature("initialize()"));        
        assertTrue(b);
        deployer = 0x7FA9385bE102ac3EAc297483Dd6233D62b3e1496;
        (, bytes memory returnedData) = address(proxy).call(
            abi.encodeWithSignature("decimals()")
        );
        dec = abi.decode(returnedData, (uint256));
        initialAmount = 1300000000000 * 10 ** dec; // 1.3 trillion (1 300 000 000 000)
        val = 100 * 10 ** dec;
    }

    function testName() public {
        (, bytes memory returnedData) = address(proxy).call(
            abi.encodeWithSignature("name()")
        );
        string memory n = abi.decode(returnedData, (string));
        assertEq(n, "Wrapped eNaira");
    }

    function testSymbol() public {
        (, bytes memory returnedData) = address(proxy).call(
            abi.encodeWithSignature("symbol()")
        );
        string memory sy = abi.decode(returnedData, (string));
        assertEq(sy, "WeNGN");
    }

    function testDecimals() public {
        assertEq(dec, 18);
    }

    function testInitialSupply() public {
        (, bytes memory returnedData) = address(proxy).call(
            abi.encodeWithSignature("totalSupply()")
        );
        uint256 t = abi.decode(returnedData, (uint256));
        assertEq(t, initialAmount);
        (, bytes memory returnedData2) = address(proxy).call(
            abi.encodeWithSignature("balanceOf(address)", deployer)
        );
        uint256 b = abi.decode(returnedData2, (uint256));
        assertEq(b, initialAmount);
    }

    function testMint() public {
        uint256 newValue = initialAmount + 100 * 10 ** dec;
        (bool a, ) = address(proxy).call(abi.encodeWithSignature("mint(address,uint256)", deployer, val));
        assertTrue(a);
        (, bytes memory returnedData) = address(proxy).call(
            abi.encodeWithSignature("totalSupply()")
        );
        uint256 t = abi.decode(returnedData, (uint256));
        assertEq(t, newValue);
        (, bytes memory returnedData2) = address(proxy).call(
            abi.encodeWithSignature("balanceOf(address)", deployer)
        );
        uint256 b = abi.decode(returnedData2, (uint256));
        assertEq(b, newValue);
    }

    function testMint_NotOwner() public {
        vm.expectRevert("Ownable: caller is not the owner");
        vm.prank(address(0));
        (bool a,) = address(proxy).call(abi.encodeWithSignature("mint(address,uint256)", deployer, val));        
        assertTrue(a);
        (, bytes memory returnedData) = address(proxy).call(
            abi.encodeWithSignature("totalSupply()")
        );
        uint256 t = abi.decode(returnedData, (uint256));
        assertEq(t, initialAmount);
        (, bytes memory returnedData2) = address(proxy).call(
            abi.encodeWithSignature("balanceOf(address)", deployer)
        );
        uint256 b = abi.decode(returnedData2, (uint256));
        assertEq(b, initialAmount);
   }

    function testBurn() public {
        uint256 newValue = initialAmount - 100 * 10 ** dec;
        (bool a,) = address(proxy).call(abi.encodeWithSignature("burn(uint256)", val));        
        assertTrue(a);
        (, bytes memory returnedData) = address(proxy).call(
            abi.encodeWithSignature("totalSupply()")
        );
        uint256 t = abi.decode(returnedData, (uint256));
        assertEq(t, newValue);
        (, bytes memory returnedData2) = address(proxy).call(
            abi.encodeWithSignature("balanceOf(address)", deployer)
        );
        uint256 b = abi.decode(returnedData2, (uint256));
        assertEq(b, newValue);
    }

    function testBurn_MoreThanSupply() public {
        uint256 value = initialAmount + 1;
        vm.expectRevert("ERC20: burn amount exceeds balance");
        (bool a, ) = address(proxy).call(abi.encodeWithSignature("burn(uint256)", value));        
        assertTrue(a);
    }

    function testUpdate() public {
        WrappedENairaV2mock wrapped2 = new WrappedENairaV2mock();
        (bool a,) = address(proxy).call(
            abi.encodeWithSignature("upgradeTo(address)", address(wrapped2))
        );
        assertTrue(a);
        (, bytes memory returnedData) = address(proxy).call(abi.encodeWithSignature("symbol()"));        
        string memory m = abi.decode(returnedData, (string));
        assertEq(m, "WeNGN");
        (, bytes memory returnedData2) = address(proxy).call(abi.encodeWithSignature("mockfn()"));        
        string memory m2 = abi.decode(returnedData2, (string));
        assertEq(m2, "mock");
    }
}
