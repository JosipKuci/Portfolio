/*
	A simple lottery system that drafts a winner depending on a pseudo random number 
*/
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0<0.9.0;

contract Lottery{
    address payable[] public players;
    address payable public admin;

    constructor(){admin=payable(msg.sender);}

    receive() external payable{
        require((msg.value==0.1 ether)&&(msg.sender!=admin));
        players.push(payable(msg.sender));
    }

    function getBalance() public view returns(uint){
        require(msg.sender==admin);
        return address(this).balance;
    }

    function random() public view returns (uint)
    {
        return uint(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, players.length))); //Creates a pseudo random number
    }

    function PickWinner() public 
    {
        require(players.length>=3 && msg.sender==admin); //A lottery can be drawn when there are three or more players and only the admin can start the draft
        uint256 i=random()%players.length;
        address payable winner=players[i];
        admin.transfer(getBalance()/10);//The creator of the lottery gets 10% of the winnings
        winner.transfer(getBalance());
        players=new address payable[](0);
    }
}
