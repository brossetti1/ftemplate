// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.13;

import "./shared/PriceConsumerV3.sol";
import "./lib/PublicGoodsAreGood.sol";

error NotEnoughFunds(uint256 requested, uint256 received);
error UserNotSponsored(address wallet);
error UserAlreadySponsored(address wallet);
error UserAlreadyRegistered(address wallet);

/// @title A registry for reporting stolen wallets
/// @author brianrossetti.eth
/// @notice This contract is used as a Registry for signaling that your address has been compromised.
/// @notice funds from fees go to the address registered at protocolguild.eth
/// @custom:experimental This is an experimental contract.
contract StolenWalletRegistry {
    //  for statements (libraries)
    //  Type declarations
    //    - structs
    //    - enums
    //  State variables
    //  Events
    //  modifier functions

    PriceFeedConsumer private priceConsumer;

    /// count of preRegistered wallets
    // TODO probably unnecessary
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
    uint256 public publicGoodsRegistrationFee = 5 * 1e18; // minimum of $5 in eth to register wallet for public goods
    // uint256 public multiWalletDiscount ------- maybe? for organizations that sponsor multiple wallets
    // uint256 public publicGoodsRemovalPenaltyFee ------- penaltyFee for removing account from registry
    uint256 public crossChainSearchFee = 2 * 1e18; // minimum of $2 in eth to pre-register

    uint256 public registeredWalletCount = 0;
    uint256 public sponsoredWalletCount = 0;
    mapping(address => uint256) public registeredWallets;
    mapping(address => bool) private sponsoredWallets;

    event RegisteredAddressEvent(address registeredWallet);
    event WalletsSponsoredEvent(
        address sponsoree,
        uint256 walletsSentCount,
        uint256 alreadyRegisteredCount,
        uint256 alreadySponsoredCount,
        uint256 sponsoredCount
    );

    constructor(address _priceFeed) {
        priceConsumer = PriceFeedConsumer(_priceFeed);
    }

    receive() external payable {
        fundProtocolGuild();
    }

    function fundProtocolGuild() public payable {
        (bool sent, ) = PublicGoodsAreGood.resolvePGAddress().call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }

    function fundOptimismRetroactivePublicGoods() public payable {
        (bool sent, ) = PublicGoodsAreGood.resolveOPRetroactiveFund().call{value: address(this).balance}("");
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
        if (msg.value < (publicGoodsRegistrationFee * 1e18) / getLatestPrice()) {
            revert NotEnoughFunds(publicGoodsRegistrationFee, msg.value);
        }

        registeredWallets[msg.sender] = block.timestamp;
        registeredWalletCount++;

        emit RegisteredAddressEvent(msg.sender);
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function aFriendSponsoredMeAndMyWalletWasStolen() external {
        if (sponsoredWallets[msg.sender]) {
            registeredWallets[msg.sender] = block.timestamp;
            registeredWalletCount++;

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
    function iWantToSponserGasForMultipleWallets(address[] calldata wallets) external payable {
        if (msg.value <= ((publicGoodsRegistrationFee * 1e18) * wallets.length) / getLatestPrice()) {
            revert NotEnoughFunds(publicGoodsRegistrationFee * wallets.length, msg.value);
        }

        uint256 alreadySponsored = 0;
        uint256 alreadyRegistered = 0;

        for (uint256 i = 1; i < wallets.length; i++) {
            if (isWalletAlreadySponsored(wallets[i])) {
                alreadySponsored++;
                continue;
            }

            if (isWalletRegisted(wallets[i])) {
                alreadyRegistered++;
                continue;
            }

            sponsoredWallets[wallets[i]] = true;
        }

        uint256 sponsoredCount = wallets.length - alreadySponsored - alreadyRegistered;
        sponsoredWalletCount += sponsoredCount;

        emit WalletsSponsoredEvent(msg.sender, wallets.length, alreadyRegistered, alreadySponsored, sponsoredCount);
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function iWantToSponserGasForAFriendsWallet(address wallet) external payable {
        if (msg.value <= (publicGoodsRegistrationFee * 1e18) / getLatestPrice()) {
            revert NotEnoughFunds(publicGoodsRegistrationFee, msg.value);
        }

        if (isWalletAlreadySponsored(wallet)) {
            revert UserAlreadySponsored(wallet);
        }

        if (isWalletRegisted(wallet)) {
            revert UserAlreadyRegistered(wallet);
        }

        sponsoredWallets[wallet] = true;
        sponsoredWalletCount++;

        emit WalletsSponsoredEvent(msg.sender, 1, 0, 0, 1);
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function signStolenWallet() external {}

    //  External functions that are view
    //  External functions that are pure
    //
    //  Public functions
    //  Public functions that are view
    function isWalletRegisted(address wallet) public view returns (bool) {
        return registeredWallets[wallet] != 0 && registeredWallets[wallet] < block.timestamp;
    }

    function whenWalletWasRegisted(address wallet) public view returns (uint256) {
        return registeredWallets[wallet];
    }

    function isMyWalletSponsored() public view returns (bool) {
        return sponsoredWallets[msg.sender];
    }

    //  Public functions that are pure
    //
    //  Internal functions
    //  Internal functions that are view
    //  Internal functions that are pure
    //
    //  Private functions
    //  Private functions that are pure

    // External functions that are view
    function isWalletAlreadySponsored(address wallet) private view returns (bool) {
        return sponsoredWallets[wallet];
    }

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
    // function balanceMinium() private onlyOwner {}
    // function balanceThreshold() private onlyOwner {}
}
