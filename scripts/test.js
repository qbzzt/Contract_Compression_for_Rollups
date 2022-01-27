// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const Deployer = await hre.ethers.getContractFactory("DecompressingDeployer");
  const deployer = await Deployer.deploy()

  await deployer.deployed()
  const tx1 = await deployer.deployCompressed([0xC5, 0x62, 0xFD, 0xC0])
//  const tx1 = await deployer.test([0xC5, 0x62, 0xFD, 0xC0])
  const receipt1 = await tx1.wait()

  console.log("Deployer deployed to:", deployer.address)
  console.log(`Results: ${receipt1.events[0].args}`)
  console.log(tx1)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
