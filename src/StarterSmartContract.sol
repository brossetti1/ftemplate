// always follow NatSpec
// https://docs.soliditylang.org/en/latest/natspec-format.html

// Inside each contract, library or interface, use the following order:
// Pragma statements
// Imports
// Interfaces
// Libraries
// errors
//   ex: error NotEnoughFunds(uint requested, uint available);
//       revert NotEnoughFunds(amount, balance);
// contract

// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.13;

/// @author FooBar
/// @title A simple FooBar example
contract FooBar {
    //  for statements (libraries)
    //  Type declarations
    //    - structs
    //    - enums
    //  State variables
    //  Events
    //  modifier functions
    //  constructor
    //  receive function (if exists)
    //  fallback function (if exists)
    //  External functions
    //  External functions that are view
    //  External functions that are pure
    //
    //  Public functions
    //  Public functions that are view
    //  Public functions that are pure
    //
    //  Internal functions
    //  Internal functions that are view
    //  Internal functions that are pure
    //
    //  Private functions
    //  Private functions that are view
    //  Private functions that are pure
}
