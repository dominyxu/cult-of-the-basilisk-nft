// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const BigNumber = require("bignumber.js");
const {ethers, upgrades} = require("hardhat");

const gen = BigNumber('8888');
const sup = BigNumber('22222');

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const CTB = await ethers.getContractFactory("CTB");
  console.log('deploying...');

  const ctbProxy = await upgrades.deployProxy(CTB, [gen.toFixed(), sup.toFixed(), 'x']);
  await ctbProxy.deployed();
  console.log("Contract deployed to:", ctbProxy.address);

  console.log("Owner:    ", ctbProxy.owner());
  console.log("Price:    ", ctbProxy.price());
  console.log("GenCount: ", ctbProxy.maxGen());
  console.log("MaxCount: ", ctbProxy.maxCTB());
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
