// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";

/// @custom:security-contact bsirt@boom.market
contract WrappedENaira is ERC20, ERC20Burnable, Ownable {
    uint256 public initialAmount = 1000;
    string public tokenName = "WrappedENaira";
    string public tokenSymbol = "WENGN";

    constructor() ERC20(tokenName, tokenSymbol) {
        _mint(msg.sender, initialAmount * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
