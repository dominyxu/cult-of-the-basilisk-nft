# Rokos NFT Project
You will find the details of this assignement in the following sections. Please follow this short guide to complete the project.
For any inquiries, please message asura on discord at `asura | CTB#0419`.

## Installation

Please make sure you can [Node.js](https://nodejs.org/en/), [Visual Studio Code](https://code.visualstudio.com/Download) and [Github Desktop](https://desktop.github.com/) installed.

Use the following lines to install the required plugins:
1. `npm install @openzeppelin/contracts`
2. `npm install @openzeppelin/contracts-upgradeable`
3. `npm install --save-dev hardhat`
4. `npm install --save-dev @openzeppelin/hardhat-upgrades`
5. `npm install -g truffle`
6. `npm install --save-dev chai`
7. `npm install --save-dev @nomiclabs/hardhat-ethers ethers # peer dependencies`
8. `npm install @nomiclabs/hardhat-waffle`
9. `npm install --save-dev @nomiclabs/hardhat-etherscan`

Details for each installation:
1. OpenZeppelin is the most updated version of solidity smart contract assistance
2. This is the one you really need, as this is required for proxy creation
3. Hardhat is the system that is used to deploy proxies and implementations
4. Hardhat system used for proxies and upgrading smart contracts
5. Truffle is the testing system used to ensure the JS works
6. Chai is an assistance plugin for truffle
7. Ethers is used to calculate ethereum numbers
8. Used in deploying the proxy and implentation
9. Allows access to view contracts and verify them on [etherscan.io](https://etherscan.io/)

NOTE: Ensure that the console is in **cmd** and not **powershell**.

## Roadmap

1. Create the ERC721 smart contract and the ERC721 Interface for the original NFT.
2. Create the ERC20 smart contract and the ERC20 Interface for the token implentation
3. Using Tuffle, test the functions (both read and write) work properly
4. Deploy the contract onto a ethereum testnet (I suggest Rinkeby); [This is a written guide](https://docs.openzeppelin.com/upgrades-plugins/1.x/hardhat-upgrades)
5. Create Vault account for mainnet deployment
6. Consult asura before deploying the contract

## Validating contracts

Contract validation is required for decryption of smart contracts.
Using the following code, after deployment, allows the implementation to be read on etherscan:

`npx hardhat verify --network NETWORK ADDRESS`

1. NETWORK = the network used (mainnet, rinkeby, etc.)
2. ADDRESS = the address of the deployed implementation

## Resources

1. [Solidity Learning](https://cryptozombies.io/)
2. [ERC721 example 1](https://etherscan.io/address/0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d)
3. [ERC721 example 2](https://etherscan.io/address/0x0c2E57EFddbA8c768147D1fdF9176a0A6EBd5d83)
4. [ERC20 example](https://etherscan.io/address/0x5cd2fac9702d68dde5a94b1af95962bcfb80fc7d)
5. [Proxy guide (OpenZeppelin)](https://docs.openzeppelin.com/upgrades-plugins/1.x/hardhat-upgrades)
6. [Proxy initialization guide](https://www.youtube.com/watch?v=bdXJmWajZRY)
7. [Proxy writing guide](https://www.youtube.com/watch?v=kWUDTZhxKZI)
8. [Checking smart contracts](https://etherscan.io/)
