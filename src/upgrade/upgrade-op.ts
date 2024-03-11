/** @format */

import { HardhatRuntimeEnvironment } from "hardhat/types";
import { BridgeableOptimismNFT__factory } from "../../generated/types";
import { task } from "hardhat/config";
import { addresses } from "../helpers/helpers";

/**
 * Upgrade optimism transparent proxy contracts
 */

const upgradeOpContracts = async (hre: HardhatRuntimeEnvironment) => {
  const [deployer] = await hre.ethers.getSigners();

  // Setup all proxy contracts
  const upgradeableFactory = new BridgeableOptimismNFT__factory(deployer);

  // Upgrading all the contracts
  console.log("Upgrading contracts...");

  console.log("Upgrading BridgeableOptimismNFT__factory...");
  let tx = await hre.upgrades.upgradeProxy(
    addresses.opSepolia.nft,
    upgradeableFactory
  );
  await tx.waitForDeployment();

  console.log("Successfully upgraded all contracts");
};

task("upgrade-op", "Upgrade optimism proxy contracts").setAction(
  async (args, hre) => {
    console.log("Running HH task");
    await upgradeOpContracts(hre);
    console.log("Successfully ran HH task");
  }
);
