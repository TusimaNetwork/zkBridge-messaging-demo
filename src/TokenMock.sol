// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.16;
import {ITokenMock} from "./interface/ITokenMock.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import {ERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";


contract TokenMock is ERC20,Ownable,ITokenMock {
    mapping (address => bool) public admin;

    constructor(
        string memory name_,
        string memory symbol_
    ) ERC20(name_, symbol_) {}


    modifier onlyAdmin() {
        require(admin[msg.sender], "Only admin allowed");
        _;
    }

    function setAdmin(address _allower,bool _isAllowed) public onlyOwner {
        admin[_allower] = _isAllowed;
    }

    function claim(address _to) public {
         _mint(_to, 1000 ether);
    }


    function mint(address _to, uint256 _amount) public virtual override onlyAdmin{
        _mint(_to, _amount);
    }

    function burn(address _owner, uint256 _amount) public virtual override onlyAdmin{
        _burn(_owner, _amount);
    }
}
