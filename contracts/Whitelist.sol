// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
contract Whitelist{
    uint8 public maxNumOfWhitelistedAddressAllowed;
    uint8 public numOfWhitelistedAddress;
    mapping (address => bool) public isWhitelisted;
    constructor(uint8 _maxNumOfWhitelistedAddressAllowe){
        maxNumOfWhitelistedAddressAllowed=_maxNumOfWhitelistedAddressAllowe;
    }
    function addAddressToWhitelist() public  {
        require(!isWhitelisted[msg.sender],"Address is already in whitelist!!");
        require(numOfWhitelistedAddress<maxNumOfWhitelistedAddressAllowed,"No more address allowed to be whitelisted!");
        isWhitelisted[msg.sender]=true;
        numOfWhitelistedAddress+=1;
    }
}