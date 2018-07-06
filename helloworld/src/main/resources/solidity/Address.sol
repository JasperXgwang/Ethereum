pragma solidity ^0.4.4;

contract Test{
    address public _owner;

    address public _messageSender;

    function Test(){
        _owner= msg.sender;
        _messageSender = msg.sender;
    }
}