// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Test, console} from "forge-std/Test.sol";
import {Raffle} from "../../src/Raffle.sol";
import {DeployRaffle} from "../../script/DeployRaffle.s.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";

contract RaffleTest is Test {
    Raffle public raffle;
    HelperConfig public helperConfig;

    uint256 entranceFee;
    uint256 interval;
    bytes32 gasLane;
    address vrfCoordinator;
    uint256 subscriptionId;
    uint32 callbackGasLimit;

    address public PLAYER = makeAddr("player");
    uint256 public constant STARTING_USER_BALANCE = 10 ether;

    function setUp() external {
        DeployRaffle deployer = new DeployRaffle();
        (raffle, helperConfig) = deployer.deployContract();
        HelperConfig.NetworkConfig memory networkConfig = helperConfig
            .getConfig();
        entranceFee = networkConfig.entranceFee;
        interval = networkConfig.interval;
        gasLane = networkConfig.gasLane;
        vrfCoordinator = networkConfig.vrfCoordinator;
        subscriptionId = networkConfig.subscriptionId;
        callbackGasLimit = networkConfig.callbackGasLimit;
    }

    function testRaffleInitializesInOpenState() public view {
        console.log("Raffle State:", uint256(raffle.getRaffleState()));
        assert(raffle.getRaffleState() == Raffle.RaffleState.OPEN);
    }
}
