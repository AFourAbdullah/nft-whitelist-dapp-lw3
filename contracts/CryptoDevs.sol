// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Whitelist.sol";
contract CryptoDevs is ERC721Enumerable,Ownable{
    uint256 public constant price=0.01 ether;
      uint256 constant public maxTokenIds = 20;

      //instance of whitelist contract
      Whitelist whitelist;
         // Number of tokens reserved for whitelisted members
    uint256 public reservedTokens;
    uint256 public reservedTokensClaimed = 0;

    constructor(address whitelistContractAddress) ERC721("Crypto Devs","CD"){

        whitelist=Whitelist(whitelistContractAddress);
        reservedTokens=whitelist.maxNumOfWhitelistedAddressAllowed();
    }
    function mint()  public payable {
        require(totalSupply()+reservedTokens-reservedTokensClaimed<maxTokenIds,"Max limit exceeded");
        if(whitelist.isWhitelisted(msg.sender)&& msg.value<price){
            require(balanceOf(msg.sender)==0,"Already owned an nft");
               reservedTokensClaimed += 1;
        }
        else{
            require(msg.value>=price,"Not enough ethers send!");

        }
        uint256 tokenId=totalSupply();
        _safeMint(msg.sender,tokenId);  
    }
    function withDraw() public onlyOwner
{
address _owner=owner();
uint256 amount=address(this).balance; 
 (bool sent, ) =  _owner.call{value: amount}("");
        require(sent, "Failed to send Ether");


}
}