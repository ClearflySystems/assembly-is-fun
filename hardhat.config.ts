import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  paths: {tests: "tests"},
  solidity: "0.8.21",
};

export default config;