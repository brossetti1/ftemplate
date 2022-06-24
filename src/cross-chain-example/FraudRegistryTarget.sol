// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.13;

import {IExecutor} from "nxtp/core/connext/interfaces/IExecutor.sol";
import {IConnextHandler} from "nxtp/core/connext/interfaces/IConnextHandler.sol";

import "../shared/PriceConsumerV3.sol";

abstract contract ENS {
    function resolver(bytes32 node) public view virtual returns (ENSResolver);
}

abstract contract ENSResolver {
    function addr(bytes32 node) public view virtual returns (address);
}

error notEnoughFunds(uint256 requested, uint256 received);

/// @title A registry for reporting stolen wallets
/// @author brianrossetti.eth
/// @notice This contract is used as a Registry for signaling that your address has been compromised.
/// @notice funds from fees go to the address registered at protocolguild.eth
/// @custom:experimental This is an experimental contract.
contract FraudRegistry {
    // The address of Source.sol
    address public originContracts;

    // The origin Domain ID
    // Goerli (chainId: 5, domainId: 3331)
    uint32 public originDomain;

    // The address of the Connext Executor contract
    IExecutor public executor;

    //  for statements (libraries)
    //  Type declarations
    //    - structs
    //    - enums
    //  State variables
    //  Events
    //  modifier functions
    address public constant ENS_RESOVLER_ADDRESS = 0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e;
    bytes32 public constant PROTOCOL_GUILD_NODE = "protocolguild.eth";
    ENS ens = ENS(0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e);

    PriceFeedConsumer private priceConsumer;

    /// count of preRegistered wallets
    uint256 public preRegisteredWalletCount = 0;
    uint256 public preRegisteredWalletsReported = 0;
    uint256 public balanceMinium = 10; // 10%
    uint256 public balanceThreshold = 20; // 20%

    /// Costs for preRegistration
    /// @notice pre registration fee puts funds into the contract
    ///         that way later you can just sign to signal your wallet is compromised.
    /// @notice L2 is cheap, fees from users will accrue a base pool for preRegistration users to draw from.
    ///   1) a minimum of balanceMinium OR balanceThreshold * (preRegisteredWalletCount - preRegisteredWalletsReported)
    //       funds will need to be in the balance for a sufficient base pool to absorb preRegistered users
    //       who are being compromised to send a signature and have the smart contract pull from the pool to pay for fees.
    ///   2) once the balanceMinium or balanceThreashold is reached,
    ///      fees will be forwarded to the protocolguild.eth address and donated as a public good.
    ///      Should the balanceMinimum or balanceThreshold fall below the specified amount,
    ///      fees will return accruing inside the contract until the balanceMinimum or balanceThreshold is reached.
    uint256 public registrationFee = 5 * 1e18; // minimum of $5 in eth to pre-register
    uint256 public crossChainSearchFee = 2 * 1e18; // minimum of $2 in eth to pre-register

    mapping(address => uint256) public registeredWallets;
    mapping(address => bool) private sponsoredWallets;

    event RegisteredAddressEvent(address registeredWallet);
    event UserNotSponsored(address wallet);

    constructor(address _priceFeed) {
        priceConsumer = PriceFeedConsumer(_priceFeed);
    }

    receive() external payable {
        (bool sent, ) = resolvePGAddress().call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }

    fallback() external {
        // ...
    }

    //  External functions
    /// @notice pre-register your wallet so you can simply sign later.
    /// fees on L2's and sidechains are cheap, this contract will take a
    /// @dev Explain to a developer any extra details
    function preRegisterWallet() external payable {}

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function iAmPreRegistedAndMyWalletWasStolen() external {}

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function myWalletWasStolen() external payable {
        if (msg.value < (registrationFee * 1e18) / getLatestPrice()) {
            revert notEnoughFunds(registrationFee, msg.value);
        }

        registeredWallets[msg.sender] = block.timestamp;
        emit RegisteredAddressEvent(msg.sender);
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function aFriendSponsoredMeAndMyWalletWasStolen() external {
        if (sponsoredWallets[msg.sender]) {
            registeredWallets[msg.sender] = block.timestamp;

            emit RegisteredAddressEvent(msg.sender);
        } else {
            revert UserNotSponsored(msg.sender);
        }
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function iWantToSponserGasForTheNetwork() external payable {}

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function iWantToSponserGasForFriendsWallet(address[] wallets) external payable {
        if (msg.value * wallets.length >= (registrationFee * 1e18) / getLatestPrice()) {
            revert notEnoughFunds(registrationFee * wallets.length, msg.value);
        }

        for (uint256 i = 1; i < wallets.length; i++) {
            if (!sponsoredWallets[wallets[i]]) {
                sponsoredWallet[wallets[i]] = true;
            }
        }
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function signStolenWallet() external {}

    function fundProtocolGuild() external {
        (bool sent, ) = resolvePGAddress().call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }

    //  External functions that are view
    //  External functions that are pure
    //
    //  Public functions
    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function hasWalletSignaledItsStolenCrossChainCall() public view returns (bool) {
        // use chainlinks https://chain.link/cross-chain
    }

    //  Public functions that are view
    function isWalletRegisted(address wallet) public view returns (bool) {
        return registeredWallets[wallet] < block.timestamp;
    }

    function whenWalletWasRegisted(address wallet) public view returns (uint256) {
        return registeredWallets[wallet];
    }

    function isWalletSponsored() public view returns (bool) {
        return sponsoredWallets[msg.sender];
    }

    //  Public functions that are pure
    //
    //  Internal functions
    //  Internal functions that are view
    //  Internal functions that are pure
    //
    //  Private functions
    //  Private functions that are view
    //  Private functions that are pure

    // External functions that are view
    // ...

    // External functions that are pure
    // ...

    // Public functions

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function getLatestPrice() internal returns (uint256) {
        return uint256(priceConsumer.getLatestPrice()) * 1e18;
    }

    // function CROSS_CHAIN_SEARCH_FEE() internal onlyOwner {}

    // Private functions

    // TODO mainnet eth resolver check...
    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function resolvePGAddress() private returns (address) {
        ENSResolver resolver = ens.resolver(PROTOCOL_GUILD_NODE);
        return resolver.addr(PROTOCOL_GUILD_NODE);
    }

    // function balanceMinium() private onlyOwner {}
    // function balanceThreshold() private onlyOwner {}
}
