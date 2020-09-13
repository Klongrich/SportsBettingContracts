// migrations/2_deploy.js
// SPDX-License-Identifier: MIT

//Names of the contract / contracts
const Box = artifacts.require("Box");
const HelloWorld = artifacts.require("HelloWorld");

module.exports = function(deployer) {
  deployer.deploy(Box);
  deployer.deploy(HelloWorld);
};