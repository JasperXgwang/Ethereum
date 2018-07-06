pragma solidity ^0.4.4;

contract Mapping {

    mapping(address => uint) balances;

    function update(address a, uint balance) public {
        balances[a] = balance;
    }

    function getBalance(address a) constant public returns (uint){
        return balances[a];
    }

}