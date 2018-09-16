pragma solidity ^0.4.24;

contract DogCollectible {
    
    // 狗的定義
    struct Dog {
        string name;
        uint8 age;
    }
    
    // 狗陣列
    Dog[] dogs;
    
    // 狗總數
    uint256 totalDogs = 0;
    
    // 增加狗
    function addDog(string name, uint8 age) public {
        Dog memory dog = Dog(name,age);
        dogs.push(dog);
        totalDogs += 1;
    }
}
