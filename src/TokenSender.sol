// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;

import {ITokenMock} from "./interface/ITokenMock.sol";
import {ISender} from "lib/zkBridge-messaging-interfaces/src/interfaces/IMessaging.sol";

contract TokenSender {
    event SendToken(
        uint32 destinationChainId,
        address msgReceiver,
        uint256 tokenAmount,
        address receiver
    );

    ISender public messaging;
    address public tokenMock;

    constructor(address _tusimaMessaging, address _tokenMock) {
        messaging = ISender(_tusimaMessaging);
        tokenMock = _tokenMock;
    }

    function sendToken(
        uint32 _destinationChainId,
        address _msgReceiver,
        uint256 _tokenAmount,
        address _receiver
    ) external {
        ITokenMock(tokenMock).burn(msg.sender, _tokenAmount);
        bytes memory message = abi.encodePacked(_tokenAmount, _receiver);
        messaging.send(_destinationChainId, _msgReceiver, message);

        emit SendToken(
            _destinationChainId,
            _msgReceiver,
            _tokenAmount,
            _receiver
        );
    }
}
