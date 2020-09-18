pragma solidity >=0.4.22 <0.8.0;

contract Staking {
    
    uint256 private transaction_fee;
    uint256 public total_amount_staked;
    uint256 public amount_staked_between_stakers;


    address owner;
    address payable[] public stakers;

    struct Depositer {
        uint amount_deposited;   
        uint256 time;
    }

    mapping(address => Depositer) public DepositerInfo;

    constructor() public {
        owner = msg.sender;
    }

    function donate() public payable {
        total_amount_staked += msg.value;
    }


    function deposit() public payable {

        DepositerInfo[msg.sender].amount_deposited += msg.value;
        DepositerInfo[msg.sender].time = block.timestamp;

        total_amount_staked += msg.value;
        amount_staked_between_stakers += msg.value;

        stakers.push(msg.sender);
    }

    function pay_out() public {
        uint bp;
        uint amount_pay_out;
        address payable depositerAddress;

        depositerAddress = stakers[0];

        bp = DepositerInfo[depositerAddress].amount_deposited * 100000 / amount_staked_between_stakers;
        amount_pay_out = total_amount_staked * bp / 100000;

        depositerAddress.transfer(amount_pay_out);
    }

    function get_percentage() public view returns(uint256) {
        uint bp;

        bp = DepositerInfo[stakers[0]].amount_deposited * 1000 / amount_staked_between_stakers;

        return (total_amount_staked * bp / 1000);
    }

    function getLiquidity() public view returns(uint256){
        return total_amount_staked;
    }

    function get_time() public view returns(uint256) {
        return block.timestamp;
    }
}