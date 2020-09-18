pragma solidity >=0.4.22 <0.8.0;


contract Staking {
    
    uint256 private transaction_fee;
    uint256 private total_amount_staked;

    address payable[] public stakers;

    struct Depositer {
        uint amount_deposited;   
        uint time;
    }

    mapping(address => Depositer) public DepositerInfo;

    function deposit() public payable {
        DepositerInfo[msg.sender].amount_deposited += msg.value;
        total_amount_staked += msg.value;

        stakers.push(msg.sender);
    }

    function getLiquidity() public view returns(uint256){
        return total_amount_staked;
    }
}