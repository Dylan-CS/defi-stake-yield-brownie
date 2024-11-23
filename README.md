# defi-stake-yield-brownie

## Overview
This project is a decentralized finance (DeFi) application that allows users to stake tokens for yield farming, collateral, or other purposes. It includes several key functionalities:

1. **stakeTokens**: Add any approved token to the farming contract.
2. **unStakeTokens**: Remove your tokens from the contract.
3. **getUserTotalValue**: Calculate the total value supplied by users using Chainlink Price Feeds.
4. **issueTokens**: Reward users staking on your platform.

## Smart Contracts
- **ERC-20_TOKEN DappToken**: `0xEeD0900B2b6b9C2b656C0C26c7130fD8e56868D7`
- **ERC-20_TOKEN WETH**: `0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6`
- **ERC-20_TOKEN fau/(DAI)**: `0xBA62BCfcAaFc6622853cca2BE6Ac7d845BC0f2Dc`
- **TokenFarm**: `0xc282D7280E764612d62f61D005E4867E57A39dce`

![Project Image](https://github.com/Dylan-CS/defi-stake-yield-brownie/blob/main/IMGS/20230214174448.jpg)

## Prerequisites
To get started with this project, ensure you have the following installed:
- **Node.js** (version 19.6.0 recommended, use nvm for version management)
- **Visual Studio Code** (VSCode)
- **Solidity extension** for VSCode
- **Ganache CLI** for local testing: `npm install -g ganache-cli`
- **Brownie** framework: `pip install eth-brownie`

## Setup Instructions
1. **Clone the Repository**: 
   ```bash
   git clone https://github.com/Dylan-CS/defi-stake-yield-brownie.git
   ```

2. **Environment Configuration**: 
   Create a `.env` file with the following content:
   ```plaintext
   export WEB3_ALCHEMY_PROJECT_ID=your_alchemy_project_id
   export PRIVATE_KEY=your_metamask_private_key
   export ETHERSCAN_TOKEN=your_etherscan_token
   ```

3. **Compile Smart Contracts**: 
   ```bash
   brownie compile
   ```

4. **Run Tests**: 
   Test the smart contracts in a local environment:
   ```bash
   brownie test
   ```

   **Note**: To deploy the smart contract yourself, update the `.env` configuration and run:
   ```bash
   brownie run scripts/deploy.py --network goerli
   ```

5. **Front-End Setup**: 
   Navigate to the `front_end` directory and install dependencies:
   ```bash
   cd front_end
   yarn
   ```

6. **Start the Front-End**: 
   ```bash
   yarn start
   ```

   **Notes**:
   - If you encounter issues starting the app, try running:
     ```bash
     $env:NODE_OPTIONS = "--openssl-legacy-provider"
     ```
   - Configuration files for React are located at `front_end/src/brownie-config.json` and `front_end/src/helper-config.json`.

7. **Access the Application**: 
   Open your browser and go to [http://localhost:3000/](http://localhost:3000/) to view the application.

## Updates
- **Faucet Contract**: `0xd011033ec6b1f5bcf9be454344E40d7C04e8573D`

## Additional Resources
- For more information on running tests, refer to the [Create React App documentation](https://facebook.github.io/create-react-app/docs/running-tests).
- To learn more about React, visit the [React documentation](https://reactjs.org/).
