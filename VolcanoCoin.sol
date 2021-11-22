//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract VolcanoCoin{

    uint totalSupply = 10000;
    address owner;

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
    }
}
