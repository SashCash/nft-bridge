<!-- @format -->

# Arbitrum to Optimism NFT Bridge

### To deploy Upgradeable ArbitrumNFT contract

`npx hardhat deploy-arb --network arbSepolia`

### To deploy Upgradeable OptimismNFT contract

`npx hardhat deploy-op --network opSepolia`

### To upgrade Upgradeable ArbitrumNFT contract

`npx hardhat upgrade-arb --network arbSepolia`

### To upgrade Upgradeable OptimismNFT contract

`npx hardhat upgrade-op --network opSepolia`

### Verified on Optimism Sepolia

`npx hardhat verify --network opSepolia 0x8100e69Ae3b94370ee16C1D167b793446B608499`

https://sepolia-optimism.etherscan.io/address/0x8100e69ae3b94370ee16c1d167b793446b608499#code

### Verified on Arbitrum Sepolia

`npx hardhat verify --network arbSepolia 0xC743E924F7330b6B9f2E2198EA3c6dc8780527d9`

https://sepolia.arbiscan.io/address/0xc743e924f7330b6b9f2e2198ea3c6dc8780527d9#code

### Run foundry tests

`forge test -vv`
