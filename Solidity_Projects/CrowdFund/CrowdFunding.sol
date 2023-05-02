/*
    A Crowd-funding system where the admin can create different requests and the contributors can vote on what requests to support
    If the crowd-funding was cancelled or the goal wasn't reached, the contributors can withdraw their money
*/
//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0<0.9.0;
contract CrowdFunding{

    mapping(address=>uint) public contributors;
    address public admin;
    uint public numContributors;
    uint public minContribution;
    uint public deadline;
    uint public goal;
    uint public raised;

    struct Request{
        string description;
        address payable recipient;
        uint value;
        bool completed;
        uint numVoters;
        mapping (address=>bool) voters;
    }

    mapping(uint=>Request) public requests;

    uint public numRequests;

    constructor(uint _goal, uint _deadline)
    {
        goal=_goal;
        deadline=block.timestamp+_deadline;
        minContribution=100 wei;
        admin=msg.sender;
    }

    event ContributeEvent(address _sender, uint _value);
    event CreateRequestEvent(string _description, address _recipient, uint _value);
    event MakePaymentEvent(address _recipient, uint _value);

    function contribute() public payable{
        require(block.timestamp<deadline, "Deadline has passed");
        require(msg.value >= minContribution, "Minimum contribution not met!");

        if(contributors[msg.sender]==0)
        {
            numContributors++;
        }

        contributors[msg.sender]+=msg.value;
        raised+=msg.value;
        emit ContributeEvent(msg.sender, msg.value);
    }
    receive() payable external{
        contribute();
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function getRefund() public{
        require(block.timestamp>deadline && raised<goal);
        require(contributors[msg.sender]>0);

        address payable recipient = payable(msg.sender);
        uint value = contributors[msg.sender];
        recipient.transfer(value);
        contributors[msg.sender]=0;
    }
    modifier onlyAdmin()
    {
        require(msg.sender==admin, "Only admin can call this function");
        _;
    }

    function CreateRequest(string memory _description, address payable _recipient, uint _value)  public onlyAdmin{
        Request storage newRequest=requests[numRequests];
        numRequests++;
        newRequest.description=_description;
        newRequest.recipient=_recipient;
        newRequest.value=_value;
        newRequest.completed=false;
        newRequest.numVoters=0;

        emit CreateRequestEvent(_description, _recipient, _value);
    }

    function VoteRequest(uint _requestNum) public{
        require(contributors[msg.sender]>0,"Must be a contributor to vote");
        Request storage thisRequest=requests[_requestNum];
        require(thisRequest.voters[msg.sender]==false, "Already has voted");
        thisRequest.voters[msg.sender]=true;
        thisRequest.numVoters++;
    }

    function makePayment(uint _requestNum) public payable onlyAdmin{
        require(raised>=goal);
        Request storage thisRequest = requests[_requestNum];
        require(thisRequest.completed==false, "Request already completed");
        require(thisRequest.numVoters>numContributors/2); //More than 50% of contributors have to vote for a certain request

        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.completed=true;

        emit MakePaymentEvent(thisRequest.recipient, thisRequest.value);
    }
}