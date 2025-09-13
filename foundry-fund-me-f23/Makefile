-include .env

build:; forge build

deploy-sepolia:
	forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify -etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

test:; forge test --fork-url $(SEPOLIA_RPC_URL) -vvvv

.PHONY: build test clean deploy fund help install snapshot format anvil

deploy; forge script script/DeployFundMe.s.sol:DeployFundMe

