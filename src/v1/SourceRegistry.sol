pragma solidity ^0.8.14;

import {IConnextHandler} from "@nxtp/core/connext/interfaces/IConnextHandler.sol";
import {ICallback} from "@nxtp/core/promise/interfaces/ICallback.sol";
import {CallParams, XCallArgs} from "@nxtp/core/connext/libraries/LibConnextStorage.sol";

import {PriceFeedConsumer} from "@helpers/PriceConsumerV3.sol";

/**
 * @title Source
 * @notice Example contract for cross-domain calls (xcalls).
 */
contract SourceRegistry is ICallback {
    error NotEnoughFunds(uint256 requested, uint256 received);
    error UserAlreadyRegistered(address wallet);
    event UpdateInitiated(address to, uint256 newValue, bool permissioned);
    event CallbackCalled(bytes32 transferId, bool success, address wallet);

    mapping(address => bool) public walletRegisterationAttempt;
    mapping(address => bool) public registeredWallets;
    mapping(address => address) public trustedForwarders;

    uint32 private constant ORIGIN_DOMAIN = 3331;
    uint32 private constant DESTINATION_DOMAIN = 2221;

    address private constant OPTIMISM_ADDRESS =
        0xF5a2c39a7675795741b44D4a5CA49D46C6D81DAf;
    bytes4 private constant SELECTOR =
        bytes4(keccak256("myWalletWasStolen(address wallet)"));

    /// @notice minimum of $5 in eth to register wallet for public goods
    uint256 public publicGoodsRegistrationFee = 5 * 1e18;

    IConnextHandler public immutable connext;
    PriceFeedConsumer private priceConsumer;

    modifier validateWalletRequirements() {
        if (msg.value >= (publicGoodsRegistrationFee * 1e18) / getLatestETHUSDPrice()) {
            revert NotEnoughFunds(publicGoodsRegistrationFee, msg.value);
        }

        if (_isWalletRegistered(msg.sender)) {
            revert UserAlreadyRegistered(msg.sender);
        }

        _;
    }

    constructor(IConnextHandler _connext, address _priceFeed) {
        connext = _connext;
        priceConsumer = PriceFeedConsumer(_priceFeed);
    }

    /**
     * Cross-domain update of a value on a target contract.
     * @dev Initiates the Connext bridging flow with calldata to be used on the target contract.
     */
    function myWalletWasStolen(
        address asset,
        uint256 newValue,
        bool permissioned
    ) external payable validateWalletRequirements {
        bytes memory callData = abi.encodeWithSelector(SELECTOR, msg.sender);

        CallParams memory callParams = CallParams({
            to: OPTIMISM_ADDRESS,
            callData: callData,
            originDomain: ORIGIN_DOMAIN, // nomad domain id
            destinationDomain: DESTINATION_DOMAIN, // nomad domain id
            recovery: msg.sender, // fallback address to send funds to if execution fails on destination side
            callback: address(this), // this contract implements the callback
            callbackFee: 0, // fee paid to relayers; relayers don't take any fees on testnet
            forceSlow: false, // option to force Nomad slow path (~30 mins) instead of paying 0.05% fee
            receiveLocal: true // option to receive the local Nomad-flavored asset instead of the adopted asset
        });

        XCallArgs memory xcallArgs = XCallArgs({
            params: callParams,
            transactingAssetId: asset,
            amount: 0, // no amount sent with this calldata-only xcall
            relayerFee: 0 // fee paid to relayers; relayers don't take any fees on testnet
        });

        connext.xcall(xcallArgs);

        emit UpdateInitiated(OPTIMISM_ADDRESS, newValue, permissioned);
    }

    /**
     * Callback function required for contracts implementing the ICallback interface.
     * @dev This function is called to handle return data from the destination domain.
     */
    function callback(
        bytes32 transferId,
        bool success,
        bytes memory data
    ) external {
        address wallet = abi.decode(data, (address));

        if (success) {
            registeredWallets[wallet] = true;
        }

        emit CallbackCalled(transferId, success, wallet);
    }

    function getLatestETHUSDPrice() internal view returns (uint256) {
        return uint256(priceConsumer.getLatestPrice()) * 1e18;
    }

    function _isWalletRegistered(address wallet) private view returns (bool) {
        return registeredWallets[wallet];
    }
}
