//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoToken is ERC721, Ownable {

    uint256 tokenID=0;
    struct MetaData {
        uint256 timestamp;
        uint256 tokenID;
        string tokenURI;
    }

    mapping(address => MetaData[]) public ownerShipRecords;
    
    constructor() ERC721 ("VolcanoToken", "VLT"){
    }
    
    function mintToken(address _to) public {
        MetaData memory _meta;
        _safeMint(_to, tokenID);
        _meta.timestamp = block.timestamp;
        _meta.tokenID = tokenID;
        _meta.tokenURI = "random";
        
        ownerShipRecords[_to].push(_meta);
        tokenID += 1;
    }
    
    function burnToken(uint256 _tokenID) public{
        _burn(_tokenID);
    }
    
    function removeReferences(uint256 _tokenID) private {
        uint max = ownerShipRecords[msg.sender].length;
        for (uint i=0; i<max; i++) {
            MetaData[] memory _arr = ownerShipRecords[msg.sender];
            if (_arr[i].tokenID == _tokenID){
                _arr[i] = _arr[max - 1];
                _arr.pop();
            }
        }
    }
    
}