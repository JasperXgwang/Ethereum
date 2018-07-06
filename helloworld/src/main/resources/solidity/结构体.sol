pragma solidity ^0.4.4;

contract Students {

    struct Person {
        uint age;
        uint stuId;
        string name;
    }

    Person [] persons;

    //storage  类型
    Person _p1 = Person(16, 100, "jasper");
    Person _p2 = Person(18, 101, "xgwang");
    Person _p3 = Person({age : 30, stuId : 103, name : "xiaoming"});

    function Students(){
        persons[0] = _p1;
        persons[1] = _p2;
        persons[2] = _p3;
    }

    function f(){
        // memory  类型
        Person memory _p = Person(18, 104, "xiaozhang");
    }


}