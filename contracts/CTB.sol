// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./CTB_ERC721.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/**
 * @dev change: token name
 * @dev add: rewards update function for front end
 */
interface TOKEN {
    function burn(address _from, uint256 amount) external;
}
    
contract CTB is Initializable, CTB_ERC721 {
    string constant _name = "Cult of the Basilisk";
    string constant _symbol = "CTB";

    event Evolution(uint256 NewCTBId, uint256 CTBId);
    event NewCultist(uint256 CTBId, string cultist);
    event NewMemo(uint256 CTBId, string memo);

    TOKEN public token;

    mapping(uint256 => uint256) public evolvedList; //CTBId to binary (taken or not)
    mapping(uint256 => CTBData) public ctbData; //CTBId to Evolved CTB data

    /**
     * @dev change: prices once we set the token
     */
    uint256 constant public EVOLUTION_PRICE =      60 ether;
    uint256 constant public CULTIST_CHANGE_PRICE = 15 ether;
    uint256 constant public MEMO_CHANGE_PRICE =    5 ether;
    
    struct CTBData{
        string cultist;
        string memo;
    }

    function initialize(uint256 genCount, uint256 supply, string memory baseUri) initializer public {
        __ERC721_init(_name, _symbol);
        __Ownable_init();

        baseURI = baseUri;
        price = 0.08888 ether;
        maxCTB = supply;
        maxGen = genCount;
        evolvedCTB = totalSupply() > genCount ? totalSupply() - genCount : 0;
        presaleActive = false;
        saleActive = false;
    }

    modifier CTBOwner(uint256 CTBId) {
        require(ownerOf(CTBId) == msg.sender, "Cannot interact with a CTB you do not own");
        _;
    }

    /**
     * evolution function for gen 2 CTB
     * @dev change: token name
     */
    function evolve(uint256 CTBId) external CTBOwner(CTBId) {
        uint256 supply = totalSupply();
        require(supply < maxCTB,          "Cannot elvove anymore CTB...");
        require(CTBId < maxGen,           "Cannot evolve with evolved CTB...");

        token.burn(msg.sender, EVOLUTION_PRICE);
        uint256 NewCTBId = maxGen + evolvedCTB;
        evolvedList[NewCTBId] = 1;
        evolvedCTB++;
        _safeMint(msg.sender, NewCTBId);
        emit Evolution(NewCTBId, CTBId);
    }

    /**
     * cultist name change function for archive
     * @dev change: token name
     * @dev change: name length
     */
    function changeCultist(uint256 CTBId, string memory newCultist) external CTBOwner(CTBId) {
        bytes memory cultist = bytes(newCultist);
        require(cultist.length > 0 && cultist.length < 16,                "Invalid cultist name length...");
        require(sha256(cultist) != sha256(bytes(ctbData[CTBId].cultist)), "New cultist is the same as the previous...");

        token.burn(msg.sender, CULTIST_CHANGE_PRICE);
        ctbData[CTBId].cultist = newCultist;
        emit NewCultist(CTBId, newCultist);
    }

    /**
     * cultist memo change function for archive
     * @dev change: token name
     * @dev change: memo length
     */
    function changeMemo(uint256 CTBId, string memory newMemo) external CTBOwner(CTBId) {
        bytes memory memo = bytes(newMemo);
        require(memo.length > 0 && memo.length < 160,                "Invalid memo length...");
        require(sha256(memo) != sha256(bytes(ctbData[CTBId].memo)), "New memo is the same as the previous...");

        token.burn(msg.sender, CULTIST_CHANGE_PRICE);
        ctbData[CTBId].memo = newMemo;
        emit NewMemo(CTBId, newMemo);
    }
}