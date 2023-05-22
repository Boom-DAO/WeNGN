Repository for the eNaira token smart contract

The token is an ERC20 token that can be minted by the owner

# Compile
forge build

# Test
forge test

# Deploy
forge script (local deployment)

or

forge create -i --rpc-url "RPC_URL" src/WrappedENaira.sol:WrappedENaira (testnet or mainnet deployment)

# Verify
export ETHERSCAN_API_KEY="API_KEY"

forge verify-contract --chain mainnet "ADDRESS" src/WrappedENaira.sol:WrappedENaira --watch