Repository for the eNaira token smart contract

The token is an ERC20 token that can be minted by the owner

# Compile
forge build

# Test
forge test

# Deploy

forge script --rpc-url RPC_URL script/WrappedENaira.s.sol --broadcast

# Verify
export ETHERSCAN_API_KEY=API_KEY

forge verify-contract --chain mainnet ADDRESS_CONTRACT src/WrappedENaira.sol:WrappedENaira --watch

# you can encode the parameters on https://abi.hashex.org/
forge verify-contract --chain sepolia ADDRESS_PROXY src/UUPSProxy.sol:UUPSProxy --watch --constructor-args ABI_ENCODED_PARAMETERS
