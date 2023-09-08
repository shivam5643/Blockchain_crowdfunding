// SPDX-License-Identifier: GPL-3.0

pragma solidity >0.8.0;

contract CrowdFunding{
    struct Campaign{
        address owner;
        string title;
        string description;
        uint target;
        uint deadline;
        uint amountCollected;
        string image;
        address[] donators;
        uint[] donations;
    }
    mapping(uint =>Campaign)  public campaigns;

    uint public numberOfCampaigns=0;

    function createCampaign(address _owner,string memory _title, string memory _description,
    uint _target, uint _deadline ,string memory _image) public returns(uint){
        Campaign storage campaign =campaigns[numberOfCampaigns];
        //is everything okay
        require(campaign.deadline<block.timestamp,"The deadling should ba a date in future");
        campaign.owner=_owner;
        campaign.title=_title;
        campaign.description=_description;
        campaign.target=_target;
        campaign.deadline=_deadline;
        campaign.amountCollected=0;
        campaign.image=_image;

        numberOfCampaigns++;
        return numberOfCampaigns-1;

     }

    function donateTOCampaign(uint _id)public payable{
        uint amount =msg.value;
        Campaign storage campaign=campaigns[_id];
        campaign.donators.push(msg.sender);
        campaign.donations.push(amount);
        (bool sent,) = payable(campaign.owner).call{value:amount}("");
        if(sent){
            campaign.amountCollected=campaign.amountCollected+amount;
        }
    }

    function getDonars( uint _id)view public returns(address[] memory,uint[] memory){
        return (campaigns[_id].donators,campaigns[_id].donations);
    }

    function getCampaigns() public view returns(Campaign[] memory){
        Campaign[] memory allCampaigns=new Campaign[](numberOfCampaigns);
        for(uint i=0; i<numberOfCampaigns; i++){
            Campaign storage item=campaigns[i];
            allCampaigns[i]=item;
        }
        return allCampaigns;
    }

}