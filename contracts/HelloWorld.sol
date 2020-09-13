pragma solidity ^0.5.0;


contract HelloWorld {

    string Hello = "Hello World";


    function sayHello() public returns(string  memory){
        return (Hello);
    }
}