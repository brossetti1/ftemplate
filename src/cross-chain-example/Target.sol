// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.14;

import {IExecutor} from "@nxtp/core/connext/interfaces/IExecutor.sol";
import {IConnextHandler} from "@nxtp/core/connext/interfaces/IConnextHandler.sol";

/**
 * @title Target
 * @notice A contrived example target contract.
 */
contract Target {
    event UpdateCompleted(address sender, uint256 newValue, bool permissioned);

    uint256 public value;

    // The address of Source.sol
    address public originContract;

    // Goerli (chainId: 5, domainId: 3331)
    // Rinkeby (chainId: 4, domainId: 1111)
    // The origin Domain ID
    uint32 public originDomain;

    // The address of the Connext Executor contract
    IExecutor public executor;

    // A modifier for permissioned function calls.
    // Note: This is an important security consideration. If your target
    //       contract function is meant to be permissioned, it must check
    //       that the originating call is from the correct domain and contract.
    //       Also, check that the msg.sender is the Connext Executor address.
    modifier onlyExecutor() {
        require(
            IExecutor(msg.sender).originSender() == originContract &&
                IExecutor(msg.sender).origin() == originDomain &&
                msg.sender == address(executor),
            "Expected origin contract on origin domain called by Executor"
        );
        _;
    }

    constructor(
        address _originContract,
        uint32 _originDomain,
        IConnextHandler _connext
    ) {
        originContract = _originContract;
        originDomain = _originDomain;
        executor = _connext.executor();
    }

    // Unpermissioned function
    function updateValueUnpermissioned(uint256 newValue) external returns (uint256) {
        value = newValue;

        emit UpdateCompleted(msg.sender, newValue, false);
        return newValue;
    }

    // Permissioned function
    function updateValuePermissioned(uint256 newValue) external onlyExecutor returns (uint256) {
        value = newValue;

        emit UpdateCompleted(msg.sender, newValue, true);
        return newValue;
    }
}
