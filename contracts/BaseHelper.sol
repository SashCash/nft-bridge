// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

abstract contract BaseHelper is
    Initializable,
    AccessControlUpgradeable,
    PausableUpgradeable,
    ReentrancyGuardUpgradeable
{
    /** ROLES **/
    bytes32 public constant OWNER_ROLE = keccak256("OWNER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant UTILITY_ROLE = keccak256("UTILITY_ROLE");
    bytes32 public constant WITHDRAWER_ROLE = keccak256("WITHDRAWER_ROLE");

    /** ERRORS **/

    error InvalidValues();

    /** MODIFIERS **/

    /** FUNCTIONS **/

    function _baseInitialize(address initialOwner) internal onlyInitializing {
        __Pausable_init();
        __AccessControl_init();
        __ReentrancyGuard_init();

        // Grant default admin role to initialOwner
        _grantRole(DEFAULT_ADMIN_ROLE, initialOwner);
        // Grant pauser role to initialOwner
        _grantRole(PAUSER_ROLE, initialOwner);
        _grantRole(OWNER_ROLE, initialOwner);
        _grantRole(MINTER_ROLE, initialOwner);
        _grantRole(ADMIN_ROLE, initialOwner);
        _grantRole(UTILITY_ROLE, initialOwner);
        _grantRole(WITHDRAWER_ROLE, initialOwner);
    }

    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    // The gap is needed to avoid overwriting storage variables in future upgrades
    uint256[50] private __gap;
}
