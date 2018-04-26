pragma solidity ^0.4.8;

contract A{
    function greet(){
    }
}

contract B{
    A sampleA = new A();
    
    function greetByB(){
        sampleA.greet();
    }
}
