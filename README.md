<!--
 * @Description: 
 * @Author: zyq
 * @Date: 2023-10-26 20:01:57
 * @LastEditTime: 2023-10-27 18:37:50
 * @LastEditors: zyq
 * @Reference: 
-->
# Tusima zkBridge Messaging Demo

![Tusima zkBridge](https://ucarecdn.com/f4e08f06-c238-47f8-b98a-97629c199377/bridgelogo.png)

[![Tests](https://github.com/TusimaNetwork/zkBridge-messaging-interfaces/actions/workflows/test.yml/badge.svg?branch=main)](https://github.com/TusimaNetwork/zkBridge-messaging-interfaces/actions/workflows/test.yml)
[![Twitter Follow](https://img.shields.io/twitter/follow/TusimaNetwork?style=social)](https://twitter.com/TusimaNetwork)
[![Discord](https://img.shields.io/discord/965918503070728203?logo=Discord&logoColor=5865F2&label=discord&color=3ae600
)](https://discord.com/invite/tusimanetwork)

**Tusima zkBridge** is a one-stop cross-chain solution based on zkSNARKs technology that is trustless and permissionless. 

For more information about Tusima zkBridge please refer to [here](https://tusima.gitbook.io/zkbridge/).

**Messaging** is the primary module of Tusima zkBridge, providing a set of `Solidity` language APIs. Through these APIs, developers can seamlessly transmit messages from the source chain to the destination chain, thus enabling the creation of omnichain applications.

Messaging Repo: [TusimaNetwork/zkBridge-Messaging](https://github.com/TusimaNetwork/zkBridge-messaging)

This repo aims to guide you through a demo on how to achieve a quick cross-chain token transfer using Tusima zkBridge.

## Build with source code

We are using **Foundry**, so before you build this project, make sure you have installed Foundry.

> Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust. More detailed information please refer to their [doc](https://book.getfoundry.sh/).


### Build

common build:
```shell
$ forge build
```

ZKSync build:
```shell
$ zkforge zkbuild
```
> install zkforge : https://github.com/matter-labs/foundry-zksync

### Test

```shell
$ forge test
```

### Deploy
deploy on Goerli with verify:

```shell
change tusimaMessaging address in .env

$ source .env

$ forge script script/Deploy.s.sol:Deploy --broadcast --verify --rpc-url ${GOERLI_RPC_URL}
```

deploy on Bsc-Testnet with verify:
```shell
change tusimaMessaging address in .env

$ source .env

$ forge script script/Deploy.s.sol:Deploy --broadcast --verify --rpc-url ${BSCTEST_RPC_URL}
```
> "--verify" do not support on bsc-testnet network

deploy ZKSync-Era testnet:
```shell
change tusimaMessaging address in .env

$ source .env

$ zkforge zkc src/TokenMock.sol:TokenMock --constructor-args "TokenMock" "TokenMock" --private-key <private_key> --rpc-url https://zksync2-testnet.zksync.dev:443 --chain 280

$ zkforge zkc src/TokenSender.sol:TokenSender --constructor-args <zkMessagingAddress> <tokenMockAddress> --private-key <private_key> --rpc-url https://zksync2-testnet.zksync.dev:443 --chain 280

$ zkforge zkc src/TokenReceiver.sol:TokenReceiver --constructor-args <zkMessagingAddress> <tokenMockAddress> --private-key <private_key> --rpc-url https://zksync2-testnet.zksync.dev:443 --chain 280
```

### Verify
verify on bsc-testnet:
```shell
$ forge verify-contract --verifier-url https://api-testnet.bscscan.com/api <contrasct_address> src/TokenSender.sol:TokenSender --etherscan-api-key ${BSCSCAN_API_KEY} --chain bsc-testnet --constructor-args $(cast abi-encode "constructor(address,address)" <address> <address>)
```

