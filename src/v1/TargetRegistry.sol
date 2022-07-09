pragma solidity ^0.8.14;

import {IExecutor} from "@nxtp/core/connext/interfaces/IExecutor.sol";
import {IConnextHandler} from "@nxtp/core/connext/interfaces/IConnextHandler.sol";

import {IStolenWalletRegistry} from "./StolenWalletRegistry.sol";
import {PriceFeedConsumer} from "@helpers/PriceConsumerV3.sol";

/**
 * @title Target
 * @notice A contrived example target contract.
 */
contract TargetRegistry {
    event UpdateCompleted(address sender, address wallet);

    error NotEnoughFunds(uint256 requested, uint256 received);
    error UserAlreadyRegistered(address wallet);

    uint256 public value;

    address public originContract;

    uint32 public originDomain;

    IExecutor public executor;

    IStolenWalletRegistry public stolenWalletRegistry =
        IStolenWalletRegistry(0xF5a2c39a7675795741b44D4a5CA49D46C6D81DAf);
    PriceFeedConsumer private priceConsumer;

    /// @notice minimum of $5 in eth to register wallet for public goods
    uint256 public publicGoodsRegistrationFee = 5 * 1e18;

    modifier onlyExecutor() {
        require(
            IExecutor(msg.sender).originSender() == originContract &&
                IExecutor(msg.sender).origin() == originDomain &&
                msg.sender == address(executor),
            "Expected origin contract on origin domain called by Executor"
        );
        _;
    }

    modifier validateWalletRequirements(address wallet) {
        if (msg.value < (publicGoodsRegistrationFee * 1e18) / getLatestETHUSDPrice()) {
            revert NotEnoughFunds(publicGoodsRegistrationFee, msg.value);
        }

        if (_isWalletRegistered(wallet)) {
            revert UserAlreadyRegistered(wallet);
        }

        _;
    }

    constructor(
        address _originContract,
        uint32 _originDomain,
        IConnextHandler _connext,
        address _priceFeed
    ) {
        originContract = _originContract;
        originDomain = _originDomain;
        executor = _connext.executor();
        priceConsumer = PriceFeedConsumer(_priceFeed);
    }

    function myWalletWasStolen(address wallet)
        external
        payable
        onlyExecutor
        validateWalletRequirements(wallet)
    {
        stolenWalletRegistry._myWalletWasStolen(wallet);
        emit UpdateCompleted(msg.sender, wallet);
    }

    function _isWalletRegistered(address wallet) private view returns (bool) {}

    function getLatestETHUSDPrice() internal view returns (uint256) {
        return uint256(priceConsumer.getLatestPrice()) * 1e18;
    }
}
