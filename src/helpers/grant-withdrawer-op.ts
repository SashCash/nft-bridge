/** @format */

import { HardhatRuntimeEnvironment } from "hardhat/types";
import { BridgeableOptimismNFT__factory } from "../../generated/types";
import { task } from "hardhat/config";
import { addresses, hexRoles } from "./helpers";

/**
 * Grant withdrawer role on optimism
 */

const grantWithdrawerOp = async (
  hre: HardhatRuntimeEnvironment,
  address: string
) => {
  const [deployer] = await hre.ethers.getSigners();

  // Connect to the deployed contracts
  const optimismNft = BridgeableOptimismNFT__factory.connect(
    addresses.opSepolia.nft,
    deployer
  );

  // Grant withdrawer role
  console.log("Granting withdrawer role...");
  let tx = await optimismNft.grantRole(hexRoles.WITHDRAWER_ROLE, address);
  await tx.wait();
  console.log("Successfully granted withdrawer role");
};

task("grant-withdrawer-op", "Grant withdrawer role on optimism")
  .addParam("address", "Address to grant withdrawer role")
  .setAction(async (args, hre) => {
    console.log("Running HH task");
    await grantWithdrawerOp(hre, args.address);
    console.log("Successfully ran HH task");
  });
