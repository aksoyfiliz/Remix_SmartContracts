// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.4.20;

contract Tender{
    
    address public owner;  
    uint public numberOfCompany;
    address[] public offeringCompanies;
    uint public minValue;
    uint private minOffer;
    
    // Model an offering Companies
    struct OfferCompany {
        address companyAddress;
        string companyName;
        uint offerValue;
    }
    
    //The order of the company and => the company info
    mapping(uint => OfferCompany) private companyInfo;
    
    
    // Constructor set the minimum value to offer by the owner of the contract
    function Tender (uint _minValue) public {
        owner = msg.sender;
        if(_minValue != 0) minValue = _minValue;
    }
    
    function kill () private {
        if(msg.sender == owner) selfdestruct(owner);
    }
    
    function CheckCompanyExist(address _companyAddress) private constant returns (bool) {
        for (uint i = 0; i < offeringCompanies.length; i++){
            if (offeringCompanies[i] == _companyAddress) return true;
        }
        return false;
    }
    
    function MinOffer (uint _value) private {
        if (minOffer == 0 || minOffer > _value){
            minOffer = _value;
        }
    }
    
    function Offer (string _companyName ,uint _value) external {
        // Requirement is the company has not offered before
        require(!CheckCompanyExist(msg.sender));
        require(_value >= minValue);
        numberOfCompany ++;
        companyInfo[numberOfCompany].companyAddress = msg.sender;
        companyInfo[numberOfCompany].companyName = _companyName;
        companyInfo[numberOfCompany].offerValue = _value;
        offeringCompanies.push(msg.sender);
        MinOffer(_value);
    }
    
    function TenderWinnerCompany () public view returns(string memory) {
        require(numberOfCompany == 3);
        for (uint i = 0; i < numberOfCompany; i++) {
            if(companyInfo[i+1].offerValue == minOffer){
                return companyInfo[i+1].companyName;
            }
        }
    }
}