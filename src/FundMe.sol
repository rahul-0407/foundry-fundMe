// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {PriceConverter} from "./PriceConverter.sol";
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

error FundMe_notOwner();

contract FundMe{

    using PriceConverter for uint256;

    uint256 public  constant MINIMUM_USD = 5e18;
    AggregatorV3Interface private s_priceFeed;

    address[] public s_funders;

    mapping(address funder => uint256 amountFunded) private s_addressToAmountFunded;

    address private immutable i_owner;

    constructor(address priceFeed){
        i_owner = msg.sender;
        s_priceFeed=AggregatorV3Interface(priceFeed);
    }

    function fund() public payable{
        // Allow tusers to send $
        // Have a min $ sent
        // 1/How do we send eteh to this contract
        require(msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD, "didn't send enough"); //1e18 = 1ETH
        s_funders.push(msg.sender);
        s_addressToAmountFunded[msg.sender] += msg.value;
    }

    function cheaperWithdrawFunction() public onlyOwner{
        uint256 fundersLength = s_funders.length;

        for(uint256 funderIndex=0;funderIndex < fundersLength; funderIndex++){
            address funder = s_funders[funderIndex];
            s_addressToAmountFunded[funder] = 0;
        }

        s_funders = new address[](0);

        (bool callSuccess, ) = payable (msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
    }

    function withdraw() public onlyOwner {


        for(uint256 funderIndex=0;funderIndex < s_funders.length; funderIndex++){
            address funder = s_funders[funderIndex];
            s_addressToAmountFunded[funder] = 0;
        }

        //reset the array
        s_funders = new address[](0);

        // actully withdraw the funds


        //transfer
        // msg.sender = address
        // payable(msg.sender) = payable address
        // payable (msg.sender).transfer(address(this).balance);

        // send
        // bool sendSuccess = payable (msg.sender).send(address(this).balance);
        // require(sendSuccess, "send failled");

        // call
        (bool callSuccess, ) = payable (msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");



    }

    modifier onlyOwner() {
        // require(msg.sender == owner, "Must be owner");
        if(msg.sender != i_owner) {revert FundMe_notOwner();}
        _;
    }

    function getVersion() public view returns(uint256) {
        return s_priceFeed.version();
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

    //view/pure functions 

    function getOwner() external view returns (address) {
        return i_owner;
    }

    function getAddressToAmountFunded(address fundingAddress) external view returns(uint256){
        return s_addressToAmountFunded[fundingAddress];

    }

    function getFunder(uint256 index) external view returns(address){
        return s_funders[index];
    }



}
