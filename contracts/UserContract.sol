//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract UserContract is Ownable {
    struct UserInfo {
        string name;
        uint8 role;
        uint8 _type;
        uint256 org_id;
        uint8 check_flag;
        uint256 register_time;
    }
    mapping(address => UserInfo) private user_table;

    constructor() public {}

    function updateInfo(
        string memory name,
        uint8 role,
        uint8 _type,
        uint256 org_id,
        uint8 check_flag
    ) public {
        address sender = msg.sender;
        UserInfo storage info = user_table[sender];
        info.name = name;
        info.role = role;
        info._type = _type;
        info.org_id = org_id;
        info.register_time = block.timestamp;
        info.check_flag = check_flag;
    }

    function getInfo(address user_addr)
        public
        view
        returns (
            string memory name,
            uint8 role,
            uint8 _type,
            uint256 org_id,
            uint8 check_flag,
            uint256 register_time
        )
    {
        UserInfo storage user = user_table[user_addr];
        return (
            user.name,
            user.role,
            user._type,
            user.org_id,
            user.check_flag,
            user.register_time
        );
    }
}
