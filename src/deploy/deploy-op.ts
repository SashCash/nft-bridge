/** @format */

import { HardhatRuntimeEnvironment } from "hardhat/types";
import { BridgeableOptimismNFT__factory } from "../../generated/types";
import { task } from "hardhat/config";

/**
 * Deploy upgradeable contract
 */

const deployOptimismNft = async (hre: HardhatRuntimeEnvironment) => {
  const [deployer] = await hre.ethers.getSigners();
  const initialOwner = deployer.address;
  console.log("initialOwner : ", initialOwner);

  // Deploy BridgeableOptimismNFT
  const upgradeableNftFactory = new BridgeableOptimismNFT__factory(deployer);

  // Deploy tx and print address
  let deployProxyTx = await hre.upgrades.deployProxy(
    upgradeableNftFactory,
    [initialOwner],
    {
      initializer: "initialize",
    }
  );
  await deployProxyTx.waitForDeployment();
  console.log(
    "BridgeableOptimismNFT deployed to transparent proxy: ",
    await deployProxyTx.getAddress()
  );
};

task("deploy-op", "Deploy OptimismNFT upgradeable contracts").setAction(
  async (args, hre) => {
    console.log("Running HH task");
    await deployOptimismNft(hre);
    console.log("Successfully ran HH task");
  }
);
