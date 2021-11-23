pragma solidity 0.5.1;
contract MySampleContract{
    
    mapping(address => uint256) public balances;
    address payable wallet;
    
    constructor(address payable _wallet) public {
         emit myevent("transfer", "txn");
        wallet = _wallet;        
    }
    
    function() external payable{
        emit myevent("transfer", "txn");
        buyToken();
    }
    
    function buyToken() public payable{
        //buy a buyToken
        balances[msg.sender] += 1;
        //send ether to wallet 
        wallet.transfer(msg.value);
        emit myevent("test1","add");
        
    }
    
    event myevent(string _eventname, string _type);
    
    
}
