// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// 合并两个有序数组 (Merge Sorted Array)
// 题目描述：将两个有序数组合并为一个有序数组。
contract BinaryTree {
    // 在Solidity中，函数返回动态数组时，必须指定数据位置（memory或calldata）。
    // 对于返回的数组，我们通常使用memory，因为calldata是只读的，
    // 并且主要用于函数参数，不能用于返回。
    // function testMerge() public pure returns (uint256[] memory) {
    //     // C 语言：编译时在数据段分配内存
    //     //int arr[] = {1, 3, 5, 7};  // ✅ 编译时确定
    //     // Solidity：运行时在 EVM 内存中分配
    //     // ❌ 无法在编译时确定内存布局
    //     uint256[4] memory arrayTestA = [uint256(1), 3, 5, 7];
    //     uint256[4] memory arrayTestB = [uint256(2), 4, 6, 8];
    //     // 转换为动态数组
    //     uint256[] memory dynamicA = new uint256[](4);
    //     for (uint i = 0; i < 4; i++) {
    //         dynamicA[i] = arrayTestA[i];
    //     }
        
    //     uint256[] memory dynamicB = new uint256[](4);
    //     for (uint i = 0; i < 4; i++) {
    //         dynamicB[i] = arrayTestB[i];
    //     }
    //     return mergeSortedArray(dynamicA, dynamicB);
    //     // uint256[] memory arrayTestA = new uint256[](4);
    //     // uint256[] memory arrayTestA = new uint256[];
    // }
//    function mergeSortedArray( uint256[] memory arrayA, uint256[] memory arrayB ) public pure returns (uint256[] memory ){
        function mergeSortedArray( uint256[] calldata arrayA, uint256[] calldata arrayB ) public pure returns (uint256[] memory ){
        uint256 lengthA = arrayA.length; 
        uint256 lengthB = arrayB.length; 
        uint256 i;
        uint256 j;
        uint256 k;
        // uint256 [lengthA+lengthB] memory result;
        uint256[] memory result = new uint256[](lengthA+lengthB);
        // uint256 [] memory result;
        unchecked {
            // 正常情况：Solidity 会自动检查溢出,但消耗Gas检查
            // 在 unchecked 块内：关闭溢出检查
            // 更快，但你自己要确保不会溢出
            while ( i<lengthA && j<lengthB) {
                uint256 valueA = arrayA[i];  // 缓存一次, 节省gas费用
                uint256 valueB = arrayB[j]; 
                if( valueA < valueB ){
                    // 后置递增会产生额外的操作码
                    // result[k++]=arrayA[i++];
                    result[k] = valueA;
                    i++;
                }
                else {
                    // result[k++]=arrayB[j++];
                    result[k] = valueB;
                    j++;
                }
                k++;
            }
            while (i < lengthA) {
                result[k] = arrayA[i];
                i++;
                k++;
            }
            
            while (j < lengthB) {
                result[k] = arrayB[j];
                j++;
                k++;
            }
        }
        return result;
    }

    function binarySearch( uint256[] calldata array, uint256 target ) public pure returns (uint256){
        if (array.length == 0) {
            revert("Empty array");
        }
        uint256  L;
        
        uint256  R=array.length-1;

        while ( L <= R ) {
            uint256 mid = L+(R-L)/2;
            if (array[mid]==target) {
                return mid;
            }
            else if ( array[mid] < target ) {
                L=mid+1; // 目标在右半部分
            }
            else {
                R=mid-1; // 目标在左半部分
            }
        }
        revert("Element not found");  // 触发错误，交易失败
        // return type(uint256).max; // 2^256 - 1
    }
}