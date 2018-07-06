pragma solidity ^0.4.4;

contract PayableKeyword {

    //transfer 转账
    function depositTransfer() payable {
        address Account2 = 0xbd4734c9cf644ea5ae9387cd015c3c38a3034b51;
        Account2.transfer(msg.value);
    }


    //send 转账
    function depositPay() payable returns (bool){
        address Account2 = 0xbd4734c9cf644ea5ae9387cd015c3c38a3034b51;
        return Account2.send(msg.value);
    }

    // 查看帐号余额
    function getBalance(address addr) constant returns (uint){
        return addr.balance;
    }

    function getCurrentAddressBalance() constant returns (uint){
        return this.balance;
    }
}

contract C{
    //固定大小字节数组
    bytes1 b1 = 0x6c;
    bytes2 b2 = 0x6c69;
    //可变字节数组，长度内容可变
    bytes public b = new bytes(1);


    //清空字节数组
    function clearBytes(){
//        b.length=0;
        delete b;
    }

    function readIndexByte() constant returns(byte){
        return b2[1];
    }

    function getByteLength() constant returns(uint){
        return b2.length;
    }

}