pragma solidity ^0.4.4;

contract Person {

    // 合约中的方法默认为public
    function age() constant returns (uint){
        return 55;
    }

    function money() constant private returns (uint){
        return 55;
    }
}