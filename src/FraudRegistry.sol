// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.13;

import "./PriceConsumerV3.sol";

// import "@openzeppelin/contracts/access/Ownable.sol";

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
    uint256 public preRegistrationFee = 5 * 1e18; // minimum of $5 in eth to pre-register
    uint256 public crossChainSearchFee = 2 * 1e18; // minimum of $2 in eth to pre-register

    constructor(address _priceFeed) {
        priceConsumer = PriceFeedConsumer(_priceFeed);
    }

    /// @notice pre-register your wallet so you can simply sign later.
    /// fees on L2's and sidechains are cheap, this contract will take a
    /// @dev Explain to a developer any extra details
    function preRegisterWallet() external payable {
        uint256 _price = uint256(priceConsumer.getLatestPrice()) * 1e18;
        require(msg.value >= (preRegistrationFee * 1e18) / _price, "Not enough funds");
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function iAmPreRegistedAndMyWalletWasStolen() external {}

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function myWalletWasStolen() external payable {}

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function iWantToSponserGasForTheNetwork() external payable {}

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function iWantToSponserGasForFriendsWallet() external payable {}

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function signStolenWallet() external {}

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function hasWalletSignaledItsStolen() public view returns (bool) {}

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function hasWalletSignaledItsStolenCrossChainCall() public view returns (bool) {}

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details

    // function balanceMinium() external onlyOwner {}

    // function balanceThreshold() external onlyOwner {}

    // function pre_registration_fee() external onlyOwner {}

    // function CROSS_CHAIN_SEARCH_FEE() external onlyOwner {}

    // TODO mainnet eth resolver check...
    function resolvePGAddress() public view returns (address) {
        ENSResolver resolver = ens.resolver(PROTOCOL_GUILD_NODE);
        return resolver.addr(PROTOCOL_GUILD_NODE);
    }

    function fundProtocolGuild() public {
        (bool sent, ) = resolvePGAddress().call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
}
