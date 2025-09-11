// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "../lib/forge-std/src/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator";

// Fix Magic numbers
uint8 constant DECIMALS = 8;
int256 constant INITIAL_ANSWER = 2000e8;

// Script to deploy mock configuration for anvil and others if wanted
contract HelperConfig is Script {
    NetworkConfig public activeNetworkConfig;

    struct NetworkConfig {
        address priceFeed;
    }

    constructor() {
        // if statement to check what chain we are on, 11155111 is sepolia
        if (block.chainid == 11155111) {
            activeNetworkConfig = getSepliaEthConfig();
        } else {
            activeNetworkConfig = getOrCreateAnvilEthConfig();
        }
    }

    function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory) {
        // If we have a price feed address, use it
        if (activeNetworkConfig.priceFeed != address(0)) {
            return activeNetworkConfig;
        }
        vm.startBroadcast();
        MockV3Aggregator mockV3Aggregator = new MockV3Aggregator(DECIMALS, INITIAL_ANSWER);
        vm.stopBroadcast();

        NetworkConfig memory anvilConfig = NetworkConfig({
            priceFeed: address(mockV3Aggregator)
        });
        return anvilConfig;
    }

    function getSepliaEthConfig() public pure returns (NetworkConfig memory) {
        // insert Sepolia config here
    }
}