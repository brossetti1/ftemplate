pragma solidity 0.8.14;

import "./helpers/PriceConsumerV3.sol";
import "./helpers/PublicGoodsAreGood.sol";

interface IStolenWalletRegistry {
    function myWalletWasStolen() external returns (bool);

    function _myWalletWasStolen(address wallet) external returns (bool);
}

/// @title A registry for reporting stolen wallets
/// @author brianrossetti.eth
/// @notice This contract is used as a Registry for signaling that a wallet address has been compromised.
/// @notice funds from fees routed from other chains go to the address registered at protocolguild.eth
/// @notice funds from fees on Optimism go to the Optimism retroactive public goods fund.
/// @custom:experimental This is an experimental unaudited contract.
contract StolenWalletRegistry {
    PriceFeedConsumer private priceConsumer;

    uint256 public publicGoodsRegistrationFee = 5 * 1e18;
    uint256 public registeredWalletCount = 0;

    mapping(address => uint256) public registeredWallets;

    error NotEnoughFunds(uint256 requested, uint256 received);
    error UserAlreadyRegistered(address wallet);

    event RegisteredAddressEvent(address registeredWallet, bool gasless);

    constructor(address _priceFeed) {
        priceConsumer = PriceFeedConsumer(_priceFeed);
    }

    modifier checkFundsForPublicGoods() {
        if (msg.value < (publicGoodsRegistrationFee * 1e18) / getLatestETHUSDPrice()) {
            revert NotEnoughFunds(publicGoodsRegistrationFee, msg.value);
        }

        if (_isWalletRegistered()) {
            revert UserAlreadyRegistered(msg.sender);
        }

        _;
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function myWalletWasStolen() external payable checkFundsForPublicGoods {
        registeredWallets[msg.sender] = block.timestamp;
        registeredWalletCount++;

        emit RegisteredAddressEvent(msg.sender, false);

        fundOptimismRetroactivePublicGoods();
    }

    function isWalletRegistered(address wallet) public view returns (bool) {
        return registeredWallets[wallet] != 0 && registeredWallets[wallet] < block.timestamp;
    }

    function whenWalletWasRegisted(address wallet) public view returns (uint256) {
        return registeredWallets[wallet];
    }

    function _isWalletRegistered() private view returns (bool) {
        return registeredWallets[msg.sender] != 0 && registeredWallets[msg.sender] < block.timestamp;
    }

    function fundProtocolGuild() internal {
        (bool sent, ) = PublicGoodsAreGood.resolveProtcolGuildAddress().call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }

    function fundOptimismRetroactivePublicGoods() internal {
        (bool sent, ) = PublicGoodsAreGood.resolveOptimismRetroactiveAddress().call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }

    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function getLatestETHUSDPrice() internal view returns (uint256) {
        return uint256(priceConsumer.getLatestPrice()) * 1e18;
    }
}
