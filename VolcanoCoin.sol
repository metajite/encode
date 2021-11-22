//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract VolcanoCoin{

    uint totalSupply = 10000;
    address owner;
    mapping (address => uint) public balance;
    mapping (address => Payment[]) public userPaymentsMap;
    
    struct Payment{
        uint transferAmount;
        address recipientAddress;
    }
    
    event TransferredAmount (string _msg, uint _transferredAmount, address _recipientAddress);
    event NewTotalSupply(uint _newTotal);
    event PaymentArrayContent(uint _index, uint _amount);

    constructor(){
        owner = msg.sender;
        balance[owner] = totalSupply;
    }
    
    modifier onlyOwner(){
        if (msg.sender == owner){
            _;
        }
    }

    function getTotalSupply() public view returns (uint){
        return totalSupply;
    }

    function increaseTotalSupply() public onlyOwner{
        totalSupply += 1000;
        emit NewTotalSupply(totalSupply);
    }

    function transerToken(uint amountToTransfer, address recipientAddress) public {
        
        balance[msg.sender] -= amountToTransfer;
        balance[recipientAddress] += amountToTransfer;
        
        Payment memory _payment;
        _payment.transferAmount = amountToTransfer;
        _payment.recipientAddress = recipientAddress;
        
        userPaymentsMap[msg.sender].push(_payment);

        emit TransferredAmount("Transferred some tokens between accounts", amountToTransfer, recipientAddress);
        
        uint length = userPaymentsMap[msg.sender].length;
        
        for (uint index=0; index < length; index++){
            uint val = userPaymentsMap[msg.sender][index].transferAmount;
            emit PaymentArrayContent(index, val);    
        }
        
    }
}
