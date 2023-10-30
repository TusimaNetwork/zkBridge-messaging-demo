// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;
import {ITokenMock} from "./interface/ITokenMock.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import {ERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";


contract TokenMock is ERC20,Ownable,ITokenMock {
    mapping (address => bool) public allower;

    constructor(
        string memory name_,
        string memory symbol_
    ) ERC20(name_, symbol_) {}


    modifier onlyAllower() {
        require(allower[msg.sender], "Only deployer allowed");
        _;
    }

    function setAllower(address _allower,bool _isAllowed) public onlyOwner {
        allower[_allower] = _isAllowed;
    }

    function claim(address _to) public {
         _mint(_to, 1000 ether);
    }


    function mint(address _to, uint256 _amount) public virtual override onlyAllower{
        _mint(_to, _amount);
    }

    function burn(address _owner, uint256 _amount) public virtual override onlyAllower{
        _burn(_owner, _amount);
    }
}
