pragma solidity >= 0.5.0;

contract A{
    function greet() public returns(string memory){
        return "hello";
    }
}

contract B{
    A a = new A();
    function callGreet() public returns (string memory) {
        return a.greet();
    }
}
