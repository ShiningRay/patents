//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract AchivementContract is ERC721, Ownable {
    string greeting;
    struct Achivement {
        string title;
        string description;
        uint256 price;
        uint8 cooperationType;
        uint256 applicationDate;
        uint256 approveDate;
        string contact;
        string email;
        string cellPhone;
        string unit;
        string department;
    }

    constructor(string memory _greeting) {
        console.log("Deploying a Greeter with greeting:", _greeting);
        greeting = _greeting;
    }

    function greet() public view returns (string memory) {
        return greeting;
    }

    function setGreeting(string memory _greeting) public {
        console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);
        greeting = _greeting;
    }
}
