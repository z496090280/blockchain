// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// 4轮
// 1. 白金名单 - free - 2
// 2. 白名单 - free - 1
// 3. 公开轮(开售) - 0.02ETH
// 4. og空投 - free - 5
contract HanFu {
    struct StepsStruct {
        uint startTime;
        uint endTime;
        uint freeCount;
        mapping(address => uint) whiteLists;
    }

    StepsStruct[4] Steps;

    // 录入单轮数据
    function setStep(
        uint step,
        uint startTime,
        uint endTime,
        uint freeCount
    ) public {
        Steps[step].startTime = startTime;
        Steps[step].endTime = endTime;
        Steps[step].freeCount = freeCount;
    }

    function setWhiteLists(uint step, address player) public {
        Steps[step].whiteLists[player] = Steps[step].freeCount;
    }

    function getCurrentStep() public view returns (uint) {
        uint nowTime = block.timestamp;
        uint currentKey;
        for (uint k = 0; k < 4; k++) {
            if (Steps[k].startTime <= nowTime && Steps[k].endTime >= nowTime) {
                currentKey = k;
            }
        }

        return currentKey;
    }

    // 消耗一次
    function mint(address player) public byWhite(player) returns (bool) {
        return true;
    }

    // 查询白名单数量
    function queryMintCount(address player) public view returns (uint) {
        uint currentStep = getCurrentStep();
        return Steps[currentStep].whiteLists[player];
    }

    modifier byWhite(address player) {
        uint currentStep = getCurrentStep();
        require(Steps[currentStep].whiteLists[player] > 0, "have no white");
        _;
        Steps[currentStep].whiteLists[player]--;
    }
}
