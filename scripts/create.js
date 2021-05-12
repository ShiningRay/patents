// We require the Hardhat Runtime Environment explicitly here. This is optional 
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `hardhat run <script>` you'll find the Hardhat
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
  const Greeter = await hre.ethers.getContractFactory("AchivementContract");
  console.log(`attach to contract ${process.env.CONTRACT}`);
  const greeter = await Greeter.attach(process.env.CONTRACT);
  const tx = await greeter.appendAchivement("测试", "测试用成果", 1000000, 0, Date.now(), Date.now(), "LILI", "lili@gmail.com", "13180009000", "东南大学", "软件学院");
  const res = await tx.wait();
  const topics = res.events[0].topics
  const id = topics[topics.length - 1];
  console.log(`created new Achivement ID: ${id}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
