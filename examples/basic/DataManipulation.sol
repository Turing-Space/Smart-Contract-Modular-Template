pragma solidity ^0.4.8;

contract DataManipulation{
    uint public x = 1;
    uint public y = 2;
    
    // (x, y) = (y, x);
    
    function swap(){
        assert(x == 1 && y == 2);
        (y, x) = (x, y);
        assert(x == 2 && y == 1);
    }
    
}
