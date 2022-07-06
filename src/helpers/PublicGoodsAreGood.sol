// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0. 8.14;

abstract contract ENS {
    function resolver(bytes32 node) public view virtual returns (ENSResolver);
}

abstract contract ENSResolver {
    function addr(bytes32 node) public view virtual returns (address);
}

/// @author TODO
/// @title Public goods are good.
library PublicGoodsAreGood {
    address public constant ENS_RESOVLER_ADDRESS = 0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e;
    bytes32 public constant PROTOCOL_GUILD_NODE = "protocolguild.eth";
    bytes32 public constant OP_RETROACTIVE_GOODS_FUNDS = "TBD.eth";
    ENS public constant ens = ENS(0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e);

    // TODO mainnet eth resolver check...
    /// @notice Explain to an end user what this does
    /// @dev Explain to a developer any extra details
    function resolveProtcolGuildAddress() internal view returns (address) {
        ENSResolver resolver = ens.resolver(PROTOCOL_GUILD_NODE);
        return resolver.addr(PROTOCOL_GUILD_NODE);
    }

    function resolveOptimismRetroactiveFund() internal view returns (address) {
        ENSResolver resolver = ens.resolver(OP_RETROACTIVE_GOODS_FUNDS);
        return resolver.addr(OP_RETROACTIVE_GOODS_FUNDS);
    }
}
