//SPDX-License-Identifier: Unlicense

pragma solidity >=0.4.22 <0.9.0;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


/* Please complete the ERC20 token with the following extensions;
1) - Capped Token: The minting token should not be exceeded from the Capped limit.


2)
- TimeBound Token: The token will not be transferred until the given time exceed. For example Wages payment will be due after 30
days.


3) should be deployed by using truffle or hardhat on any Ethereum test network
*/

// ==========================================================================================================



contract Galaxy is ERC20,Ownable{

    // address owner;
    uint private rate;
    uint private tokenCap = 2000000 * 100 ** 18;
    uint private deployedtime;
    address tokenAddress;
    
  constructor() ERC20("Galaxy", "GXY"){
        _mint(msg.sender, 1000000 * (10 ** uint256(decimals())));
        rate = 100;
        deployedtime =  block.timestamp;
        // IERC20 tcontract = IERC20(tokenAddress);
    }
    
      modifier etherValue {
      require( msg.value > 0);
      _;
  }
  
   
  // ____________________ Task 3b-1 ____________________
  function getTokens() payable external {
    
    require(ERC20.totalSupply() + msg.value <= tokenCap && msg.value > 0 , "ERC20Capped: Token Cap exceeded");
    _mint(msg.sender, msg.value * rate * 10 ** 18);
      
  }
  
  
  // ____________________ Task 3b-b ____________________
  function transferfun(address recipient, uint256 amount) external  {
        require(block.timestamp >= deployedtime + 30 days, "30 Days not passed yet");
        _transfer(_msgSender(), recipient, amount);
    }
  
    // ____________________ Fallback ____________________
  
  fallback() external payable etherValue(){
      _mint(msg.sender, msg.value * rate * 10 ** 18);
  }

   receive() external payable{
    }
   
    
    // ____________________ Rate Change ____________________
    function changePrice(uint _rate) external onlyOwner{
    rate = _rate;
  }
}