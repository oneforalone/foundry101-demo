// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

contract Hello {
    string private str;

    constructor() {}

    function setter(string calldata _str) external {
        str = _str;
    }

    function getter() public view returns (string memory) {
        return str;
    }
}
