//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";
import {Base64} from "./libraries/Base64.sol";

contract InsecurePasswordManager is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><rect width='100%' height='100%' rx='5' ry='5' stroke-width='3' stroke='orange'/><text x='50%' y='50%' dominant-baseline='middle' text-anchor='middle' fill='#fff' font-family='sans-serif' font-size='14'>";

    string[] firstWords = ["Acrobatic", "Brave", "Bumbling", "Grim", "Lanky", "Lazy", "Nocturnal", "Evil", "Quality"];
    string[] secondWords = ["Llama", "Alpaca", "Stoat", "Skunk", "Badger", "Ferret", "Panda", "Toucan", "Koala", "Kangaroo"];
    string[] thirdWords = ["Clamp", "Knife", "Bottle", "Banana", "Cork", "Pencil", "Potato", "Costume", "Trunk", "Suit"];

    constructor() ERC721 ("InsecurePasswordManager", "INSCRPW") {
        console.log("This is the Insecure Password Manager NFT contract.");
    }

    function pickRandomFirstWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
        rand = rand % firstWords.length;
        return firstWords[rand];
    }

    function pickRandomSecondWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
        rand = rand % secondWords.length;
        return secondWords[rand];
    }

    function pickRandomThirdWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));
        rand = rand % thirdWords.length;
        return thirdWords[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function generatePassword() public {
        uint256 newItemId = _tokenIds.current();

        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);
        string memory password = string(abi.encodePacked(first, "-", second, "-", third));

        string memory passwordSvg = string(abi.encodePacked(baseSvg, password, "</text></svg>"));

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "', password, '", "description": "Insecure password #', Strings.toString(newItemId), '", "image": "data:image/svg+xml;base64,',
                        Base64.encode(bytes(passwordSvg)),
                        '"}'
                    )
                )
            )
        );

        string memory passwordTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log(passwordTokenUri);

        _safeMint(msg.sender, newItemId);

        _setTokenURI(newItemId, passwordTokenUri);

        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

        _tokenIds.increment();
    }
}
