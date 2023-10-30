// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

import "forge-std/Script.sol";
import "../src/TokenMock.sol";
import "../src/TokenReceiver.sol";

contract DeploySender is Script {
    address tokenMockAddress;

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        deployTokenMock();
        deployTokenReceiver();
        vm.stopBroadcast();
    }

    function deployTokenMock() internal {
        TokenMock tokenMock = new TokenMock("TokenMock", "TokenMock");
        tokenMockAddress = address(tokenMock);
    }

    function deployTokenReceiver() internal {
        address messagingAddress = vm.envAddress("tusimaMessaging");
        new TokenReceiver(messagingAddress, tokenMockAddress);
    }
}
