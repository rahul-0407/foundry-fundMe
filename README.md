# FundMe 💸

A decentralized crowdfunding smart contract built with Solidity and Chainlink Price Feeds. Users can fund the contract with ETH, and the contract ensures the sent amount meets a minimum USD value using real-time conversion. Only the contract owner can withdraw the collected funds.

## 🧾 Features

- ✅ Fund with ETH (minimum $5 USD equivalent)
- ✅ Chainlink Price Feed integration for real-time ETH/USD price
- ✅ Owner-only withdrawals
- ✅ Gas-efficient withdrawal function
- ✅ Built with [Foundry](https://book.getfoundry.sh/) for testing, scripting, and deployment
- ✅ Fallback and receive functions to catch ETH transfers

---

## 🧱 Smart Contracts

### `FundMe.sol`
The main contract which:
- Accepts ETH funding if above the minimum USD amount
- Stores funders and the amount they’ve funded
- Allows only the owner to withdraw the contract balance

### `PriceConverter.sol` (Library)
- Converts ETH to USD using a Chainlink AggregatorV3Interface
- Fetches live ETH price data

---

## 🔧 Requirements

- Node.js & NPM
- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- Chainlink Data Feeds (e.g., Sepolia ETH/USD address)

---

## 🧪 Running the Project

### Install Dependencies

```bash
forge install
