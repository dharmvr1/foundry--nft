// SPDX-License-Identifier:MIT
pragma solidity ^0.8.26;
import {Script} from  "forge-std/Script.sol";
import {BasicNFT} from "../src/BasicNft.sol";
contract DeployBasicNft is Script {
    BasicNFT public basicNft ;
    function run() external returns(BasicNFT) {


        vm.startBroadcast();
        basicNft= new BasicNFT();
        vm.stopBroadcast();

        return basicNft;
    }

}