pragma solidity ^0.4.4;


contract Person_2 {
    uint _age;
    string _name;

    //构造函数
    function Person_2(uint age, string name){
        _age = age;
        _name = name;
    }

    function f(){
        modify(_age, _name);
    }

    // internal 只能内部调用， storage为引用类型
    function modify(uint age, string storage name) internal {
        age = 100;
        //        name = "jasper";
        bytes(name)[0] = "J";
    }

    function age() constant returns (uint){
        return _age;
    }

    function name() constant returns (string){
        return _name;
    }
}