//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract AchivementContract is ERC721Enumerable, Ownable {
    struct Achivement {
        string title;
        string description;
        uint256 price;
        uint8 cooperationType;
        uint256 applicationDate;
        uint256 approveDate;
        // 联系人
        string contact;
        string email;
        string cellPhone;
        string unit;
        string department;
    }
    mapping(uint256 => Achivement) private achivements;

    constructor() public ERC721("AchivementContract", "AC") {}

    function appendAchivement(
        string memory title,
        string memory description,
        uint256 price,
        uint8 cooperationType,
        uint256 applicationDate,
        uint256 approveDate,
        // 联系人
        string memory contact,
        string memory email,
        string memory cellPhone,
        string memory unit,
        string memory department
    ) public returns (uint256 tokenId) {
        uint256 nextId = totalSupply();
        _safeMint(msg.sender, nextId);
        Achivement storage ach = achivements[nextId];
        ach.title = title;
        ach.description = description;
        ach.price = price;
        ach.cooperationType = cooperationType;
        ach.applicationDate = applicationDate;
        ach.approveDate = approveDate;
        ach.contact = contact;
        ach.email = email;
        ach.cellPhone = cellPhone;
        ach.unit = unit;
        ach.department = department;
        return nextId;
    }

    function updateInfo(
        uint256 tokenId,
        string memory title,
        string memory description,
        uint256 price,
        uint8 cooperationType,
        uint256 applicationDate,
        uint256 approveDate,
        // 联系人
        string memory contact,
        string memory email,
        string memory cellPhone,
        string memory unit,
        string memory department
    ) public {
        address achOwner = ownerOf(tokenId);
        require(
            msg.sender == achOwner,
            "Only owner of the achivement can modify information"
        );
        Achivement storage ach = achivements[tokenId];
        ach.title = title;
        ach.description = description;
        ach.price = price;
        ach.cooperationType = cooperationType;
        ach.applicationDate = applicationDate;
        ach.approveDate = approveDate;
        ach.contact = contact;
        ach.email = email;
        ach.cellPhone = cellPhone;
        ach.unit = unit;
        ach.department = department;

        // achivements[tokenId] = ach;
    }

    function updatePrice(uint256 tokenId, uint256 newPrice) public {
        address achOwner = ownerOf(tokenId);
        require(
            msg.sender == achOwner,
            "Only owner of the achivement can modify information"
        );
        Achivement storage ach = achivements[tokenId];
        ach.price = newPrice;
        achivements[tokenId] = ach;
    }

    // function getInfo(uint256 tokenId)
    //     public
    //     view
    //     returns (
    //         string memory name,
    //         uint8 role,
    //         uint8 _type,
    //         uint256 org_id,
    //         uint8 check_flag,
    //         uint256 register_time
    //     )
    // {
    //     Achivement storage ach = achivements[tokenId];
    //     return (
    //         ach.name,
    //         ach.role,
    //         ach._type,
    //         ach.org_id,
    //         ach.check_flag,
    //         ach.register_time
    //     );
    // }

    function buy(uint256 tokenId) public payable {
        Achivement storage ach = achivements[tokenId];
        require(ach.price > 0);
        require(msg.value >= ach.price);
        ach.price = 0;
        achivements[tokenId] = ach;
    }
}
