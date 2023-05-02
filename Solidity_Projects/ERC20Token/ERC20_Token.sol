/*
    A simple token code made using the ERC20 standard template with the essential functions and events
*/
//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 < 0.9.0;
interface ERC20 {
    
    function totalSupply() external view returns (uint);
    function balanceOf(address tokenOwner) external view returns (uint balance);
    function transfer(address to, uint tokens) external returns (bool success);

    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    function approve(address spender, uint tokens) external returns (bool success);
    function allowance(address tokenOwner, address spender) external view returns (uint);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}

contract crypto is ERC20{
    string public name="Kuchie";
    string public symbol="KUCH";
    uint public decimals=0;
    uint public override totalSupply;

    address public founder;
    mapping(address=>uint) public balances;

    mapping(address => mapping(address=>uint)) allowed;


    constructor(){
        totalSupply=100000000;
        founder=msg.sender;
        balances[founder]=totalSupply;
    }

    function balanceOf(address tokenOwner) public view override returns (uint balance){
        return balances[tokenOwner];
    }

    function transfer(address to, uint tokens) public override returns (bool success)
    {
        require(balances[msg.sender]>=tokens);
        balances[to]+=tokens;
        balances[msg.sender]-=tokens;
        emit Transfer(msg.sender, to, tokens);

        return true;
    }

    function allowance(address tokenOwner, address spender) public view override returns (uint){
        return allowed[tokenOwner][spender];
    }

    function approve(address spender, uint tokens) public override returns (bool success){
        require(balances[msg.sender]>=tokens);
        require(tokens>0);

        allowed[msg.sender][spender]=tokens;

        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function transferFrom(address from, address to, uint tokens) public override returns (bool success){
        require(allowed[from][msg.sender]>=tokens);
        require(balances[from]>=tokens);
        balances[from]-=tokens;
        allowed[from][msg.sender]-=tokens;
        balances[to]+=tokens;
        emit Transfer(from, to, tokens);
        return true;
    }

}
