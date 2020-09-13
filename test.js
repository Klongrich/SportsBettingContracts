import Web3 from 'web3'
import box from './build/contracts/Box.json'

  //Connecting to metaMask wallet

window.web3 = new Web3(window.ethereum)
await window.ethereum.enable()

const boxData = box.networks[3]
    
const abi = box.abi;
const address = box.network[3].address;
const Box = web3.eth.Contract(abi, address);

console.log(Box.methods.store('42'));
