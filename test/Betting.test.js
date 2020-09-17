const Betting = artifacts.require("./Betting.sol")

require('chai')
    .use(require('chai-as-promised'))
    .should()

contract('Betting' , ([deployer, betterOne, betterTwo]) => {
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
        let balancePlayerOne;
        let payOutGas;
        let placingBetGas;
        let gasPrice;

        web3.eth.getGasPrice()
        .then(function (price) {
            gasPrice = price; 
        }).catch(function (e) {
            console.log(e);
        })
        
        web3.eth.getBalance(betterOne)
        .then(function (balance) {
            balancePlayerOne = balance;
        }).catch(function(e) {
            console.log(e);
        });

        let newBlanacePlayerOner;

        let betAmount = web3.utils.toWei('0.1' , 'Ether');

        //This is where you input paramters into the function / functions you want t otest.
        before(async () => {

            betPlaced = await betting.bet(1 , {from: betterOne, value: betAmount});
            await betting.bet(2, {from: betterTwo, value: betAmount});

            pay_out = await betting.distributePrizes(1);

            payOutGas = pay_out.receipt.gasUsed;
            placingBetGas = betPlaced.receipt.gasUsed;

            web3.eth.getBalance(betterOne)
            .then(function (balance) {
                newBlanacePlayerOner = balance;
            }).catch(function(e) {
                console.log(e);
            });

        })

        //web3.eth.getAccounts(console.log);
        //This is what the test will come up as in the terminal in the case it is "places bet"
        it('places bet', async () => {   
            let new_result;
            new_result = parseInt(balancePlayerOne) + parseInt(betAmount) - (placingBetGas * gasPrice);
    
            assert.equal(parseInt(newBlanacePlayerOner), new_result , 'Amount Paid Out Correct');

        })

    })

})