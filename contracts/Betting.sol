pragma solidity >=0.4.22 <0.8.0;


contract Betting {
   address payable public owner;
   uint256 public minimumBet;
   uint256 public totalBetsOne;
   uint256 public totalBetsTwo;
   address payable[] public players;

   struct Player {
      uint256 amountBet;
   
      uint16 teamSelected;
    }


   mapping(address => Player) public playerInfo;
   function() external payable {}
   
  constructor() public {
      owner = msg.sender;
      minimumBet = 100000000000000;
    }

    function kill() public {
      if(msg.sender == owner) selfdestruct(owner);
    }
    
    function checkPlayerExists(address payable player) public view returns(bool){
        for(uint256 i = 0; i < players.length; i++){
            if(players[i] == player) return true;
        }
        return false;
    }

    function bet(uint8 _teamSelected) public payable {

      require(!checkPlayerExists(msg.sender));
      require(msg.value >= minimumBet);

      playerInfo[msg.sender].amountBet = msg.value;
      playerInfo[msg.sender].teamSelected = _teamSelected;

      players.push(msg.sender);

      if ( _teamSelected == 1){
          totalBetsOne += msg.value;
      }
      else{
          totalBetsTwo += msg.value;
      }
    }


    function distributePrizes(uint16 teamWinner) public {
     
      address payable[1000] memory winners;
      uint256 count = 0; 
      uint256 LoserBet = 0;
      uint256 WinnerBet = 0; 
      address add;
      uint256 bet;
      address payable playerAddress;
      
      for(uint256 i = 0; i < players.length; i++){
         playerAddress = players[i];

         if(playerInfo[playerAddress].teamSelected == teamWinner){
            winners[count] = playerAddress;
            count++;
         }
      }

      if ( teamWinner == 1){
         LoserBet = totalBetsTwo;
         WinnerBet = totalBetsOne;
      }
      else{
          LoserBet = totalBetsOne;
          WinnerBet = totalBetsTwo;
      }

      for(uint256 j = 0; j < count; j++){
         if(winners[j] != address(0))
            add = winners[j];
            bet = playerInfo[add].amountBet;
            winners[j].transfer((bet*(10000+(LoserBet*10000/WinnerBet)))/10000 );
      }
      
      delete playerInfo[playerAddress]; 
      players.length = 0; 
      LoserBet = 0; 
      WinnerBet = 0;
      totalBetsOne = 0;
      totalBetsTwo = 0;
    }

    function getAmountOfBetOne() public view returns(uint256){
       return totalBetsOne;
    }

    function getAmountOfBetTwo() public view returns(uint256){
       return totalBetsTwo;
    }
}