const Staking = artifacts.require("./Staking.sol")
const { expectRevert, time, BN, ether, balance } = require("@openzeppelin/test-helpers")

contract('Staking' , ([deployer, staker]) => {
    let staking;

    before(async () => {
        staking = await Staking.deployed()
    })

    describe('deployment', async() => {
        it('deploys successfully', async () => {
            const address = await staking.address
            assert.notEqual(address, 0x0)
            assert.notEqual(address, '')
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
        })
    })

    describe('Staking', async() => {
        let amount = web3.utils.toWei('1' , 'Ether');
        let results;

        it('Deposit', async () => {
            results = await staking.deposit({from: staker, value: amount});
            total_stake = await staking.getLiquidity.call().then(function (res) {
                console.log("Fucking A: " + res)
            })
            
        })

    })
})