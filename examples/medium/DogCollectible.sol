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
    
    // 取的狗總數
    function getTotalDog() public view returns (uint256) {
        return totalDogs;
    }
    
    // 取得狗名
    function getDogNameAt(uint256 i) public view returns (string) {
        return dogs[i].name;
    }
    
    // 取得狗歲
    function getDogAgeAt(uint256 i) public view returns (uint256) {
        return dogs[i].age;
    }
    
}
