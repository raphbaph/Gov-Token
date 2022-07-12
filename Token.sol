// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GovToken is ERC20, Ownable{
    event transferInitiated(address recipient, uint256 amount);
    event transferFromInitiated(address from, address to, uint256 amount);

    constructor() ERC20("Governatooooor", "GOV"){
        // Mint 1000 tokens to each team member
        _mint(0x4f62c4228f50875A2f3BE0921c4C2c41029A8BAe, 1000*10**18);
        _mint(0xfe45c0e6BAB933C6C0E06Ba69f5626CbaD7daB70, 1000*10**18);
        _mint(0xdB69470D5e86Ae237721Cf1A292B80220d5575EA, 1000*10**18);
        _mint(0x374eee835B88d2C1f4C08997C2336B645DfDaa7a, 1000*10**18);
        _mint(0xE40da9b56283542E3da1629F18c73CC2b5E7e6Ca, 1000*10**18);

        // And then mint 510 tokens to each intern. Two interns can overrule one team member
        _mint(0xAAf9c444354C2A2a5dEDE0eC47F10a434f4475dA, 510*10**18);
        _mint(0xA1e989803E07C24d48af1be2E9C8EBF7B16Ae2E0, 510*10**18);
        _mint(0xf2275bb791347893DcfEb6F7153fdC96771f53F9, 510*10**18);
    }

// We may want to add team members at a later stage, or moar tokens...
    function issueTokens(address recipient, uint256 amount) public onlyOwner {
        _mint(recipient, amount*10**18); //make it easy on ourselves and calculate whole token amounts 
    }

// And occasionally an intern or a team member leaves and we want to remove their tokens
    function removeTokens(address from) public onlyOwner {
        _burn(from, balanceOf(from)); // burn them all, no half measures here
    }

// override the transfer function so that no actual transfers can be performed, emit an event for possible logging instead
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        emit transferInitiated(recipient, amount);

        return true;
    }

// override the transferFrom function so that no actual transfers can be performed, emit an event for possible logging instead
    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        emit transferFromInitiated(from, to, amount);

        return true;
    }
}
