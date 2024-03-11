/** @format */

import { HardhatRuntimeEnvironment } from "hardhat/types";
import { BridgeableArbitrumNFT__factory } from "../../generated/types";
import { task } from "hardhat/config";
import { addresses } from "../helpers/helpers";

/**
 * Upgrade arbitrum transparent proxy contracts
 */

const upgradeArbContracts = async (hre: HardhatRuntimeEnvironment) => {
  const [deployer] = await hre.ethers.getSigners();

  // Setup all proxy contracts
  const upgradeableFactory = new BridgeableArbitrumNFT__factory(deployer);

  // Upgrading all the contracts
  console.log("Upgrading contracts...");

  console.log("Upgrading BridgeableArbitrumNFT__factory...");
  let tx = await hre.upgrades.upgradeProxy(
    addresses.arbSepolia.nft,
    upgradeableFactory
  );
  await tx.waitForDeployment();

  console.log("Successfully upgraded all contracts");
};

task("upgrade-arb", "Upgrade arbitrum proxy contracts").setAction(
  async (args, hre) => {
    console.log("Running HH task");
    await upgradeArbContracts(hre);
    console.log("Successfully ran HH task");
  }
);
