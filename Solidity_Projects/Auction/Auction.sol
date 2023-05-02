/*
	An ebay-like auction system where the creator can create multiple auctions and the bidders bid for it
	The winning bid is the biggest and has to pay the binding bid value. The Seller gets the binding bid amount while the losing bids can withdraw their money
*/
//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0<0.9.0;
contract AuctionCreator{ //creates instances of the auction contract
    Auction[] public auctions;
    function createAuction() public
    {
        Auction newAuction=new Auction(msg.sender);
        auctions.push(newAuction);
    }
}


contract Auction
{
    address payable public seller;
    uint public start;
    uint public end;
    string public ipfsHash;

    enum State {Started, Running, Ended, Canceled}
    State public auctionState;

    uint public highestBid;
    uint public highestBindingBid;
    address payable public highestBidder;

    mapping(address => uint) public bids;

    uint bidIncrement;
    constructor(address eoa)//argument refers to the deployer of AuctionCreator contract
    {
        seller=payable(eoa);
        auctionState=State.Running;
        start=block.number;
        end=start+40320; //a difference of 1 week
        ipfsHash="";
        bidIncrement=100; //min that a person has to bid combared to the highest bid is 100 wei
    }

    modifier notSeller()
    {
        require(msg.sender!=seller);
        _;
    }

    modifier afterStart()
    {
        require(block.number>=start);
        _;
    }

    modifier beforeEnd()
    {
        require(block.number<=end);
        _;
    }

    modifier onlySeller ()
    {
        require(msg.sender==seller);
        _;
    }

    function min(uint a, uint b) pure internal returns(uint)
    {
        if(a>=b)
        return b;
        else 
        return a;
    }

    function cancelAuction() public onlySeller
    {
        auctionState=State.Canceled;
    }

    function placeBid() public payable notSeller afterStart beforeEnd{
        require(auctionState==State.Running);
        require(msg.value>=100);

        uint currentBid = bids[msg.sender]+msg.value;

        require(currentBid>highestBid);

        bids[msg.sender]=currentBid;

        if(currentBid<=bids[highestBidder]) //if-else statement for calculating the highest binding bid
        {
            highestBindingBid=min(currentBid+bidIncrement,bids[highestBidder]);
        }
        else 
        {
            highestBindingBid=min(currentBid,bids[highestBidder]+bidIncrement);
            highestBidder=payable(msg.sender);
        }
    }

    function finalize() public {
        require(auctionState == State.Canceled || block.number>end);
        require(msg.sender==seller || bids[msg.sender]>0);
        address payable recipient;
        uint value;

        if(auctionState == State.Canceled){ //returns money to bidders if the auction is canceled
            recipient = payable(msg.sender);
            value=bids[msg.sender];
        }else if(msg.sender==seller) //seller gets the highest binding bid from the highest bidder
        {
            {
                recipient=seller;
                value=highestBindingBid;

            }
        }else if(msg.sender==highestBidder) //Highest bidder pays the amount of the highest binding bid while getting back the rest
        {
            recipient = highestBidder;
            value=bids[highestBidder]-highestBindingBid;
        }else //If the bidder didn't win the auction, his bid is returned in full
        {
            recipient=payable (msg.sender);
            value=bids[msg.sender];
        }
        bids[recipient]=0;
        recipient.transfer(value);
    }
}