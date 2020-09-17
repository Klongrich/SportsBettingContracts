const Betting = artifacts.require("./Betting.sol")

require('chai')
    .use(require('chai-as-promised'))
    .should()

contract('Betting' , () => {
    let betting

    before(async () => {
        betting = await Betting.deployed()
    })

    describe('deployment', async() => {
        it('deploys successfully', async () => {
            const address = await betting.address
            assert.notEqual(address, 0x0)
            assert.notEqual(address, '')
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)

        })

        it('has a name', async () => {
            const name = await marketplace.name()
            assert.equal(name, 'silk road')
        })
    })
});