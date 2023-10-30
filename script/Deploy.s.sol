// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

import "forge-std/Script.sol";
import "../src/TokenMock.sol";
import "../src/TokenSender.sol";
import "../src/TokenReceiver.sol";

contract Deploy is Script {
    TokenMock tokenMock;

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        deployTokenMock();
        deployTokenSender();
        deployTokenReceiver();
        vm.stopBroadcast();
    }

    function deployTokenMock() internal {
        new TokenMock("TokenMock", "TokenMock");
    }

    function deployTokenSender() internal {
        address messagingAddress = vm.envAddress("tusimaMessaging");
        TokenSender tokenSender = new TokenSender(messagingAddress, address(tokenMock));
        tokenMock.setAllower(address(tokenSender),true);
    }

    function deployTokenReceiver() internal {
        address messagingAddress = vm.envAddress("tusimaMessaging");
        TokenReceiver tokenReceiver = new TokenReceiver(messagingAddress, address(tokenMock));
        tokenMock.setAllower(address(tokenReceiver),true);
    }
}
