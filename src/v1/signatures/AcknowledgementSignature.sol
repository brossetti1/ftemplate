// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.14;

import "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol";

/// @author FooBar
/// @title A simple FooBar example
abstract contract AcknowledgementSignature is EIP712 {
    error AcknowlegementExpired();
    error InvalidSigner();

    struct TrustedForwarder {
        address trustedForwarder;
        uint256 startTime;
        uint256 expirey;
    }

    bytes32 private constant ACKNOWLEDGEMENT_TYPEHASH =
        keccak256("Acknowledgement(address owner,address forwarder,uint256 nonce,uint256 deadline)");

    mapping(address => TrustedForwarder) private acknowledgementForwarders;
    mapping(address => uint256) public nonces;

    event SignatureAcknowledged(address indexed owner);

    constructor() EIP712("AcknowledgementOfRegistry", "1") {}

    function acknowledgementOfRegistry(
        address owner,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external virtual {
        // ensure signature was sent within the time limit
        if (deadline <= block.timestamp) revert AcknowlegementExpired();

        // verify signature was sent by owner
        bytes32 digest = _hashTypedDataV4(
            keccak256(abi.encode(ACKNOWLEDGEMENT_TYPEHASH, owner, msg.sender, nonces[owner]++, deadline))
        );

        address recoveredWallet = ecrecover(digest, v, r, s);
        if (recoveredWallet == address(0) && recoveredWallet != owner) revert InvalidSigner();

        // sets trusted forwarder and
        acknowledgementForwarders[owner] = TrustedForwarder({
            trustedForwarder: msg.sender,
            startTime: block.timestamp + 1 minutes,
            expirey: _getDeadline()
        });

        emit SignatureAcknowledged(owner);
    }

    // function generateHashStruct(address forwarder) external view returns (bytes32 hashStruct, uint256 deadline) {
    //     uint256 deadline = _getDeadline();
    //     bytes32 hashStruct = keccak256(abi.encode(ACKNOWLEDGEMENT_TYPEHASH, msg.sender, forwarder, deadline));
    // }

    function getDeadline() external view returns (uint256) {
        return acknowledgementForwarders[msg.sender].expirey;
    }

    function getTrustedForwarder() public view returns (address) {
        return acknowledgementForwarders[msg.sender].trustedForwarder;
    }

    function getDeadline(address owner) external view returns (uint256) {
        return acknowledgementForwarders[owner].expirey;
    }

    function getTrustedForwarder(address owner) public view returns (address) {
        return acknowledgementForwarders[owner].trustedForwarder;
    }

    function _getDeadline() internal view returns (uint256) {
        return block.timestamp + 4 minutes;
    }

    function _getStartTime() internal view returns (uint256) {
        return block.timestamp + 1 minutes;
    }
}
