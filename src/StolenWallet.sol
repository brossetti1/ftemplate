// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

import "@helpers/StaticTranslations.sol";

// check the registry contract that address is registered? --- whitelist and able to mint
// check the registry contract that address is sponsored for nft? --- whitelist and able to mint
//

interface IWalletRegisty {
    function isRegistered(address wallet) public view returns (bool);

    function isSponsored(address wallet) public view returns (bool);

    function getRegisteredWalletCount() public view returns (uint256);

    function getSponsoredWalletCount() public view returns (uint256);

    function getRegisteredWallets() public view returns (address[] memory);

    function getSponsoredWallets() public view returns (address[] memory);
}

contract StolenWalletRegistry is ERC721, Ownable, StaticTranslations {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    IWalletRegisty registry;

    constructor(address _registry) ERC721("StolenWalletRegistry", "BURN") {
        registry = IWalletRegisty(_registry);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://stolenwalletregistry.com/";
    }

    event Minted(address, uint256);

    // 1. you can burn it
    // 2. an operator issues it and can revoke it
    // 3. you cannot transfer it

    // 1. you cannot burn it
    // 2. there is no operator that can revoke it
    // 2. you cannot transfer it
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
        require(from == address(0), "Err: token is SOUL BOUND");
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721) {
        require(true == false, "Err: cannot burn the BURN token");
    }

    /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        address wallet = ownerOf(tokenId);
        string memory name = string(abi.encodePacked(tokenId, "This wallet was signed as Stolen", string(msg.sender)));
        string memory description = "This wallet was signed as Stolen";
        string memory image = generateBase64Image(tokenId);

        return
            string(
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

    function generateBase64Image(uint256 tokenId) public view returns (string memory) {
        return Base64.encode(bytes(generateImage(tokenId)));
    }

    function generateImage(uint256 tokenId) public view returns (string memory) {
        bytes memory hash = abi.encodePacked(bytes32(tokenId));
        // uint256 pIndex = toUint8(hash, 0) / 16; // 16 palettes
        // uint256 rIndex = toUint8(hash, 1) / 4; // 64 reasons

        /* this is broken into functions to avoid stack too deep errors */
        // string memory paletteSection = generatePaletteSection(tokenId, pIndex);
        // string memory skyscraper = generateSkyscrapers(hash, pIndex);

        // string memory class = "DF"; // DF for Default
        // if (certificates[tokenId].sponsored != 0x0000000000000000000000000000000000000000) {
        //     class = "DX"; // DX for deluxe
        // }

        return (
            abi.encodePacked(
                '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">',
                "<defs>",
                '<text xml:lang="en-US" id="a">This wallet has been signed as stolen.</text>',
                "</defs>",
                '<rect width="100%" height="100%" />',
                '<switch fill="#fff" stroke="#000" font-family="Helvetica" font-size="18" font-weight="bold">',
                '<g systemLanguage="en">',
                '<use x="20" y="255" href="#a" />',
                '<text xml:lang="en" x="20" y="50">English (US)</text>',
                "</g>",
                '<g systemLanguage="af">',
                '<text xml:lang="af" x="20" y="255">Hierdie beursie is as gesteel onderteken.</text>',
                '<use x="20" y="275" href="#a" />',
                '<text xml:lang="af" x="20" y="50">Afrikaans</text>',
                "--&gt;",
                "</g>",
                _addTranslation(StaticTranslations.ALBANIAN),
                _addTranslation(StaticTranslations.ARABIC),
                _addTranslation(StaticTranslations.ARMENIAN),
                _addTranslation(StaticTranslations.AZERBAIJANI),
                _addTranslation(StaticTranslations.BASQUE),
                _addTranslation(StaticTranslations.BULGARIAN),
                _addTranslation(StaticTranslations.BELARUSIAN),
                _addTranslation(StaticTranslations.BENGALI),
                _addTranslation(StaticTranslations.BOSNIAN),
                _addTranslation(StaticTranslations.BURMESE),
                _addTranslation(StaticTranslations.CATALAN),
                _addTranslation(StaticTranslations.CHINESE),
                _addTranslation(StaticTranslations.CHINESE_HK),
                _addTranslation(StaticTranslations.CHINESE_CN),
                _addTranslation(StaticTranslations.CHINESE_TW),
                _addTranslation(StaticTranslations.CORSICAN),
                _addTranslation(StaticTranslations.CROATIAN),
                _addTranslation(StaticTranslations.CZECH),
                _addTranslation(StaticTranslations.DANISH),
                _addTranslation(StaticTranslations.DUTCH),
                _addTranslation(StaticTranslations.ENGLISH),
                _addTranslation(StaticTranslations.ENGLISH_CA),
                _addTranslation(StaticTranslations.ENGLISH_GB),
                _addTranslation(StaticTranslations.ENGLISH_US),
                _addTranslation(StaticTranslations.ESPERANTO),
                _addTranslation(StaticTranslations.ESTONIAN),
                _addTranslation(StaticTranslations.FARSI),
                _addTranslation(StaticTranslations.FINNISH),
                _addTranslation(StaticTranslations.FRENCH),
                _addTranslation(StaticTranslations.FRENCH_FR),
                _addTranslation(StaticTranslations.FRISIAN),
                _addTranslation(StaticTranslations.GAELIC),
                _addTranslation(StaticTranslations.GALACIAN),
                _addTranslation(StaticTranslations.GEORGIAN),
                _addTranslation(StaticTranslations.GERMAN),
                _addTranslation(StaticTranslations.GERMAN_DE),
                _addTranslation(StaticTranslations.GREEK),
                _addTranslation(StaticTranslations.GUJURATI),
                _addTranslation(StaticTranslations.HAITIAN),
                _addTranslation(StaticTranslations.HEBREW),
                _addTranslation(StaticTranslations.HINDI),
                _addTranslation(StaticTranslations.HUNGARIAN),
                _addTranslation(StaticTranslations.ICELANDIC),
                _addTranslation(StaticTranslations.INDONESIAN),
                _addTranslation(StaticTranslations.IRISH),
                _addTranslation(StaticTranslations.ITALIAN),
                _addTranslation(StaticTranslations.JAPANESE),
                _addTranslation(StaticTranslations.KANNADA),
                _addTranslation(StaticTranslations.KAZAKH),
                _addTranslation(StaticTranslations.KHMER),
                _addTranslation(StaticTranslations.KIRGHIZ),
                _addTranslation(StaticTranslations.KOREAN),
                _addTranslation(StaticTranslations.KOREAN_KR),
                _addTranslation(StaticTranslations.LATIN),
                _addTranslation(StaticTranslations.LATVIAN),
                _addTranslation(StaticTranslations.LITHUANIAN),
                _addTranslation(StaticTranslations.LUXEMBOURGISH),
                _addTranslation(StaticTranslations.FYRO_MACEDONIAN),
                _addTranslation(StaticTranslations.MALAY),
                _addTranslation(StaticTranslations.MALAYALAM),
                _addTranslation(StaticTranslations.MALTESE),
                _addTranslation(StaticTranslations.MAORI),
                _addTranslation(StaticTranslations.MARATHI),
                _addTranslation(StaticTranslations.MOLDAVIAN),
                _addTranslation(StaticTranslations.NEPALI),
                _addTranslation(StaticTranslations.NORWEGIAN),
                _addTranslation(StaticTranslations.ORIYA),
                _addTranslation(StaticTranslations.PERSIAN),
                _addTranslation(StaticTranslations.POLISH),
                _addTranslation(StaticTranslations.PORTUGUESE),
                _addTranslation(StaticTranslations.PORTUGUESE_BR),
                _addTranslation(StaticTranslations.PUNJABI),
                _addTranslation(StaticTranslations.ROMANIAN),
                _addTranslation(StaticTranslations.RUSSIAN),
                _addTranslation(StaticTranslations.SCOTS_GAELIC),
                _addTranslation(StaticTranslations.SINDHI),
                _addTranslation(StaticTranslations.SINGHALESE),
                _addTranslation(StaticTranslations.SERBIAN),
                _addTranslation(StaticTranslations.SLOVAK),
                _addTranslation(StaticTranslations.SLOVENIAN),
                _addTranslation(StaticTranslations.SOMANI),
                _addTranslation(StaticTranslations.SPANISH),
                _addTranslation(StaticTranslations.SPANISH_MX),
                _addTranslation(StaticTranslations.SPANISH_ES),
                _addTranslation(StaticTranslations.SWAHILI),
                _addTranslation(StaticTranslations.SWEDISH),
                _addTranslation(StaticTranslations.TAMIL),
                _addTranslation(StaticTranslations.TATAR),
                _addTranslation(StaticTranslations.TELUGA),
                _addTranslation(StaticTranslations.THAI),
                _addTranslation(StaticTranslations.TURKISH),
                _addTranslation(StaticTranslations.TURKMEN),
                _addTranslation(StaticTranslations.UKRAINIAN),
                _addTranslation(StaticTranslations.URDU),
                _addTranslation(StaticTranslations.VIETNAMESE),
                _addTranslation(StaticTranslations.WELSH),
                _addTranslation(StaticTranslations.XHOSA),
                _addTranslation(StaticTranslations.YIDDISH),
                _addTranslation(StaticTranslations.ZULU),
                "</switch>",
                "</svg>"
            )
        );
    }

    // '<g systemLanguage="ji">',
    // '<text xml:lang="ji" x="20" y="255">די בייַטל איז געחתמעט ווי סטאָלען.</text>',
    // '<use x="20" y="275" href="#a" />',
    // '<text xml:lang="ji" x="20" y="50">Yiddish</text>',
    // "--&gt;",
    // "</g>",
    //     languageCode
    // translation
    // language
    function _addTranslation(LanguageTranslation memory translation) internal returns (string memory) {
        return (
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
    function generateSVGBorderText(
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
