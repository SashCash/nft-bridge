/** @format */

import { ethers } from "ethers";

export const addresses = {
  arbSepolia: {
    nft: "0xC743E924F7330b6B9f2E2198EA3c6dc8780527d9",
  },
  opSepolia: {
    nft: "0x8100e69Ae3b94370ee16C1D167b793446B608499",
  },
};

export const roles = {
  OWNER_ROLE: "OWNER_ROLE",
  PAUSER_ROLE: "PAUSER_ROLE",
  MINTER_ROLE: "MINTER_ROLE",
  ADMIN_ROLE: "ADMIN_ROLE",
  UTILITY_ROLE: "UTILITY_ROLE",
};

export const keccak256 = (value: string): string => {
  return ethers.keccak256(ethers.toUtf8Bytes(value));
};

export const hexRoles = {
  OWNER_ROLE: keccak256("OWNER_ROLE"),
  PAUSER_ROLE: keccak256("PAUSER_ROLE"),
  MINTER_ROLE: keccak256("MINTER_ROLE"),
  ADMIN_ROLE: keccak256("ADMIN_ROLE"),
  UTILITY_ROLE: keccak256("UTILITY_ROLE"),
  WITHDRAWER_ROLE: keccak256("WITHDRAWER_ROLE"),
};
