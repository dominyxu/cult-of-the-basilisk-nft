// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/math/SafeMathUpgradeable.sol";

/**
 * @title CultofTheBasilisk contract
 * @dev Extends ERC721 Non-Fungible Token Standard basic implementation
 */

contract CTB_ERC721 is ERC721Upgradeable, OwnableUpgradeable, UUPSUpgradeable, ERC721EnumerableUpgradeable {
    using SafeMathUpgradeable for uint256;

    string public baseURI;

    uint256 public maxGen;
    uint256 public maxCTB;
    uint256 public evolvedCTB;
    uint256 public price;

    bool public presaleActive;
    bool public saleActive;

    mapping (address => uint256) public presaleWhitelist;
    mapping (address => uint256) public balanceGenesis;

    function _authorizeUpgrade(address newImplementation) internal
        onlyOwner
        override
    {}

    //overrides required by OpenZeppelin
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721Upgradeable, ERC721EnumerableUpgradeable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }
    //overrides required by OpenZeppelin
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721Upgradeable, ERC721EnumerableUpgradeable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function reserve(uint256 reserved) external onlyOwner {
        uint256 supply = totalSupply();
        uint256 i;
        for (i = 1; i <= reserved; i++) {
            _safeMint(msg.sender, supply + i);
        }
    }

    function mintPresale(uint256 numberOfMints) public payable {
        uint256 supply = totalSupply();
        uint256 reserved = presaleWhitelist[msg.sender];
        require (presaleActive,                              "Presale must be active to mint");
        require (reserved > 0,                               "No tokens reserved for this address");
        require (numberOfMints <= reserved,                  "Can't mint more than reserved");
        require (supply.add(numberOfMints) <= maxGen,        "Purchase would exceed max supply of Genesis CTB");
        require (supply.add(numberOfMints) <= maxCTB,        "Purchase would exceed max supply of total CTB");
        require (price.mul(numberOfMints) == msg.value,      "Ether value sent is not correct");
        presaleWhitelist[msg.sender] = reserved - numberOfMints;

        for(uint256 i; i < numberOfMints; i++){
            _safeMint(msg.sender, supply + i);
            balanceGenesis[msg.sender]++;
        }
    }

    function mint(uint256 numberOfMints) public payable {
        uint256 supply = totalSupply();
        require (saleActive,                                 "Sale must be active to mint");
        require (numberOfMints > 0 && numberOfMints <= 4,    "Invalid purchase amount");
        require (supply.add(numberOfMints) <= maxCTB,        "Purchase would exceed max supply of total CTB");
        require (supply.add(numberOfMints) <= maxGen,        "Purchase would exceed max supply of Genesis CTB");
        require (price.mul(numberOfMints) == msg.value,      "Ether value sent is not correct");
            
        for(uint256 i; i < numberOfMints; i++) {
            _safeMint(msg.sender, supply + i);
            balanceGenesis[msg.sender]++;
        }
    }

    function editPresale(address[] calldata presaleAddresses) external onlyOwner {
        for(uint256 i; i < presaleAddresses.length; i++){
            presaleWhitelist[presaleAddresses[i]] = 4;  
        }
    }

    function walletOfOwner(address owner) external view returns(uint256[] memory) {
        uint256 tokenCount = balanceOf(owner);

        uint256[] memory tokensId = new uint256[](tokenCount);
        for(uint256 i; i < tokenCount; i++){
            tokensId[i] = tokenOfOwnerByIndex(owner, i);
        }
        return tokensId;
    }

    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }

    function togglePresale() public onlyOwner {
        presaleActive = !presaleActive;
    }

    function toggleSale() public onlyOwner {
        saleActive = !saleActive;
    }

    function setPrice(uint256 newPrice) public onlyOwner {
        price = newPrice;
    }
    
    function setBaseURI(string memory uri) public onlyOwner {
        baseURI = uri;
    }
}
