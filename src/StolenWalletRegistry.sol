// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.14;

import "@openzeppelin/contracts/access/Ownable.sol";

import "./shared/PriceConsumerV3.sol";
import "./helpers/PublicGoodsAreGood.sol";

interface GaslessExectuor {
    function execute_with_custom_gas(
        address to,
        uint256 value,
        bytes memory data,
        uint8 operation,
        uint256 txGas
    ) public returns (bool success, bytes memory result);

    function execute(
        address to,
        uint256 value,
        bytes memory data,
        uint8 operation
    ) public returns (bool success, bytes memory result);
}

error NotEnoughFunds(uint256 requested, uint256 received);
error UserNotSponsored(address wallet);
error UserAlreadySponsored(address wallet);
error UserAlreadyRegistered(address wallet);

/// @title A registry for reporting stolen wallets
/// @author brianrossetti.eth
/// @notice This contract is used as a Registry for signaling that a wallet address has been compromised.
/// @notice funds from fees routed from other chains go to the address registered at protocolguild.eth
/// @notice funds from fees on Optimism go to the Optimism retroactive public goods fund.
/// @custom:experimental This is an experimental unaudited contract.
contract StolenWalletRegistry {
    PriceFeedConsumer private priceConsumer;
    GaslessExectuor public executor;

    // TODO understand if this is necessary???
    /// @notice $1 in eth for addresses that were skipped forwarded to public goods.
    uint256 public walletsSkippedPenaltyFee = 1e18;
    /// @notice minimum of $5 in eth to register wallet for public goods
    uint256 public publicGoodsRegistrationFee = 5 * 1e18;
    uint256 public registeredWalletCount = 0;
    uint256 public sponsoredWalletCount = 0;

    mapping(address => uint256) public registeredWallets;
    mapping(address => bool) private sponsoredWallets;

    event RegisteredAddressEvent(address registeredWallet, bool gasless);
    event WalletsSponsoredEvent(
        address sponsoree,
        uint256 walletsSentCount,
        uint256 alreadyRegisteredCount,
        uint256 alreadySponsoredCount,
        uint256 sponsoredCount
    );

    constructor(address _priceFeed, address _executor) {
        priceConsumer = PriceFeedConsumer(_priceFeed);
        executor = GaslessExectuor(_executor);
    }

    receive() external payable {
        (bool sent, ) = PublicGoodsAreGood.resolveProtcolGuildAddress().call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }

    // function fundProtocolGuild() public payable {
    //     (bool sent, ) = PublicGoodsAreGood.resolveProtcolGuildAddress().call{value: address(this).balance}("");
    //     require(sent, "Failed to send Ether");
    // }

    // function fundOptimismRetroactivePublicGoods() public payable {
    //     (bool sent, ) = PublicGoodsAreGood.resolveOptimismRetroactiveFund().call{value: address(this).balance}("");
    //     require(sent, "Failed to send Ether");
    // }

    fallback() external {
        // ...
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function myWalletWasStolen() external payable {
        if (msg.value <= (publicGoodsRegistrationFee * 1e18) / getLatestETHUSDPrice()) {
            revert NotEnoughFunds(publicGoodsRegistrationFee, msg.value);
        }

        registeredWallets[msg.sender] = block.timestamp;
        registeredWalletCount++;

        emit RegisteredAddressEvent(msg.sender, false);
    }

    // todo onlyExecutor
    function executorGasslessRegistry(address wallet) external payable {
        registeredWallets[wallet] = block.timestamp;
        registeredWalletCount++;

        emit RegisteredAddressEvent(msg.sender, true);
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    /// TODO payable by Gasless Execution ue executor--- onlyExecutor somewhere?
    function aFriendSponsoredMeAndMyWalletWasStolen() external {
        if (!_isWalletAlreadySponsored(msg.sender)) {
            revert UserNotSponsored(msg.sender);
        }

        if (_isWalletRegistered(msg.sender)) {
            revert UserAlreadyRegistered(msg.sender);
        }

        /// TODO verify signature of msg.sender -> error

        // TODO - gasless execution - determine the right params to send
        // executor.execute(
        //     address(this),
        //     uint256 value,
        //     // abi.encodeWithSelector(bytes4, arg)
        //     abi.encodeWithSelector(executorGasslessRegistry, msg.sender);
        //     0
        //     // uint256 txGas
        // )
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function iWantToSponserGasForMultipleWallets(address[] calldata wallets) external payable {
        uint256 requestedAmount = _getRequestedAmount(wallets) / getLatestETHUSDPrice();

        if (msg.value <= requestedAmount) {
            revert NotEnoughFunds(requestedAmount, msg.value);
        }

        /// TODO what is the max size of address[] calldata?
        /// convert to smaller uint
        uint256 alreadySponsored = 0;
        uint256 alreadyRegistered = 0;

        for (uint256 i = 0; i < wallets.length; i++) {
            if (_isWalletAlreadySponsored(wallets[i])) {
                alreadySponsored++;
                continue;
            }

            if (_isWalletRegistered(wallets[i])) {
                alreadyRegistered++;
                continue;
            }

            sponsoredWallets[wallets[i]] = true;
        }

        // TODO
        // split msg.value into what the executor is owed and what can be refunded.
        // Take an extra fee to back the exector --- is this dangerous?
        uint256 walletsSkipped = alreadySponsored + alreadyRegistered;

        // (publicGoodsRegistrationFee - walletsSkippedFee) * walletsSkipped

        uint256 sponsoredCount = wallets.length - walletsSkipped;
        sponsoredWalletCount += sponsoredCount;

        emit WalletsSponsoredEvent(msg.sender, wallets.length, alreadyRegistered, alreadySponsored, sponsoredCount);
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function iWantToSponserGasForAFriendsWallet(address wallet) external payable {
        if (msg.value <= (publicGoodsRegistrationFee * 1e18) / getLatestETHUSDPrice()) {
            revert NotEnoughFunds(publicGoodsRegistrationFee, msg.value);
        }

        if (_isWalletAlreadySponsored(wallet)) {
            revert UserAlreadySponsored(wallet);
        }

        if (_isWalletRegistered(wallet)) {
            revert UserAlreadyRegistered(wallet);
        }

        sponsoredWallets[wallet] = true;
        sponsoredWalletCount++;

        emit WalletsSponsoredEvent(msg.sender, 1, 0, 0, 1);
    }

    //  External functions that are view
    //  External functions that are pure
    //
    //  Public functions
    //  Public functions that are view
    function isWalletRegistered(address wallet) public view returns (bool) {
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
    function _getRequestedAmount(address[] memory wallets) private pure returns (uint256) {
        // return ((publicGoodsRegistrationFee * 1e18) * wallets.length) / getLatestETHUSDPrice())
        return publicGoodsRegistrationFee * wallets.length;
    }

    // External functions that are view
    function _isWalletAlreadySponsored(address wallet) private view returns (bool) {
        return sponsoredWallets[wallet];
    }

    function _isWalletRegistered(address wallet) private view returns (bool) {
        return registeredWallets[wallet] != 0 && registeredWallets[wallet] < block.timestamp;
    }

    // ...

    // External functions that are pure
    // ...

    // Public functions

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function getLatestETHUSDPrice() internal returns (uint256) {
        return uint256(priceConsumer.getLatestETHUSDPrice()) * 1e18;
    }

    // function CROSS_CHAIN_SEARCH_FEE() internal onlyOwner {}

    // Private functions
    // function balanceMinium() private onlyOwner {}
    // function balanceThreshold() private onlyOwner {}
}
