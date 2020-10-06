pragma solidity >=0.4.22 <0.8.0;

import "./Storage.sol";

contract Storage {
    address public new_bet;
    address public owner;
    mapping (address => uint) internal points;
    uint internal totalPlayers;
}

contract Logic is Storage {

    modifier onlyOwner() {
        require (msg.sender == owner);
        _;
    }
 
    function addPlayer(address _player, uint _points) public onlyOwner 
    {
        require (points[_player] == 0);
        points[_player] = _points;
    }
    
    function setPoints(address _player, uint _points) public onlyOwner 
    {
        require (points[_player] != 0);
        points[_player] = _points;
    }
}