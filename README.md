Template for a stablecoin token smart contract

The token is an ERC20 token that can be minted by the owner

# Create

Replace every occurence of __TOKEN_NAME__ by the name of the token (for example "ENaira")

Replace every occurence of __TOKEN_SYMBOL__ by the symbol of the token (for example "WeNGN")

Replace every occurence of __INITIAL_AMOUNT__ by the amount of the token (for example 1300000000000)


# Compile
forge build

# Test
forge test

# Deploy
forge script (local deployment)

or

forge create -i --rpc-url "RPC_URL" src/Wrapped__TOKEN_NAME__.sol:Wrapped__TOKEN_NAME__ (testnet or mainnet deployment)

# Verify
export ETHERSCAN_API_KEY=API_KEY

forge verify-contract --chain mainnet ADDRESS src/Wrapped__TOKEN_NAME__.sol:Wrapped__TOKEN_NAME__ --watch
