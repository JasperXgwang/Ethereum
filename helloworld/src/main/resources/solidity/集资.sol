pragma solidity ^0.4.11;
//https://solidity.readthedocs.io/en/develop/types.html?highlight=CrowdFunding
contract CrowdFunding {
    // Defines a new type with two fields.
    //投资者
    struct Funder {
        address addr;//投资人地址
        uint amount;//出资总额
    }

    //集资者
    struct Campaign {
        address beneficiary;//受益人地址
        uint fundingGoal;//需要集资总额
        uint numFunders;//多少投资人
        uint amount;//已获取投资总额
        mapping(uint => Funder) funders;//投资人信息
    }

    uint numCampaigns; // 集资者总数
    mapping(uint => Campaign) campaigns; //集资者信息

    //初始化集资者以及目标金额
    function newCampaign(address beneficiary, uint goal) public returns (uint campaignID) {
        campaignID = numCampaigns++;
        // campaignID is return variable
        // Creates new struct and saves in storage. We leave out the mapping type.
        campaigns[campaignID] = Campaign(beneficiary, goal, 0, 0);
    }

    //投资者投资
    function contribute(uint campaignID) public payable {
        Campaign storage c = campaigns[campaignID];
        // Creates a new temporary memory struct, initialised with the given values
        // and copies it over to storage.
        // Note that you can also use Funder(msg.sender, msg.value) to initialise.
        c.funders[c.numFunders++] = Funder({addr : msg.sender, amount : msg.value});
        c.amount += msg.value;
        c.beneficiary.transfer(msg.value);
    }

    //判断是否集资成功
    function checkGoalReached(uint campaignID) public returns (bool reached) {
        Campaign storage c = campaigns[campaignID];
        if (c.amount < c.fundingGoal)
            return false;
//        uint amount = c.amount;
//        c.amount = 0;
//        c.beneficiary.transfer(amount);
        return true;
    }
}
