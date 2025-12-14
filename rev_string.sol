// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// ✅ 反转字符串 (Reverse String)
// 题目描述：反转一个字符串。输入 "abcde"，输出 "edcba"
contract StringEditor {
    function ReverseString( string memory str) public pure  returns (string memory) {
        bytes memory strBytes = bytes(str);

        bytes memory resultBytes = new bytes(strBytes.length);

        for ( uint256 i; i < strBytes.length; i ++ ) {
            resultBytes[i]=strBytes[(strBytes.length-1)-i];
        }
        return string(resultBytes);
    }
}