// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

/// @custom:security-contact bsirt@boom.market
contract WrappedENaira is ERC20, ERC20Burnable, Ownable {
    uint256 initial_amount = 1000;
    string token_name = "WrappedENaira";
    string token_symbol = "WENGN";
    constructor() ERC20(token_name, token_symbol) {
        _mint(msg.sender, initial_amount * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
