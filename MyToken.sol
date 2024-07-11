// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    // The constructor function is executed once when the contract is deployed
    // It takes an initial supply parameter to set the number of tokens created at deployment
    constructor(uint256 initialSupply) ERC20("MyToken", "MTK") Ownable(msg.sender) {
        // Mint the specified initial supply to the deployer's address
        // Multiplying by 10 ** decimals() to account for the token's decimal places
        _mint(msg.sender, initialSupply * 10 ** decimals());
    }

    // Define a function to mint new tokens, only accessible by the contract owner
    function mint(address to, uint256 amount) public onlyOwner {
        // Call the internal _mint function to create new tokens
        // Multiplying by 10 ** decimals() to account for the token's decimal places
        _mint(to, amount * 10 ** decimals());
    }

    // Define a function to burn tokens, accessible by anyone who holds tokens
    function burn(uint256 amount) public {
        // Call the internal _burn function to destroy tokens from the caller's balance
        // The amount is already in the smallest units, no need to multiply by decimals
        _burn(msg.sender, amount);
    }

    // Define a function to transfer tokens
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        // Call the internal _transfer function to transfer tokens
        _transfer(_msgSender(), recipient, amount);
        return true;
    }
}
