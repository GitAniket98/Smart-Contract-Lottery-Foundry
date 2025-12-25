// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Raffle {
    error Raffle__NotEnoughETHEntered();

    uint256 private immutable i_entranceFee;
    address payable[] private s_players;

    event RaffleEntered(address indexed player);

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }

    function enterRaffle() external payable {
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnoughETHEntered();
        }

        s_players.push(payable(msg.sender));
        emit RaffleEntered(msg.sender);
    }

    function pickWinner() external  {}

    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }
}
