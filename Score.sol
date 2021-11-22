//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;


contract Score {
    
uint score;
address owner;

struct Funder {
    address addr;
    uint amount;
}

event NewScore(uint _newScore);
event NewFee(uint _newFee);

constructor(){
    owner = msg.sender;
}

modifier onlyOwner {
    if (msg.sender == owner){
        _;
    }
}

modifier Fee(uint fee){
    
    if (msg.value == fee) {
        _;
    }
}

function getScore() public view returns (uint) {
    return score;
}

   
function setScore(uint _newScore) public onlyOwner {
    score = _newScore;
    emit NewScore(score);
}

}

    /**
     *  public --> wallets, other contracts, internal functions and contscts that inherit score
     * 
     *  internal --> visible to internal function, inherited
     * 
     *  external --> outside contract, not internal
     * 
     *  provate --> internally. Cannot be inherited
     * 
     * 
     * view --> reads storage
     * 
     * pure --> neither reads nor modifies state -> e.g. calculation
     * */