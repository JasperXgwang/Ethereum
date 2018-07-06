pragma solidity ^0.4.4;

contract C {

    //可变长度数组
    uint [] T = [1, 2, 4, 5];
    uint [] A = new  uint[](5);
    //不可变长度
    uint [5] T2 = [1, 2, 4, 5];

    function C(){
        for (uint i = 0; i < 5; i++) {
            A.push(i + 1);
        }
    }

    function T_length() constant returns (uint) {
        return T.length;
    }

    function setTlength(uint len) public {
        T.length = len;
    }

    //    function setT2length(uint len) public {
    //        T2length = len;
    //    }

}
