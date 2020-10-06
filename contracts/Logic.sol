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

contract Proxy is Storage {
    
    modifier onlyOwner() {
        require (msg.sender == owner);
        _;
    }
    
    /**
     * @dev constructor that sets the owner address
     */
    constructor() public {
        owner = msg.sender;
    }
    
    /**
     * @dev Upgrades the implementation address
     * @param _newImplementation address of the new implementation
     */
    function upgradeTo(address _newImplementation) 
        external onlyOwner 
    {
        require(implementation != _newImplementation);
        _setImplementation(_newImplementation);
    }
    
    /**
     * @dev Fallback function allowing to perform a delegatecall 
     * to the given implementation. This function will return 
     * whatever the implementation call returns
     */
    function () payable public {
        address impl = implementation;
        require(impl != address(0));
        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize)
            let result := delegatecall(gas, impl, ptr, calldatasize, 0, 0)
            let size := returndatasize
            returndatacopy(ptr, 0, size)
            
            switch result
            case 0 { revert(ptr, size) }
            default { return(ptr, size) }
        }
    }
    
    /**
     * @dev Sets the address of the current implementation
     * @param _newImp address of the new implementation
     */
    function _setImplementation(address _newImp) internal {
        implementation = _newImp;
    }
}