// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 实现合约的增删改查
contract CURD {
    // 结构体
    struct PersonStruct {
        address userAddress;
        uint age;
        string name;
        bool isUsing;
        string[] persName;
        address operation;
    }
    mapping(address => PersonStruct) public Person;

    // 增
    function addUser(
        address _user,
        uint _age,
        string memory _name,
        bool _isUsing,
        string[] memory _persName
    ) public {
        PersonStruct memory tmp;

        tmp.userAddress = _user;
        tmp.age = _age;
        tmp.name = _name;
        tmp.persName = _persName;
        tmp.isUsing = _isUsing;
        tmp.operation = msg.sender;

        Person[_user] = tmp;
    }

    // 删
    function deleteUser(address _user) public returns (bool) {
        delete Person[_user];
        return true;
    }

    // 改
    function editUser(address _user, bool _isUsing) public {
        Person[_user].isUsing = _isUsing;
    }

    // 查
    function queryUser(
        address _user
    ) public view returns (PersonStruct memory) {
        PersonStruct memory tmp = Person[_user];
        return tmp;
    }
}
