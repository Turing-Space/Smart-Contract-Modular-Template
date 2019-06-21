pragma solidity ^0.4.24;  


/* 合約本體 */
contract SimpleAdd {

    /* 變數宣告 */
    uint number = 0;

    // ... 更多變數


    /* 函數定義 */
    function getNumber() public view returns (uint) {
        return number;
    }

    // ... 更多函數 
    function increase() public {
        number++;
    }

    
}
