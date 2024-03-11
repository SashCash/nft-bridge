/** @format */

import { HardhatRuntimeEnvironment } from "hardhat/types";
import { BridgeableArbitrumNFT__factory } from "../../generated/types";
import { task } from "hardhat/config";

/**
 * Deploy upgradeable contract
 */

const deployArbNft = async (hre: HardhatRuntimeEnvironment) => {
  const [deployer] = await hre.ethers.getSigners();
  const initialOwner = deployer.address;
  console.log("initialOwner : ", initialOwner);

  // Deploy BridgeableArbitrumNFT
  const upgradeableNftFactory = new BridgeableArbitrumNFT__factory(deployer);

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
    "BridgeableArbitrumNFT deployed to transparent proxy: ",
    await deployProxyTx.getAddress()
  );
};

task("deploy-arb", "Deploy ArbitrumNFT upgradeable contracts").setAction(
  async (args, hre) => {
    console.log("Running HH task");
    await deployArbNft(hre);
    console.log("Successfully ran HH task");
  }
);
