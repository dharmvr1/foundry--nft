// SPDX-License-Identifier:MIT
pragma solidity ^0.8.26;
import {Script} from "forge-std/Script.sol";
import {BasicNFT} from "../src/BasicNft.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script {
    string public constant PUG =
         "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNFT",
            block.chainid
        );
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address _mostRecentDeploy) public {
        vm.startBroadcast();
        BasicNFT(_mostRecentDeploy).minNft(PUG);
        vm.stopBroadcast();
    }
}
