// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

interface IReservePair {
    function reserveToken() external view returns (uint256);
    function reserveStable() external view returns (uint256);
}

/// @title FlashLoanOraclePool (Intentional Test Fixture — DO NOT DEPLOY TO MAINNET)
/// @notice Minimal lending pool using manipulable spot reserves as collateral price.
contract FlashLoanOraclePool {
    IReservePair public immutable pair;
    mapping(address => uint256) public collateral;
    mapping(address => uint256) public debt;

    constructor(IReservePair pair_) {
        pair = pair_;
    }

    /// @dev Vulnerable: spot reserve ratio can be manipulated within a single transaction.
    function spotPrice() public view returns (uint256) {
        return (pair.reserveStable() * 1e18) / pair.reserveToken();
    }

    function depositCollateral(uint256 amount) external {
        collateral[msg.sender] += amount;
    }

    function borrow(uint256 stableAmount) external {
        uint256 collateralValue = (collateral[msg.sender] * spotPrice()) / 1e18;
        require((debt[msg.sender] + stableAmount) * 100 <= collateralValue * 80, "undercollateralized");
        debt[msg.sender] += stableAmount;
    }
}
