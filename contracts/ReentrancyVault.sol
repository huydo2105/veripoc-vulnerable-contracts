// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

/// @title ReentrancyVault (Intentional Test Fixture — DO NOT DEPLOY TO MAINNET)
/// @notice Minimal ETH vault containing an intentional checks-effects-interactions bug for VeriPoC testing.
contract ReentrancyVault {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        require(msg.value > 0, "zero deposit");
        balances[msg.sender] += msg.value;
    }

    /// @dev Vulnerable: external call occurs before balance is zeroed.
    function withdraw() external {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "no balance");
        (bool ok, ) = msg.sender.call{value: amount}("");
        require(ok, "transfer failed");
        balances[msg.sender] = 0;
    }
}
