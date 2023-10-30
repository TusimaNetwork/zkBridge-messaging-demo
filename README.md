<!--
 * @Description: 
 * @Author: zyq
 * @Date: 2023-10-26 20:01:57
 * @LastEditTime: 2023-10-27 18:37:50
 * @LastEditors: zyq
 * @Reference: 
-->
## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

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

