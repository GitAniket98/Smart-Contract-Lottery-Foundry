// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { Script, console } from "forge-std/Script.sol";
import { Raffle } from "../src/Raffle.sol";
import { HelperConfig, CodeConstants } from "./HelperConfig.s.sol";
import { VRFCoordinatorV2_5Mock } from "@chainlink/contracts/src/v0.8/vrf/mocks/VRFCoordinatorV2_5Mock.sol";
import { LinkToken } from "../test/mocks/LinkToken.sol";
import { DevOpsTools } from "../lib/foundry-devops/src/DevOpsTools.sol";

contract CreateSubscription is Script {
    function createSubscriptionUsingConfig() public {
        HelperConfig helperConfig = new HelperConfig();
        helperConfig.getConfigByChainId(block.chainid);
        address vrfCoordinator = helperConfig.getConfigByChainId(block.chainid).vrfCoordinator;
        createSubscription(vrfCoordinator);
    }

    function createSubscription(address vrfCoordinator) public returns (uint256, address) {
        console.log("Creating subscription on chain:", block.chainid);
        vm.startBroadcast();
        uint256 subId = VRFCoordinatorV2_5Mock(vrfCoordinator).createSubscription();
        vm.stopBroadcast();
        console.log("Subscription created with ID:", subId);
        console.log("Please update the subscriptionId in HelperConfig.s.sol!");
        return (subId, vrfCoordinator);
    }

    function run() external {
        createSubscriptionUsingConfig();
    }
}

contract FundSubscription is Script, CodeConstants {
    uint256 public constant FUND_AMOUNT = 3 ether;

    function fundSubscriptionUsingConfig() public {
        HelperConfig helperConfig = new HelperConfig();
        address vrfCoordinator = helperConfig.getConfig().vrfCoordinator;
        uint256 subscriptionId = helperConfig.getConfig().subscriptionId;
        address linkToken = helperConfig.getConfig().link;
        fundSubscription(vrfCoordinator, subscriptionId, linkToken);
    }

    function fundSubscription(address vrfCoordinator, uint256 subscriptionId, address linkToken) public {
        console.log("Funding subscription:", subscriptionId);
        console.log("Using VRF Coordinator:", vrfCoordinator);
        console.log("On chain:", block.chainid);

        if (block.chainid == LOCAL_CHAINID) {
            vm.startBroadcast();
            VRFCoordinatorV2_5Mock(vrfCoordinator).fundSubscription(subscriptionId, FUND_AMOUNT * 100);
            vm.stopBroadcast();
            console.log("Subscription funded!");
        } else {
            vm.startBroadcast();
            LinkToken(linkToken).transferAndCall(vrfCoordinator, FUND_AMOUNT, abi.encode(subscriptionId));
            vm.stopBroadcast();
            console.log("Subscription funded!");
        }
    }

    function run() public {
        fundSubscriptionUsingConfig();
    }
}

contract AddConsumer is Script {
    function addConsumerUsingConfig(address mostRecentlyDeployedContract) public {
        HelperConfig helperConfig = new HelperConfig();
        address vrfCoordinator = helperConfig.getConfig().vrfCoordinator;
        uint256 subId = helperConfig.getConfig().subscriptionId;
        addConsumer(vrfCoordinator, subId, mostRecentlyDeployedContract);
    }

    function addConsumer(address vrfCoordinator, uint256 subId, address contractToAddToVRF) public {
        console.log("Adding consumer to subscription on chain:", block.chainid);
        console.log("Using VRF Coordinator:", vrfCoordinator);
        console.log("Subscription ID:", subId);
        console.log("Adding consumer contract:", contractToAddToVRF);

        vm.startBroadcast();
        VRFCoordinatorV2_5Mock(vrfCoordinator).addConsumer(subId, contractToAddToVRF);
        vm.stopBroadcast();
        console.log("Consumer added to subscription:", subId);
    }

    function run() external {
        address raffle = DevOpsTools.get_most_recent_deployment("Raffle", block.chainid);
        addConsumerUsingConfig(raffle);
    }
}
