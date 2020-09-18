// migrations/2_deploy.js
// SPDX-License-Identifier: MIT

//Names of the contract / contracts
const Betting = artifacts.require("Betting");
const Staking = artifacts.require("Staking");


module.exports = function(deployer) {
  deployer.deploy(Betting);
  deployer.deploy(Staking);
};