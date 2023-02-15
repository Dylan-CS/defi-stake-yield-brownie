#defi-stake-yield-brownie

1. stakeTokens: Add any approved token to the farming contract for yeild farming, collateral, or whatever you want to do.
2. unStakeTokens: Remove your tokens from the contract.
3. getUserTotalValue: Get the total value that users have supplied based on calculations from the Chainlink Price Feeds.
4. issueTokens: Issue a reward to the users staking on your platform!

Smart contract:
1. ERC-20_TOKEN DappToken:'0xEeD0900B2b6b9C2b656C0C26c7130fD8e56868D7"
2. ERC-20_TOKEN WETH:"0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6"
3. ERC-20_TOKEN fau/(DAI):"0xBA62BCfcAaFc6622853cca2BE6Ac7d845BC0f2Dc"
4. TokenFarm:'0xc282D7280E764612d62f61D005E4867E57A39dce"

![image](https://github.com/Dylan-CS/defi-stake-yield-brownie/blob/main/IMGS/20230214174448.jpg)


Preparations:
1. Node.js (* 19.6.0 ) nvm is recommended.
2. Vscode
3. The extension of "solidity" in vscode
4. download the ganache-cli(for local test). run the command "npm install -g ganache-cli"
5. download framework "Brownie", run the command "pip install eth-brownie" 

Steps to start this project 
1. git clone https://github.com/Dylan-CS/defi-stake-yield-brownie.git
2. Add a file named .env  
Here is its content:  
export WEB3_ALCHEMY_PROJECT_ID= rPgRgEqPogUQ_giz5IyzX_PhegVYiXdl(this is the goerli node of alchemy)  
export PRIVATE_KEY= your private key of metamask  
export ETHERSCAN_TOKEN= etherscan token  
3. Run the command "brownie compile" to compile the smart contract.
4. Run the command "brownie test" to test whether smart contract can work correctly in local environment.  
Note: If you want to deploy Smart contract yourself,change the configuration in step 2 and run the command "brownie run scripts/deploy.py  --network goerli"
5. "cd front_end" "yarn"(download the node_modules) "yarn start"  
Note1: If you can't yarn start, run the command $env:NODE_OPTIONS = "--openssl-legacy-provider"  
Note2: the configuration of React---front_end\src\brownie-config.json,front_end\src\helper-config.json  
6. open browser and enter http://localhost:3000/ to check the website.