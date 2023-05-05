// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Auth {
    // 【Dapp】权限管理

    // 权限码
    // 0 ?
    // 1 - 最高管理员
    // 2 - 普通管理员
    // 3 - 普通员工
    // 4 - ...
    mapping(address => uint) public Admins;
    address owner;
    string public name;

    constructor() {
        owner = msg.sender;
        Admins[owner] = 1;
    }

    function checkoutState(address _user, uint stateCode) public byOwner {
        Admins[_user] = stateCode;
    }

    function setName(string memory _name) public byAdmin(2) returns (bool) {
        name = _name;
        return true;
    }

    modifier byOwner() {
        require(msg.sender == owner, "Not owner!");
        _;
    }
    // 拦截器
    modifier byAdmin(uint _authCode) {
        require(Admins[msg.sender] != 0, "Not Auth!");
        require(Admins[msg.sender] <= _authCode, "Not Admin! Auth code less");
        _;
    }
}
