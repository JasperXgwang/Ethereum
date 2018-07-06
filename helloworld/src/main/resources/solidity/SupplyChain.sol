pragma solidity ^0.4.11;

/*
场景描述
供应链溯源合约有以下几类参与方：

商品厂商：保存于mapping(address => User) producerMap
各级经销商：保存于mapping(address => User) retailerMap
消费者：保存于mapping(address => User) customerMap
各类参与方均通过newUser方法进行上链登记。通过传递不同的Actor值来指定不同参与方。

厂商首先通过newProduct方法将出厂商品登记到区块链，
随后商品分销到下一级经销商，接下来的环节，
每一次商品的分销均在接收商品的经销商处调用retailerInnerTransfer方法将商品进行上链登记，
最终商品在零售商处由消费者购买，调用fromRetailerToCustomer方法进行最终登记，完成整个出厂-多级分销-零售的流程。
商品一旦由厂商登记上链，便可通过getCommodity查询到商品当前的分销信息，只有处于该分销路径上的参与方才允许查询。
此外，通过addWhiteList可以为指定参与方添加顶级查询权限，被添加到WhiteList的参与方，即使不参与到某商品的分销路径中，
也可查询到该商品的分销信息。

*/

contract SupplyChain {
    enum Actor{ Others, Producer, Retailer, Customer}
    enum Commoditytype{ Wine, Jewelry, Shrimp, Others}
    enum Phase{ Supplier, Producer, Dealer, Retailer, Customer}

    struct User{
        bytes32 ID;
        bytes32 name;
        Actor actor;
    }

    struct Commodity{
        bytes32 commodityID;
        bytes32 commodityName;
        uint produceTime;
        bytes32 producerName;
        uint[] timestamps;
        bytes32[] retailerNames;
        uint sellTime;
        bytes32 customerName;
        bool isBinding;
        address owner;
    }

    mapping(address => User) producerMap;
    mapping(address => User) retailerMap;
    mapping(address => User) customerMap;
    mapping(bytes32 => Commodity) commodityMap;
    mapping(address => bool) whiteList;
    address owner;

    function SupplyChain(){
        owner = msg.sender;
        whiteList[owner] = true;
    }

    function addWhiteList(address addr){
        whiteList[addr] = true;
    }

    function newUser(bytes32 ID, bytes32 name,Actor actor) returns(bool, string){
        User user;

        if(actor == Actor.Producer){
            user = producerMap[msg.sender];
        }else if(actor == Actor.Retailer){
            user = retailerMap[msg.sender];
        }else if(actor == Actor.Customer){
            user = customerMap[msg.sender];
        }else{
            return (false,"the actor is not belong");
        }

        if(user.ID != 0x0){
            return (false, "this ID has been occupied!");
        }
        user.ID = ID;
        user.name = name;
        user.actor = actor;
        return (true, "Success");
    }

    // this interface just for producer
    function newProduct(bytes32 commodityID, bytes32 commodityName,
        uint timestamp) returns(bool,bytes32){
        Commodity commodity = commodityMap[commodityID];
        if(commodity.commodityID != 0x0) {
            return (false,"The commodityID already exist!");
        }
        User user = producerMap[msg.sender];
        if(user.ID == 0x0) {
            return (false,"The producer don't exist!");
        }
        commodity.commodityID = commodityID;
        commodity.commodityName = commodityName;
        commodity.produceTime = timestamp;
        commodity.producerName = user.name;
        return (true,"Success,produce a new product");
    }


    // this interface just for retailer
    function retailerInnerTransfer(bytes32 commodityID,uint timestamp) returns(bool, string){
        Commodity commodity = commodityMap[commodityID];
        if(commodity.commodityID == 0x0) {
            return (false,"The commodityID don't exist!");
        }
        User user = retailerMap[msg.sender];
        if(user.ID == 0x0) {
            return (false,"The retailer don't exist!");
        }
        commodity.timestamps.push(timestamp);
        commodity.retailerNames.push( user.name );
        return (true,"Success");
    }

    function fromRetailerToCustomer(bytes32 commodityID,uint timestamp) returns(bool, string){
        Commodity commodity = commodityMap[commodityID];
        if(commodity.commodityID == 0x0) {
            return (false,"The commodityID don't exist!");
        }
        commodity.sellTime = timestamp;
        return (true,"Success,Has been sold");
    }

    // just for Supervision organization
    function getCommodityRecordsByWhiteList(bytes32 commodityID) returns(bool,string,
        bytes32 producerName,uint produceTime, bytes32[] retailerNames,uint[] retailerTimes
    , bytes32 customerName,uint sellTime){
        if(!whiteList[msg.sender]){
            return (false,"you has no access",producerName, produceTime, retailerNames, retailerTimes, customerName,commodity.sellTime);
        }
        Commodity commodity = commodityMap[commodityID];
        if(commodity.commodityID == 0x0){
            return (false,"The commodityID is not exist",producerName, produceTime, retailerNames, retailerTimes,customerName,commodity.sellTime);
        }
        return (true,"Success",commodity.producerName, commodity.produceTime, commodity.retailerNames, commodity.timestamps, commodity.customerName,commodity.sellTime);
    }


    function getCommodity(bytes32 commodityID,Actor actor)  returns(bool,string,
        bytes32 producerName,uint produceTime,bytes32[] retailerNames,uint[] retailerTimes
    , bytes32 customerName,uint sellTime){
        Commodity commodity = commodityMap[commodityID];
        if(commodity.commodityID == 0x0){
            return (false,"The commodityID is not exist",producerName,produceTime,
            retailerNames,retailerTimes,customerName,sellTime);
        }
        User user;
        if(actor == Actor.Producer){
            user = producerMap[msg.sender];
        }else if(actor == Actor.Retailer){
            user = retailerMap[msg.sender];
        }else if(actor == Actor.Customer){
            user = customerMap[msg.sender];
        }else{
            return (false,"the actor is not belong",producerName,produceTime,
            retailerNames,retailerTimes,customerName,sellTime);
        }
        if(commodity.isBinding){
            if(commodity.owner != msg.sender){
                return (false,"warning,this commodity has been bound",producerName,produceTime,
                retailerNames,retailerTimes,customerName,sellTime);
            }else{
                (false,"has already bind",commodity.producerName,commodity.retailerNames,commodity.customerName);
            }
        }
        if(commodity.sellTime > 0 ) {
            commodity.isBinding = true;
            commodity.owner = msg.sender;
            commodity.customerName = user.name;
        }
        return (true,"Success",commodity.producerName,commodity.produceTime,commodity.retailerNames,commodity.timestamps,commodity.customerName,commodity.sellTime);
    }
}
