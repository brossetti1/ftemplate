pragma solidity ^0.8.14;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "@libraries/StaticTranslations.sol";

contract StolenWalletNFT is ERC721, Ownable {
    using StaticTranslations for string;
    error NonTransferrable();
    error UnableToBurn();

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("StolenWalletRegistry", "BURN") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://stolenwalletregistry.xyz/";
    }

    event Minted(address, uint256);

    function safeMint() public payable {
        uint256 tokenId = _tokenIdCounter.current();

        _tokenIdCounter.increment();

        _safeMint(msg.sender, tokenId);

        emit Minted(msg.sender, tokenId);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721) {
        if (from == address(0)) revert NonTransferrable();
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal pure override(ERC721) {
        if (true == false) revert UnableToBurn();
    }

    /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view override returns (string memory svg) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory name = string(abi.encodePacked(tokenId, "This wallet was signed as Stolen: ", ownerOf(tokenId)));
        string memory description = "This wallet was signed as Stolen";
        string memory image = generateBase64Image(tokenId);

        svg = string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                            name,
                            '", "description":"',
                            description,
                            '", "image": "',
                            "data:image/svg+xml;base64,",
                            image,
                            '"}'
                        )
                    )
                )
            )
        );
    }

    function generateBase64Image(uint256 tokenId) private pure returns (string memory svg) {
        svg = Base64.encode(bytes(generateImage(tokenId)));
    }

    function generateImage(uint256 tokenId) internal pure returns (string memory svg) {
        svg = string(
            abi.encodePacked(
                '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">',
                "<defs>",
                '<text xml:lang="en-US" id="a">This wallet has been signed as stolen.</text>',
                "</defs>",
                '<rect width="100%" height="100%" />',
                // _generateSVGBorderText(),
                "TokenId: ",
                tokenId,
                '<switch fill="#fff" stroke="#000" font-family="Helvetica" font-size="18" font-weight="bold">',
                _addTranslations(),
                "</svg>"
            )
        );
    }

    function _addTranslations() private pure returns (string memory svg) {
        bytes memory firstTranslations;
        bytes memory secondTranslations;
        bytes memory thirdTranslations;
        bytes memory fourthTranslations;
        bytes memory fifthTranslations;
        bytes memory sixthTranslations;

        // avoiding stack too deep errors ¯\_(ツ)_/¯
        {
            firstTranslations = abi.encodePacked(
                _addTranslation(StaticTranslations.french()),
                _addTranslation(StaticTranslations.french_fr()),
                _addTranslation(StaticTranslations.chinese()),
                _addTranslation(StaticTranslations.chinese_hk()),
                _addTranslation(StaticTranslations.chinese_cn()),
                _addTranslation(StaticTranslations.chinese_tw()),
                _addTranslation(StaticTranslations.catalan()),
                _addTranslation(StaticTranslations.korean()),
                _addTranslation(StaticTranslations.czech())
            );
        }

        {
            secondTranslations = abi.encodePacked(
                _addTranslation(StaticTranslations.danish()),
                _addTranslation(StaticTranslations.dutch()),
                _addTranslation(StaticTranslations.english()),
                _addTranslation(StaticTranslations.english_ca()),
                _addTranslation(StaticTranslations.english_gb()),
                _addTranslation(StaticTranslations.english_us()),
                _addTranslation(StaticTranslations.finnish()),
                _addTranslation(StaticTranslations.greek()),
                _addTranslation(StaticTranslations.hebrew())
            );
        }

        {
            thirdTranslations = abi.encodePacked(
                _addTranslation(StaticTranslations.hindi()),
                _addTranslation(StaticTranslations.icelandic()),
                _addTranslation(StaticTranslations.italian()),
                _addTranslation(StaticTranslations.japanese()),
                _addTranslation(StaticTranslations.korean_kr()),
                _addTranslation(StaticTranslations.latin()),
                _addTranslation(StaticTranslations.latvian()),
                _addTranslation(StaticTranslations.lithuanian()),
                _addTranslation(StaticTranslations.luxembourgish())
            );
        }

        {
            fourthTranslations = abi.encodePacked(
                _addTranslation(StaticTranslations.norwegian()),
                _addTranslation(StaticTranslations.persian()),
                _addTranslation(StaticTranslations.portuguese()),
                _addTranslation(StaticTranslations.portuguese_br()),
                _addTranslation(StaticTranslations.romanian()),
                _addTranslation(StaticTranslations.russian()),
                _addTranslation(StaticTranslations.serbian()),
                _addTranslation(StaticTranslations.slovak()),
                _addTranslation(StaticTranslations.slovenian())
            );
        }

        {
            fifthTranslations = abi.encodePacked(
                _addTranslation(StaticTranslations.spanish()),
                _addTranslation(StaticTranslations.spanish_mx()),
                _addTranslation(StaticTranslations.spanish_es()),
                _addTranslation(StaticTranslations.swedish()),
                _addTranslation(StaticTranslations.thai()),
                _addTranslation(StaticTranslations.ukrainian()),
                _addTranslation(StaticTranslations.albanian()),
                _addTranslation(StaticTranslations.arabic()),
                _addTranslation(StaticTranslations.german())
            );
        }

        {
            sixthTranslations = abi.encodePacked(
                _addTranslation(StaticTranslations.basque()),
                _addTranslation(StaticTranslations.bulgarian()),
                _addTranslation(StaticTranslations.german()),
                _addTranslation(StaticTranslations.german_de()),
                _addTranslation(StaticTranslations.indonesian()),
                _addTranslation(StaticTranslations.belarusian()),
                _addTranslation(StaticTranslations.bengali()),
                _addTranslation(StaticTranslations.azerbaijani()),
                _addTranslation(StaticTranslations.armenian())
            );
        }

        svg = string(
            abi.encodePacked(
                firstTranslations,
                secondTranslations,
                thirdTranslations,
                fourthTranslations,
                fifthTranslations,
                sixthTranslations
            )
        );
    }

    function _addTranslation(LanguageTranslation memory translation) private pure returns (string memory svg) {
        svg = string(
            abi.encodePacked(
                '<g systemLanguage="',
                translation.languageCode,
                ">",
                '<text xml:lang="',
                translation.languageCode,
                '" x="20" y="255">',
                translation.sentence,
                "</text>",
                '<use x="20" y="275" href="#a" />',
                '<text xml:lang="',
                translation.languageCode,
                '" x="20" y="255">',
                translation.language,
                "</text>",
                "--&gt;",
                "</g>"
            )
        );
    }

    // generateSVGBorderText from uniswap v3
    // used for displaying the registry contract links
    // https://github.com/Uniswap/v3-periphery/blob/main/contracts/libraries/NFTSVG.sol#L161
    function _generateSVGBorderText(
        string memory quoteToken,
        string memory baseToken,
        string memory quoteTokenSymbol,
        string memory baseTokenSymbol
    ) private pure returns (string memory svg) {
        svg = string(
            abi.encodePacked(
                '<text text-rendering="optimizeSpeed">',
                '<textPath startOffset="-100%" fill="white" font-family="\'Courier New\', monospace" font-size="10px" xlink:href="#text-path-a">',
                baseToken,
                unicode" • ",
                baseTokenSymbol,
                ' <animate additive="sum" attributeName="startOffset" from="0%" to="100%" begin="0s" dur="30s" repeatCount="indefinite" />',
                '</textPath> <textPath startOffset="0%" fill="white" font-family="\'Courier New\', monospace" font-size="10px" xlink:href="#text-path-a">',
                baseToken,
                unicode" • ",
                baseTokenSymbol,
                ' <animate additive="sum" attributeName="startOffset" from="0%" to="100%" begin="0s" dur="30s" repeatCount="indefinite" /> </textPath>',
                '<textPath startOffset="50%" fill="white" font-family="\'Courier New\', monospace" font-size="10px" xlink:href="#text-path-a">',
                quoteToken,
                unicode" • ",
                quoteTokenSymbol,
                ' <animate additive="sum" attributeName="startOffset" from="0%" to="100%" begin="0s" dur="30s"',
                ' repeatCount="indefinite" /></textPath><textPath startOffset="-50%" fill="white" font-family="\'Courier New\', monospace" font-size="10px" xlink:href="#text-path-a">',
                quoteToken,
                unicode" • ",
                quoteTokenSymbol,
                ' <animate additive="sum" attributeName="startOffset" from="0%" to="100%" begin="0s" dur="30s" repeatCount="indefinite" /></textPath></text>'
            )
        );
    }
}
