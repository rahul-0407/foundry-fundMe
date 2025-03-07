//SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";


contract DeployFundMe is Script{
    

    function run() external returns(FundMe){
        HelperConfig helperConfig = new HelperConfig();
        address ethUsdPrice = helperConfig.activeNetworkConfig();

        vm.startBroadcast();
        FundMe fundMe =  new FundMe(ethUsdPrice);
        vm.stopBroadcast();
        return fundMe;
    }
}