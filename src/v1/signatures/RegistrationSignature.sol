pragma solidity 0.8.14;

import "@openzeppelin/contracts/utils/cryptography/draft-EIP712.sol";

/// @author FooBar
/// @title A simple FooBar example
abstract contract RegistrationSignature is EIP712 {
    error SponsorshipExpired();
    error InvalidSigner();
    error InvalidForwarder();
    error SignatureExpired();
    error ForwarderExpired();

    struct TrustedForwarder {
        address trustedForwarder;
        uint256 expirey;
    }

    bytes32 private constant SPONSORED_REGISTRATION_TYPEHASH =
        keccak256("SponsoredRegistration(address owner,address forwarder,uint256 nonce,uint256 deadline)");

    mapping(address => TrustedForwarder) private trustedForwarders;
    mapping(address => uint256) public nonces;

    event SponsoredReigistrationEvent(address indexed owner);
    event RegistrationEvent(address indexed owner);

    constructor() EIP712("SponsoredRegistration", "1") {}

    function walletRegistration(
        address owner,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external virtual {
        if (deadline <= block.timestamp) revert SignatureExpired();

        bytes32 digest = _hashTypedDataV4(
            keccak256(abi.encode(SPONSORED_REGISTRATION_TYPEHASH, owner, msg.sender, nonces[owner]++, deadline))
        );

        address recoveredWallet = ecrecover(digest, v, r, s);
        if (recoveredWallet == address(0) && recoveredWallet != owner) revert InvalidSigner();

        TrustedForwarder storage forwarder = trustedForwarders[owner];

        if (forwarder.trustedForwarder != msg.sender) revert InvalidForwarder();

        if (forwarder.expirey < block.timestamp) {
            delete trustedForwarders[owner];
            revert ForwarderExpired();
        }

        delete trustedForwarders[owner];

        if (owner == msg.sender) {
            emit RegistrationEvent(owner);
        } else {
            emit SponsoredReigistrationEvent(owner);
        }
    }

    function getDeadline() external view returns (uint256) {
        return trustedForwarders[msg.sender].expirey;
    }

    function _getTrustedForwarderAddress() public view returns (address) {
        return trustedForwarders[msg.sender].trustedForwarder;
    }

    function getDeadline(address owner) external view returns (uint256) {
        return trustedForwarders[owner].expirey;
    }

    function getTrustedForwarder(address owner) public view returns (address) {
        return trustedForwarders[owner].trustedForwarder;
    }
}
