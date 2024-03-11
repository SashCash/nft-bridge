// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./BaseHelper.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";

contract BridgeableArbitrumNFT is BaseHelper, ERC721Upgradeable {
    /** Variables **/

    mapping(uint256 => bool) public tokenIdToDeposited;

    uint256 public tokenIdCounter;

    bool public allowOpenMint;

    /** ERRORS **/

    error NFTAlreadyDeposited(uint256 tokenId);

    error NFTNotDeposited(uint256 tokenId);

    /** EVENTS **/

    event Deposit(address indexed from, uint256 indexed tokenId);

    event Withdraw(address indexed to, uint256 indexed tokenId);

    /** FUNCTIONS **/
    function initialize(address initialOwner) public initializer {
        // We keep the same Token symbol to avoid confusion
        __ERC721_init("BridgeableArbitrumNFT", "NFTB");
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

    function setAllowOpenMint(bool _allowOpenMint) public onlyRole(OWNER_ROLE) {
        allowOpenMint = _allowOpenMint;
    }

    /**
     * @dev Allow open mint just for testing purposes
     */
    function openMint(address to) public {
        require(allowOpenMint, "Open mint not allowed");
        tokenIdCounter++;
        uint256 tokenId = tokenIdCounter;
        _mint(to, tokenId);
    }

    function mint(address to) public onlyRole(MINTER_ROLE) {
        tokenIdCounter++;
        uint256 tokenId = tokenIdCounter;
        _mint(to, tokenId);
    }

    function burn(uint256 tokenId) public onlyRole(MINTER_ROLE) {
        _burn(tokenId);
    }

    /**
     * @dev Deposit NFT to the contract, burning it and emitting a Deposit event
     * Only the owner of the NFT can call this function
     */
    function deposit(uint256 tokenId) public nonReentrant whenNotPaused {
        require(ownerOf(tokenId) == msg.sender, "Only owner");
        // Check if the NFT is already deposited
        if (tokenIdToDeposited[tokenId] == true) {
            revert NFTAlreadyDeposited(tokenId);
        }
        tokenIdToDeposited[tokenId] = true;
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
        // Check if the NFT is not deposited
        if (tokenIdToDeposited[tokenId] == false) {
            revert NFTNotDeposited(tokenId);
        }
        tokenIdToDeposited[tokenId] = false;
        // Mint the NFT
        _mint(to, tokenId);
        emit Withdraw(to, tokenId);
    }
}
