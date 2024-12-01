// SPDX-License-Identifier: MIT
pragma solidity ^0.4.24;

contract VulnerableContract {
    address public owner;
    mapping(address => uint256) public balances;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

     constructor() public {
        owner = msg.sender;
    }

    // Function to withdraw ether from the contract
    function withdraw_onlyowner(uint256 _amount) public onlyOwner {
        require(balances[msg.sender] >= _amount);
        
        // Transfer the requested amount to the caller
        (bool sent) = msg.sender.call.value(_amount)("");
        require(sent);

        // Update the balance after sending the ether
        balances[msg.sender] -= _amount;
    }

    // Function to withdraw ether from the contract
    function withdraw_not_only_owner(uint256 _amount) public {
        require(balances[msg.sender] >= _amount);
        
        // Transfer the requested amount to the caller
        (bool sent) = msg.sender.call.value(_amount)("");
        require(sent);

        // Update the balance after sending the ether
        balances[msg.sender] -= _amount;
    }

    // Fallback function to accept ether
    function() external payable {}
}
