// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

error Protocol__AddressAlreadyExist(address _contracAddress);

contract Protocol {
    mapping(address => address[]) private s_ownerToContracts; //maps an owner to the contracts they have created.
    mapping(address => ContractDetail) private s_contractToDetail; //maps a contract to its details.

    event NewContractAdded(
        address _contractAddress,
        address _creator,
        ContractType _type
    );

    enum ContractType {
        erc20,
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
        bool _isExist;
    }

    function addContract(
        address _contractAddress,
        string memory _name,
        bytes32 _abi,
        ContractType _type,
        bytes32 _sourceCode
    ) external {
        if (s_contractToDetail[_contractAddress]._isExist) {
            revert Protocol__AddressAlreadyExist(_contractAddress);
        }

        ContractDetail memory _newContract = ContractDetail(
            msg.sender,
            _name,
            _abi,
            _type,
            _sourceCode,
            block.timestamp,
            true
        );

        s_contractToDetail[_contractAddress] = _newContract;
        s_ownerToContracts[msg.sender].push(_contractAddress);

        emit NewContractAdded(_contractAddress, msg.sender, _type);
    }
}
