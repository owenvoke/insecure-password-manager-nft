//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract InsecurePasswordManager is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721 ("InsecurePasswordManager", "INSCRPW") {
        console.log("This is the Insecure Password Manager NFT contract.");
    }

    function generatePassword() public {
        uint256 newItemId = _tokenIds.current();

        _safeMint(msg.sender, newItemId);

        _setTokenURI(newItemId, "data:application/json;base64,ewogICAgIm5hbWUiOiAiSW5zZWN1cmUgUGFzc3dvcmQgTWFuYWdlciIsCiAgICAiZGVzY3JpcHRpb24iOiAiQWxsIHlvdXIgaW5zZWN1cmUgcGFzc3dvcmRzIHN0b3JlZCAnc2VjdXJlbHknIG9uIHRoZSBibG9ja2NoYWluLiIsCiAgICAiaW1hZ2UiOiAiZGF0YTppbWFnZS9zdmcreG1sO2Jhc2U2NCxQSE4yWnlCNGJXeHVjejBpYUhSMGNEb3ZMM2QzZHk1M015NXZjbWN2TWpBd01DOXpkbWNpSUhCeVpYTmxjblpsUVhOd1pXTjBVbUYwYVc4OUluaE5hVzVaVFdsdUlHMWxaWFFpSUhacFpYZENiM2c5SWpBZ01DQXpOVEFnTXpVd0lqNDhjbVZqZENCM2FXUjBhRDBpTVRBd0pTSWdhR1ZwWjJoMFBTSXhNREFsSWlCeWVEMGlOU0lnY25rOUlqVWlJSE4wY205clpTMTNhV1IwYUQwaU15SWdjM1J5YjJ0bFBTSnZjbUZ1WjJVaUx6NDhkR1Y0ZENCNFBTSTFNQ1VpSUhrOUlqVXdKU0lnWkc5dGFXNWhiblF0WW1GelpXeHBibVU5SW0xcFpHUnNaU0lnZEdWNGRDMWhibU5vYjNJOUltMXBaR1JzWlNJZ1ptbHNiRDBpSTJabVppSWdabTl1ZEMxbVlXMXBiSGs5SW5OaGJuTXRjMlZ5YVdZaUlHWnZiblF0YzJsNlpUMGlNVFFpUGtsdWMyVmpkWEpsSUZCaGMzTjNiM0prSUUxaGJtRm5aWEk4TDNSbGVIUStQQzl6ZG1jKyIKfQo=");
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

        _tokenIds.increment();
    }
}
