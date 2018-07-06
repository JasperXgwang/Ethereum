pragma solidity ^0.4.4;

contract test {
    enum CP{Flyme, XIAOMI, HUAWEI}
    CP _cp;
    CP constant defalutCp = CP.Flyme;


    function getDefalutCp() pure public returns (uint){
        return uint(defalutCp);
    }

}