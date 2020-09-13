pragma solidity >=0.4.22 <0.8.0;


contract HelloWorld {

    string Hello = "Hello World";


    function sayHello() public returns(string  memory){
        return (Hello);
    }
}