<!-- @format -->

# Arbitrum to Optimism NFT Bridge

This is a test project that allows for an NFT collection to be minted on one chain (Arbitrum Sepolia) and then bridged over to another chain (Optimism Sepolia).

Feel free to try it out yourself:

1.  Head to https://sepolia.arbiscan.io/address/0xc743e924f7330b6b9f2e2198ea3c6dc8780527d9#writeProxyContract and use the `openMint()` function to mint yourself an NFT on **Arbitrum Sepolia**.
2.  Call the `deposit()` function to deposit your NFT. This will burn it from your wallet.
3.  A bridging process I set up using **Openzeppelin Defender Monitor + Actions** will pick up the `Deposit` event and mint the same NFT for you on the **Optimism Sepolia** NFT contract at https://sepolia-optimism.etherscan.io/address/0x8100e69ae3b94370ee16c1d167b793446b608499
4.  The NFT will now be in your same wallet but on the **Optimism Sepolia** chain.
5.  Feel free to bridge your NFT back to Arbitrum Sepolia by calling the `deposit()` function at https://sepolia-optimism.etherscan.io/address/0x8100e69ae3b94370ee16c1d167b793446b608499#writeProxyContract
6.  A bridging process I set up using **Openzeppelin Defender Monitor + Actions** will pick up the `Deposit` event and mint the same NFT back to you on **Arbitrum Sepolia**.

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
