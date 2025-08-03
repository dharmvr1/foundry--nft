// SPDX-License-Identifier:MIT
pragma solidity ^0.8.26;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    error MoodNft__cantFlipMoodIfNotOwner();

    uint256 private s_tokenCounter;
    string private s_SadSvgImageUri;
    string private s_HappySvgImageUri;
    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) s_tokenIdToMood;

    constructor(
        string memory sadSvgImageUri,
        string memory happySvgImageUri
    ) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        s_HappySvgImageUri = happySvgImageUri;
        s_SadSvgImageUri = sadSvgImageUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter += 1;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function flipMood(uint256 tokenId) public {
        if (_ownerOf(tokenId) != msg.sender) {
            revert MoodNft__cantFlipMoodIfNotOwner();
        }
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageUri;
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageUri = s_HappySvgImageUri;
        } else {
            imageUri = s_SadSvgImageUri;
        }

        string memory tokenMetaData = string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    (
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(),
                                '","description":" An nft that refelcts owner mood","attributes":[{"trait_type":"moodiness","value":100}],"image":"',
                                imageUri,
                                '"}'
                            )
                        )
                    )
                )
            )
        );
        return tokenMetaData;
    }

    function haveMood(uint256 tokenId) public view returns (Mood) {
        return s_tokenIdToMood[tokenId];
    }

    function imageUriToTokenUri(
        string memory imageUri
    ) public view returns (string memory) {
        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        (
                            bytes(
                                abi.encodePacked(
                                    '{"name":"',
                                    name(),
                                    '","description":" An nft that refelcts owner mood","attributes":[{"trait_type":"moodiness","value":100}],"image":"',
                                    imageUri,
                                    '"}'
                                )
                            )
                        )
                    )
                )
            );
    }
}
