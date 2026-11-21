# VeriPoC Vulnerable Contracts (Test Fixture Repository)

> **Warning:** Every contract in this repository contains **intentional security vulnerabilities** for local testing of VeriPoC bug bounty setup, AI agent auditing, and isolated Foundry PoC verification. **Never deploy these contracts to mainnet or use them with real funds.**

## Scope
- `contracts/ReentrancyVault.sol` — ETH vault with checks-effects-interactions bug in `withdraw()`.
- `contracts/ShareInflationVault.sol` — ERC-4626-style vault vulnerable to first-depositor donation share-price inflation.
- `contracts/FlashLoanOraclePool.sol` — Lending pool relying on manipulable spot reserve ratio for collateral valuation.

## Instructions
1. Clone this repository at the pinned commit hash and run locally with Foundry (`forge test`).
2. Identify root causes violating core solvency, share-accounting, or withdrawal invariants.
3. Submit a structured claim with affected path, commit hash, reproduction command, and observed vs. expected asset balances.

## Out of Scope
- Deploying to any public mainnet or testing third-party infrastructure.
- Social engineering, denial-of-service against hosted RPC nodes, or gas-only micro-optimizations.

## Reward Policy (Demo / Testnet Reference)
| Severity | Range (USD) |
| :--- | :--- |
| Critical | $10,000 – $50,000 |
| High | $2,500 – $10,000 |
| Medium | $500 – $2,500 |
| Low | $0 (Not offered) |
| Informational | $0 (Not offered) |
