pragma solidity ^0.5.1;
contract MyERC20Contract{
    
  
    
    mapping(address => uint256) balances; //stores address and corresponding token balance
    mapping(address => mapping (address => uint256)) allowed; //stores addresseses allowed to withdraw with correspondinglimit for each
    
    uint256 totalSupply_;
    
    constructor (uint256 _total) public {
        totalSupply_ = _total;
        balances[msg.sender] = totalSupply_; //msg.sender contains the Ethereum account executing the current contract function.
    }
    
    function totalSupply() public view returns(uint256){ // function will return the number of all tokens allocated by this contract regardless of owner.
        return totalSupply_;
    }
    
    function balanceOf(address tokenowner) public view returns (uint256){
        return balances[tokenowner];
    }
    
    function transfer(address receiver,  uint numTokens) public returns(bool){
            
            require(numTokens <= balances[msg.sender]);
            balances[msg.sender] = balances[msg.sender] - numTokens;                
            balances[receiver] = balances[receiver] + numTokens;
            emit Transfer(msg.sender, receiver, numTokens);
            return true;
        
    }
    
    //used to approve token Transfer in a marketplace 
    function approve(address delegate, uint numTokens) public returns (bool){
    allowed[msg.sender][delegate] = numTokens;//set approval limits
    emit Approval(msg.sender, delegate, numTokens);
    return true;
    }
    
    //returns the current approved number of tokens by an owner to a specific delegate
    // as set in the approve function.
    function allowance(address owner, address delegate) public view returns(uint){
        return allowed[owner][delegate];
    }

    //transfer tokens from owneer to delegate
    function transferFrom(address owner, address buyer, uint numTokens) public returns (bool){
        require(numTokens <= balances[owner]);
        require(numTokens <= allowed[owner][msg.sender] );
        balances[owner] = balances[owner] - numTokens;
        allowed[owner][msg.sender] = allowed[owner][msg.sender] - numTokens;
        balances[buyer] = balances[buyer] + numTokens;
        emit Transfer(owner, buyer, numTokens);
        return true;
    }
  
  event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
  event Transfer(address indexed from, address indexed to, uint tokens);
}
