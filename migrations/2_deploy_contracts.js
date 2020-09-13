// migrations/2_deploy.js
// SPDX-License-Identifier: MIT

//Names of the contract / contracts
const Betting = artifacts.require("Betting");

module.exports = function(deployer) {
  deployer.deploy(Betting)
};