// SPDX-License-Identifier:MIT
pragma solidity ^0.8.26;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";
import {BasicNFT} from "../src/BasicNft.sol";

contract TestBasicNft is Test {
    DeployBasicNft public deployer;
    BasicNFT public basicNft;
    address public USER = makeAddr("user");
    string public constant DEFAULT_NAME = "Dogie";
    string public constant PUG =
         "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameCorrect() public view {
        string memory name = basicNft.name();
        // assert not directly work on string but assertEq did
        // because string memory array of bytes

        assert(
            keccak256(abi.encodePacked(name)) ==
                keccak256(abi.encodePacked(DEFAULT_NAME))
        );
    }

    function testCanMintAndHaveBalance() public {
        vm.prank(USER);

        basicNft.minNft(PUG);
        assert(basicNft.balanceOf(USER) == 1);

        assert(
            keccak256(abi.encode(PUG)) ==
                keccak256(abi.encode(basicNft.tokenURI(0)))
        );
    }
}
