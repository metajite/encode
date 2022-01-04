//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract VolcanoCoin is ERC20, Ownable{

    mapping (address => Payment[]) public userPaymentRecords;
    
    struct Payment{
        uint transferAmount;
        address recipientAddress;
    }
    
    event TransferredAmount (string _msg, uint _transferredAmount, address _recipientAddress);
    event NewTotalSupply(uint _newTotal);
    event PaymentArrayContent(uint _index, uint _amount);

    constructor(uint initialSupply) ERC20("Volcano Coin", "VLC"){
        _mint(msg.sender, initialSupply);
    }
    
    function mintMore(uint _additionalSupply) public{
        _mint(msg.sender, _additionalSupply);
    }
    
    function transferToken(address recipientAddress, uint amountToTransfer) public  {
        
        require(recipientAddress != address(0), "Cannot send to zero address");
        Payment memory _payment;
        _payment.transferAmount = amountToTransfer;
        _payment.recipientAddress = recipientAddress;
        
        userPaymentRecords[msg.sender].push(_payment);

        emit TransferredAmount("Transferred some tokens between accounts", amountToTransfer, recipientAddress);
        
        uint length = userPaymentRecords[msg.sender].length;
        
        for (uint index=0; index < length; index++){
            uint val = userPaymentRecords[msg.sender][index].transferAmount;
            emit PaymentArrayContent(index, val);    
        }
        
    }
}
