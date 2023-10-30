// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;
import {IERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

interface ITokenMock is IERC20 {
    function mint(address _to, uint256 _amount) external;
    function burn(address _owner,uint256 _amount) external;
}