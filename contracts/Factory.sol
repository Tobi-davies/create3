// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import {Create3} from "./libraries/create3.sol";
import "./B.sol";


contract FactoryB {

//struct to be passed into child contract
    struct Info {
    string name;
  }

//Amount to be deployed with child contract
  uint256 eth = 1 wei;

      function deployB(string memory keyword) external payable returns(address contactAddr)  {
       Info memory info = Info("tay");

//generate salt using keyword of your choice
        bytes32 salt =  keccak256(bytes(keyword));
        //create returns an address of the child contract
        contactAddr = Create3.create3(
          salt,
          abi.encodePacked(
            type(B).creationCode,
            abi.encode(
            info, salt
            )
          ), 
          eth
        );
      }

    function isChildContract(address _b) view public returns(bool isChild) {
        bytes32 _salt = B(_b).salt(); 
        address mine = Create3.addressOf(_salt);

        if(mine == _b) {
            isChild = true;
        }
    }


      function fetchAddress( string memory keyword) view external returns (address addr) {
        bytes32 _salt =  keccak256(bytes(keyword));
         addr = Create3.addressOf(_salt);
      }

      function getDetails(address addr) view external returns(string memory _name) {
        _name = B(addr).getInfo();
      }
}

