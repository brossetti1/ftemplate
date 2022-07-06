// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.14;

interface IEIP2771 {
    function isTrustedForwarder(address forwarder) external returns (bool);
}

/// @author FooBar
/// @title A simple FooBar example
contract EIP2771 {
    error InvalidForwarder(address);
    address immutable trustedForwarder;

    constructor(address _forwarder) {
        trustedForwarder = _forwarder;
    }

    function isTrustedForwarder(address _forwarder) internal view returns (bool) {
        return _forwarder == trustedForwarder;
    }

    function _msgSender() internal view returns (address payable signer) {
        // TODO check if payable msg.sender is correct
        signer = payable(msg.sender);
        if (msg.data.length >= 20 && isTrustedForwarder(signer)) {
            assembly {
                signer := shr(96, calldataload(sub(calldatasize(), 20)))
            }
        }
    }
}
