// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;


contract B {
  bytes32 public salt;
  struct Info {
    string name;
  }

  mapping (uint => Info) infos;

  constructor(string memory _name, bytes32 _salt) payable {
   Info storage info = infos[0];
   info.name = _name;
   salt =_salt;
  }

  function getInfo() public view returns(string memory _name) {
    return infos[0].name;
  }
}
