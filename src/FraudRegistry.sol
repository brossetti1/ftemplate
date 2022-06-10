// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.13;

abstract contract ENS {
    function resolver(bytes32 node) public view virtual returns (ENSResolver);
}

abstract contract ENSResolver {
    function addr(bytes32 node) public view virtual returns (address);
}

/// @title A registry for reporting stolen wallets
/// @author brianrossetti.eth
/// @notice This contract is used as a Registry for signaling that your address has been compromised.
/// @notice funds from fees go to the address registered at protocolguild.eth
/// @custom:experimental This is an experimental contract.
contract FraudRegistry {
    address public ENS_RESOVLER_ADDRESS =
        0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e;
    bytes32 public PROTOCOL_GUILD_NODE = "protocolguild.eth";
    ENS ens = ENS(0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e);

    function resolveAddress(bytes32 node) public view returns (address) {
        ENSResolver resolver = ens.resolver(PROTOCOL_GUILD_NODE);
        return resolver.addr(PROTOCOL_GUILD_NODE);
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function preRegisterWallet() public {}

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function iAmPreRegistedAndMyWalletWasStolen() public {}

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function myWalletWasStolen() public {}

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function iWantToSponserGasForTheNetwork() public {}

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function iWantToSponserGasForFriendsWallet() public {}

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function signStolenWallet() public {}

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function hasWalletSignaledItsStolen() public {}

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function hasWalletSignaledItsStolenCrossChainCall() public {}
}
