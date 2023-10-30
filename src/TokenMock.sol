// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;
import {ITokenMock} from "./interface/ITokenMock.sol";
import {ERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";


contract TokenMock is ERC20, ITokenMock {
    constructor(
        string memory name_,
        string memory symbol_
    ) ERC20(name_, symbol_) {}

    function mint(address _to, uint256 _amount) public virtual override {
        _mint(_to, _amount);
    }

    function burn(address _owner, uint256 _amount) public virtual override {
        _burn(_owner, _amount);
    }
}
