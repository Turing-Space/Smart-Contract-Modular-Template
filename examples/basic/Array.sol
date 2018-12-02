pragma solidity ^0.4.24;

contract Array {
    mapping (uint => string) public strings;
    
    function setString(uint index, string content) public {
        strings[index] = content;
    }
}
