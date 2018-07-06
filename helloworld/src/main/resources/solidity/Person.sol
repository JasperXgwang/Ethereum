//0x692a70d2e424a56d2c6c27aa97d1a86395877b3a
pragma solidity ^0.4.4;
/*
pragma 版本声明
solidity 开发语言
0.4.4 当前版本
^ 向上兼容
*/

contract Person {
    uint _height;
    uint _age;
    address _owner;//合约拥有者

    //构造函数
    function Person(){
        _height = 180;
        _age = 29;
        _owner = msg.sender;
    }

    function setHeight(uint height){
        _height = height;
    }

    // constant 方法只读
    function height() constant returns (uint){
        return _height;
    }

    function setAge(uint age){
        _age = age;
    }

    function age() constant returns (uint){
        return _age;
    }

    function owner() constant returns (address){
        return (_owner);
    }

    function kill() constant {
        if (_owner == msg.sender) {
            //析构函数
            selfdestruct(_owner);
        }
    }
}

contract Person2 {

}

//继承，多继承
contract Jasper is Person, Person2 {
    // 只有private的属性不能继承


    // 函数重写
    function age() constant returns (uint){
        return 10;
    }
}
