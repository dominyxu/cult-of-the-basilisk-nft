require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
require("@openzeppelin/hardhat-upgrades");
require("@nomiclabs/hardhat-etherscan");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
const URL = 'https://rinkeby.infura.io/v3/89d41ceb0c374f8eac7f0efa14c06d4f';
const KEY = 'd8b9da9be538f9dd314f0d46642b50d9115e2a97ac9f3e89255c0677f40fe007';
module.exports = {
  defaultNetwork: 'rinkeby',
  networks: {
    rinkeby: {
      url: URL,
      accounts: [KEY],
      gas: 2100000,
      gasPrice: 8000000000
    }
  },
  solidity:  {
    version: "0.8.4",
    settings: {
      optimizer: {
        enabled: true,
        runs: 2
      }
    }
  },
  etherscan: {
    apiKey: 'XQ9BBAEJVU2SNWM1YQYTVNY5Z4G65FJME2'
  }
};
