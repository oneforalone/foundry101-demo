//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

import "@forge-std/test.sol";
import "../Hello.sol";

contract HelloTest is Test {
    Hello hello;

    function setUp() public {
        hello = new Hello();
    }

    function testSetter() public {
        hello.setter("Nihao");
        assertEq(hello.getter(), "Nihao");
    }
}
