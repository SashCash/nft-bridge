// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./BaseHelper.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";

contract BridgeableOptimismNFT is BaseHelper, ERC721Upgradeable {
    /** ERRORS **/

    error NFTAlreadyDeposited(uint256 tokenId);

    error NFTNotDeposited(uint256 tokenId);

    /** EVENTS **/

    event Deposit(address indexed from, uint256 indexed tokenId);

    event Withdraw(address indexed to, uint256 indexed tokenId);

    /** FUNCTIONS **/
    function initialize(address initialOwner) public initializer {
        // We keep the same Token symbol to avoid confusion
        __ERC721_init("BridgeableOptimismNFT", "NFTB");
        _baseInitialize(initialOwner);
    }

    function supportsInterface(
        bytes4 interfaceId
    )
        public
        view
        override(ERC721Upgradeable, AccessControlUpgradeable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
    // The NFT will originate from Arbitrum and therefore cannot be manually minted on Optimism
    // function mint(address to, uint256 tokenId) public onlyRole(MINTER_ROLE) {
    //     _mint(to, tokenId);
    // }

    // The NFT will originate from Arbitrum and therefore cannot be manually burned on Optimism
    // function burn(uint256 tokenId) public onlyRole(MINTER_ROLE) {
    //     _burn(tokenId);
    // }

    /**
     * @dev Deposit NFT to the contract, burning it and emitting a Deposit event
     * Only the owner of the NFT can call this function
     */
    function deposit(uint256 tokenId) public nonReentrant whenNotPaused {
        require(ownerOf(tokenId) == msg.sender, "Only owner");
        // Burn the NFT
        _burn(tokenId);
        emit Deposit(msg.sender, tokenId);
    }

    /**
     * @dev Withdraw NFT from the contract, minting it and emitting a Withdraw event
     * Only the withdrawer oracle can call this function
     */
    function withdraw(
        address to,
        uint256 tokenId
    ) public nonReentrant whenNotPaused onlyRole(WITHDRAWER_ROLE) {
        // Mint the NFT
        _mint(to, tokenId);
        emit Withdraw(to, tokenId);
    }
}
