# Proven Fair Lottery (Raffle) 🎰

A decentralized, tamper-proof lottery smart contract built with **Foundry**. This protocol utilizes **Chainlink VRF** for provably fair randomness and **Chainlink Automation** for decentralized, time-based triggers.

## 👨‍💻 About The Project

This project implements a raffle system where users can enter by paying an entrance fee. After a specific time interval, the contract automatically requests a random number from a Chainlink Oracle to select a winner.

**Key Features:**
* **True Randomness:** Uses Chainlink VRF (Verifiable Random Function) to select winners, ensuring the process is tamper-proof and mathematically verifiable.
* **Automation:** Uses Chainlink Keepers/Automation to trigger the winner selection automatically once the time interval has passed.
* **Professional Testing:** Includes a comprehensive test suite with **Unit Tests**, **Integration Tests**, and **Fuzz/Invariant Tests** to ensure protocol security.

## 🛠 Technology Stack

* **Solidity** (Smart Contract Language)
* **Foundry** (Development Framework)
* **Chainlink VRF** (Randomness)
* **Chainlink Automation** (Event Triggers)
* **Solhint** (Linting)

## 🚀 Getting Started

### Requirements

* [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* [foundry](https://getfoundry.sh/)

### Installation

1.  Clone the repository
    ```bash
    git clone [https://github.com/GitAniket98/Smart-Contract-Lottery-Foundry.git](https://github.com/GitAniket98/Smart-Contract-Lottery-Foundry.git)
    cd Smart-Contract-Lottery-Foundry
    ```
2.  Install dependencies
    ```bash
    forge install
    ```

## 🧪 Testing

This project uses Foundry for advanced testing.

**Run all tests:**
```bash
forge test
```

**See test coverage:**

```bash

forge coverage

```

## 📜 Deployment


**1. Local Network (Anvil)**
The project includes a HelperConfig script that automatically sets up a Mock VRF Coordinator on local chains.

Start a local node:

```bash

anvil
```
Deploy the contract (in a new terminal):

```bash

forge script script/DeployRaffle.s.sol:DeployRaffle --rpc-url [http://127.0.0.1:8545](http://127.0.0.1:8545) --broadcast --private-key <ANVIL_PRIVATE_KEY>

```


**2. Testnet (Optimism Sepolia)**
To deploy to a live testnet, you need to set up your environment variables.

Create a .env file:

```bash

OP_SEPOLIA_RPC_URL=your_rpc_url
PRIVATE_KEY=your_private_key
ETHERSCAN_API_KEY=your_etherscan_api_key
```
Deploy and Verify:

```bash

forge script script/DeployRaffle.s.sol:DeployRaffle \
    --rpc-url $OP_SEPOLIA_RPC_URL \
    --account default \
    --broadcast \
    --verify \
    --verifier etherscan \
    --etherscan-api-key $ETHERSCAN_API_KEY

```


**3 .Important: After deployment, register your contract address as a Consumer in your Chainlink VRF Subscription at vrf.chain.link.**



## 🤝 Acknowledgements
*Patrick Collins & Cyfrin Updraft for the excellent educational resources.*

*Chainlink Labs for the Oracle infrastructure.*
