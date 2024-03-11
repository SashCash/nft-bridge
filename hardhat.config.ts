/** @format */

import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-ethers";
import "@openzeppelin/hardhat-upgrades";
import "hardhat-deploy";

import "./src/deploy/deploy-arb";
import "./src/deploy/deploy-op";
import "./src/upgrade/upgrade-arb";
import "./src/upgrade/upgrade-op";
import "./src/helpers/grant-withdrawer-op";
import "./src/helpers/grant-withdrawer-arb";

const config: HardhatUserConfig = {
  solidity: {
    compilers: [
      {
        version: "0.8.20",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
    ],
  },
  paths: {
    cache: "./generated/cache",
    artifacts: "./generated/artifacts",
  },
  typechain: {
    outDir: "./generated/types",
    target: "ethers-v6",
  },
  networks: {
    sepolia: {
      url: String(process.env.INFURA_RPC_URL),
      accounts: [String(process.env.PRIVATE_KEY)],
    },
    arbSepolia: {
      url: String(process.env.INFURA_ARB_SEP_RPC_URL),
      accounts: [String(process.env.PRIVATE_KEY)],
    },
    opSepolia: {
      url: String(process.env.INFURA_OP_SEP_RPC_URL),
      accounts: [String(process.env.PRIVATE_KEY)],
    },
  },
  etherscan: {
    apiKey: {
      sepolia: String(process.env.ETHERSCAN_SEP_API_KEY),
      arbSepolia: String(process.env.ETHERSCAN_ARB_SEP_API_KEY),
      opSepolia: String(process.env.ETHERSCAN_OP_SEP_API_KEY),
    },
    customChains: [
      {
        network: "arbSepolia",
        chainId: 421614,
        urls: {
          apiURL: "https://api-sepolia.arbiscan.io/api",
          browserURL: "https://sepolia.arbiscan.io/",
        },
      },
      {
        network: "opSepolia",
        chainId: 11155420,
        urls: {
          apiURL: "https://api-sepolia-optimistic.etherscan.io/api",
          browserURL: "https://sepolia-optimism.etherscan.io/",
        },
      },
    ],
  },
};

export default config;
