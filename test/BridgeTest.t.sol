// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

import {BridgeableOptimismNFT} from "../contracts/BridgeableOptimismNFT.sol";
import {BridgeableArbitrumNFT} from "../contracts/BridgeableArbitrumNFT.sol";

contract BridgeTest is Test {
    // Contracts
    BridgeableOptimismNFT public optimismNft;
    BridgeableArbitrumNFT public arbitrumNft;

    // Accounts
    address public owner;

    address public optimismOracle;
    address public arbitrumOracle;

    address public playerOne;

    // Roles
    bytes32 public constant OWNER_ROLE = keccak256("OWNER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant UTILITY_ROLE = keccak256("UTILITY_ROLE");
    bytes32 public constant WITHDRAWER_ROLE = keccak256("WITHDRAWER_ROLE");

    function setUp() public {
        owner = msg.sender;
        optimismOracle = address(0x888);
        arbitrumOracle = address(0x999);
        playerOne = address(0x444);
        vm.startPrank(owner);

        // Initialize upgradeables
        optimismNft = new BridgeableOptimismNFT();
        arbitrumNft = new BridgeableArbitrumNFT();
        optimismNft.initialize(owner);
        arbitrumNft.initialize(owner);

        // Contract setup and connections

        // Set up roles
        optimismNft.grantRole(WITHDRAWER_ROLE, address(arbitrumOracle));
        arbitrumNft.grantRole(WITHDRAWER_ROLE, address(optimismOracle));

        arbitrumNft.setAllowOpenMint(true);
    }

    /**
     * @dev Test Addresses are not address(0)
     */
    function testFailContractAddress() public {
        assertEq(address(optimismNft), address(0));
        assertEq(address(arbitrumNft), address(0));
    }

    /**
     * @dev Test simple mint on Arbitrum, Arbitrum is the parent chain where the NFTs will originate from
     */
    function testSimpleMintArbitrum() public {
        arbitrumNft.mint(playerOne);
        assertEq(arbitrumNft.ownerOf(1), playerOne);
        assertEq(arbitrumNft.balanceOf(playerOne), 1);
    }

    /**
     * @dev Test depositing on Arbitrum
     */
    function testDepositOnArbitrum() public {
        arbitrumNft.mint(playerOne);
        assertEq(arbitrumNft.ownerOf(1), playerOne);
        vm.stopPrank();
        vm.prank(playerOne);
        arbitrumNft.deposit(1);
        assertEq(arbitrumNft.balanceOf(playerOne), 0);
    }

    /**
     * @dev Test depositing on Arbitrum and withdrawing on Optimism
     */
    function testDepositAndBridge() public {
        arbitrumNft.mint(playerOne);
        assertEq(arbitrumNft.ownerOf(1), playerOne);
        vm.stopPrank();
        vm.prank(playerOne);
        arbitrumNft.deposit(1);
        assertEq(arbitrumNft.balanceOf(playerOne), 0);
        vm.prank(arbitrumOracle);
        optimismNft.withdraw(playerOne, 1);
        assertEq(optimismNft.ownerOf(1), playerOne);
    }

    /**
     * @dev Test depositing on Arbitrum and withdrawing on Optimism and then depositing on Optimism and withdrawing on Arbitrum
     */
    function testDepositAndBridgeAndBridgeBack() public {
        arbitrumNft.mint(playerOne);
        assertEq(arbitrumNft.ownerOf(1), playerOne);
        vm.stopPrank();
        vm.prank(playerOne);
        arbitrumNft.deposit(1);
        assertEq(arbitrumNft.balanceOf(playerOne), 0);
        vm.prank(arbitrumOracle);
        optimismNft.withdraw(playerOne, 1);
        assertEq(optimismNft.ownerOf(1), playerOne);
        vm.prank(playerOne);
        optimismNft.deposit(1);
        assertEq(optimismNft.balanceOf(playerOne), 0);
        vm.prank(optimismOracle);
        arbitrumNft.withdraw(playerOne, 1);
        assertEq(arbitrumNft.ownerOf(1), playerOne);
    }
}
