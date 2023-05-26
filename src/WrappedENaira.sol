// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {ERC20Upgradeable} from "openzeppelin-contracts-upgradeable/contracts/token/ERC20/ERC20Upgradeable.sol";
import {ERC20BurnableUpgradeable} from
    "openzeppelin-contracts-upgradeable/contracts/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import {OwnableUpgradeable} from "openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol";
import {Initializable} from "openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol";
import {UUPSUpgradeable} from "openzeppelin-contracts-upgradeable/contracts/proxy/utils/UUPSUpgradeable.sol";

/// @title Wrapped ENaira
/// @author Mohamed Amine LEGHERABA for boom.market
/// @notice the wrapped enaira is implemented using OpenZepplin contracts as an ERC20 upgradable token
/// @dev Inspired by the code generated on OpenZeppelin Wizard: https://wizard.openzeppelin.com/
/// @custom:security-contact bsirt@boom.market
contract WrappedENaira is
    Initializable,
    ERC20Upgradeable,
    ERC20BurnableUpgradeable,
    OwnableUpgradeable,
    UUPSUpgradeable
{
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {
        __ERC20_init("Wrapped eNaira", "WeNGN");
        __ERC20Burnable_init();
        __Ownable_init();
        __UUPSUpgradeable_init();

        _mint(msg.sender, 1300000000000 * 10 ** decimals());
    }

    /// @notice Minting function to allow the owner to create any amount of tokens
    /// @dev Mohamed Amine LEGHERABA
    /// @param to the address that will receive the tokens
    /// @param amount the amount of tokens to create
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}
