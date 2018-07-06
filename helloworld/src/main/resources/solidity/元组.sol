pragma solidity ^0.4.11;

contract C {

    //多类型返回

    mapping(uint => string) students;

    function C() {
        students[0] = "xiaoming";
        students[1] = "zhangsan";
    }

    function studentsNames() constant returns (string stu0, string stu1) {
        stu0 = students[0];
        stu1 = students[1];
        return (stu0, stu1);
    }

    function f() constant returns (uint, bool, string) {
        return (100, false, "block");
    }
}
