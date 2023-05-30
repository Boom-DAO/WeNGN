// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";

/// @title Wrapped __TOKEN_NAME__
/// @author Mohamed Amine LEGHERABA for BOOM DAO
/// @notice the wrapped __TOKEN_NAME__ is implemented using OpenZepplin contracts as an ERC20 token 
/// @dev Inspired by the code generated on OpenZeppelin Wizard: https://wizard.openzeppelin.com/
/// @custom:security-contact bsirt@boom.market
contract Wrapped__TOKEN_NAME__ is ERC20, ERC20Burnable, Ownable {
    uint256 public initialAmount = __INITIAL_AMOUNT__;
    string public tokenName = __TOKEN_NAME__;
    string public tokenSymbol = __TOKEN_SYMBOL__;

    constructor() ERC20(tokenName, tokenSymbol) {
        _mint(msg.sender, initialAmount * 10 ** decimals());
    }

    /// @notice Minting function to allow the owner to create any amount of tokens
    /// @dev Mohamed Amine LEGHERABA
    /// @param to the address that will receive the tokens
    /// @param amount the amount of tokens to create
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
