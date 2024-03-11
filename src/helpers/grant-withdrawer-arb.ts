/** @format */

import { HardhatRuntimeEnvironment } from "hardhat/types";
import { BridgeableArbitrumNFT__factory } from "../../generated/types";
import { task } from "hardhat/config";
import { addresses, hexRoles } from "./helpers";

/**
 * Grant withdrawer role on Arbitrum
 */

const grantWithdrawerArb = async (
  hre: HardhatRuntimeEnvironment,
  address: string
) => {
  const [deployer] = await hre.ethers.getSigners();

  // Connect to the deployed contracts
  const arbitrumNft = BridgeableArbitrumNFT__factory.connect(
    addresses.arbSepolia.nft,
    deployer
  );

  // Grant withdrawer role
  console.log("Granting withdrawer role...");
  let tx = await arbitrumNft.grantRole(hexRoles.WITHDRAWER_ROLE, address);
  await tx.wait();
  console.log("Successfully granted withdrawer role");
};

task("grant-withdrawer-arb", "Grant withdrawer role on arbitrum")
  .addParam("address", "Address to grant withdrawer role")
  .setAction(async (args, hre) => {
    console.log("Running HH task");
    await grantWithdrawerArb(hre, args.address);
    console.log("Successfully ran HH task");
  });
