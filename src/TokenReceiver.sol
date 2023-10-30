// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;
import {ITokenMock} from "./interface/ITokenMock.sol";
import {Receiver} from "lib/zkBridge-messaging-interfaces/src/interfaces/Receiver.sol";

contract TokenReceiver is Receiver {
    struct Info {
        uint256 tokenAmount;
        address receiver;
    }

    event TokenMessageReceived(
        uint32 indexed sourceChainId,
        address indexed sourceAddress,
        Info message
    );

    address public messaging;
    address public tokenMock;

    constructor(
        address _tusimaMessaging,
        address _tokenMock
    ) Receiver(_tusimaMessaging) {
        tokenMock = _tokenMock;
        messaging = _tusimaMessaging;
    }

    function handleMsgImpl(
        uint32 _sourceChainId,
        address _sourceAddress,
        bytes memory _message
    ) internal override {
        Info memory info = decodeInfo(_message);

        ITokenMock(tokenMock).mint(info.receiver, info.tokenAmount);

        emit TokenMessageReceived(_sourceChainId, _sourceAddress, info);
    }

    function decodeInfo(
        bytes memory _message
    ) public pure returns (Info memory info) {
        uint256 tokenAmount; // 256 / 8 = 32
        address receiver; // 20 bytes
        assembly {
            tokenAmount := mload(add(_message, 32))
            receiver := mload(add(_message, 52))
        }
        info.tokenAmount = tokenAmount;
        info.receiver = receiver;
    }
}
