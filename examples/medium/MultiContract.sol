pragma solidity ^0.4.8;

contract A{
    function greet() returns (string){
        return "Hi";
    }
}

contract B{
    A sampleA = new A();
    A.greet();
}
