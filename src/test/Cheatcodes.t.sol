// SPDX-License-Identifier: UNLICENSED
// from https://book.getfoundry.sh/forge/cheatcodes.html
pragma solidity ^0.8.10;

import "@forge-std/Test.sol";

error Unauthorized();

contract OwnerUpOnly {
    address public immutable owner;
    uint256 public count;

    constructor() {
        owner = msg.sender;
    }

    function increment() external {
        if (msg.sender != owner) {
            revert Unauthorized();
        }
        count++;
    }
}

contract OwnerUpOnlyTest is Test {
    OwnerUpOnly upOnly;

    function setUp() public {
        upOnly = new OwnerUpOnly();
    }

    function testIncrementAsOwner() public {
        assertEq(upOnly.count(), 0);
        upOnly.increment();
        assertEq(upOnly.count(), 1);
    }

    function testFailIncrementAsNotOwner() public {
        vm.prank(address(0));
        upOnly.increment();
    }

    function testIncrementAsNotOwner() public {
        vm.expectRevert(Unauthorized.selector);
        vm.prank(address(0));
        upOnly.increment();
    }
}

contract EmitContractTest is Test {
    event Transfer(address indexed from, address indexed to, uint256 amount);

    function testExpectEmit() public {
        ExpectEmit emitter = new ExpectEmit();

        vm.expectEmit(true, true, false, true);

        emit Transfer(address(this), address(1337), 1337);
        emitter.t();
    }

    function testExpectEmitDoNotCheckData() public {
        ExpectEmit emitter = new ExpectEmit();
        vm.expectEmit(true, true, false, false);
        emit Transfer(address(this), address(1337), 1338);
        emitter.t();
    }
}

contract ExpectEmit {
    event Transfer(address indexed from, address indexed to, uint256 amount);

    function t() public {
        emit Transfer(msg.sender, address(1337), 1337);
    }
}
