const Betting = artifacts.require("./Betting.sol")

require('chai')
    .use(require('chai-as-promised'))
    .should()

contract('Betting' , ([deployer, better]) => {
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
    })

    //Describe is where you chose the function you would like to test
    describe('bet', async() => {
        let result
        
        //This is where you input paramters into the function / functions you want t otest.
        before(async () => {
            result = await betting.bet(1 , {from: better , value: 100000000000 })
        })

        //This is what the test will come up as in the terminal in the case it is "places bet"
        it('places bet', async () => {        
            const event = result.logs[0].args;
        })


    })
})