pragma solidity >=0.4.22 <0.8.0;

contract Staking {
    
    uint256 public total_amount_staked;
    uint256 public amount_staked_between_stakers;

    address owner;
    address payable[] public stakers;

    struct Depositer {
        uint amount_deposited;   
        uint256 time;
        bool registered;
    }

    mapping(address => Depositer) public DepositerInfo;

    constructor() public {
        owner = msg.sender;
    }

    function donate() public payable {
        total_amount_staked += msg.value;
    }

    function stakerExists(address payable staker) public view returns(bool){
        if(DepositerInfo[staker].registered) return true;
        return false;
    }


    function deposit() public payable {

        if (!stakerExists(msg.sender)) {
            stakers.push(msg.sender);
            DepositerInfo[msg.sender].registered = true;
        }

        DepositerInfo[msg.sender].amount_deposited += msg.value;
        DepositerInfo[msg.sender].time = block.timestamp;

        total_amount_staked += msg.value;
        amount_staked_between_stakers += msg.value;
    }

    function pay_out() public {
        uint bp;
        uint amount_pay_out;
        address payable depositerAddress;

        for (uint256 i = 0; i < stakers.length; i++) 
        {
            depositerAddress = stakers[i];

            bp = DepositerInfo[depositerAddress].amount_deposited * 100000 / amount_staked_between_stakers;
            amount_pay_out = (total_amount_staked * bp / 100000);

            require(amount_pay_out < total_amount_staked);
            depositerAddress.transfer(amount_pay_out);

            DepositerInfo[depositerAddress].amount_deposited = 0;
            DepositerInfo[depositerAddress].registered = false;
        } 

        delete stakers;

        total_amount_staked = 0;
        amount_staked_between_stakers= 0;

    }

    function get_pay_out(address payable staker) public view returns(uint) {
        uint bp;
        uint amount_pay_out;
        address payable depositerAddress;

        require(stakerExists(staker), "Not a vaild Staker" );

        depositerAddress = staker;

        bp = DepositerInfo[depositerAddress].amount_deposited * 100000 / amount_staked_between_stakers;
        amount_pay_out = total_amount_staked * bp / 100000;

        return(amount_pay_out - 100000000000000000);

    }
    

    function get_percentage() public view returns(uint256) {
        uint bp;

        bp = DepositerInfo[stakers[0]].amount_deposited * 1000 / amount_staked_between_stakers;

        return (total_amount_staked * bp / 1000);
    }

    function get_amount_staked() public view returns(uint256){
        return total_amount_staked;
    }

    function get_time() public view returns(uint256) {
        return block.timestamp;
    }
}