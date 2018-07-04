pragma solidity ^0.4.4;

// public internal private

contract Person {
    // internal 是默认权限
    uint internal _age;
    uint _weight;
    uint private _height;
    uint public _money;

    function _money() constant returns (uint){
        return 120;
    }

}

contract Test {
    uint _a;
    uint _b;

    bool _c;

    function Test(){
        _a = 100;
        _b = 200;
        _c = false;
    }

    function fei() constant returns (bool){
        return (!_c);
    }
}


//uint8
//int8 int16
//int == int256
//uint ==uint256

// int8 有符号  11111111 ~ 01111111   -127 ~ 127  256  第一位表示正负
// uint8 无符号 00000000 ~ 11111111   0 ~ 255
contract Lesson_6 {


    function testVar() constant returns (string){

    }


}