// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Protocol {
    mapping(address => address[]) private s_ownerToContracts; //maps an owner to the contracts they have created.
    mapping(address => ContractDetail) private s_contractToDetail; //maps a contract to its details.

    enum ContractType {
        erc2o,
        erc721,
        erc1155,
        governance,
        custom
    }

    struct ContractDetail {
        address _creator;
        string _name;
        bytes32 _abi;
        ContractType _type;
        bytes32 _sourceCode;
        uint256 _createdAt;
    }
}
