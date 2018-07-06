pragma solidity ^0.4.11;

contract C {

    uint a = 1 ether;
    uint b = 10 ** 18 wei;
    uint c = 1000 finney;
    uint d = 1000000 szabo;

    function isTruea2b() constant returns (bool) {
        return a == b;
    }

    function isTruea2c() constant returns (bool) {
        return a == c;
    }

    function isTruea2d() constant returns (bool) {
        return a == d;
    }

}
