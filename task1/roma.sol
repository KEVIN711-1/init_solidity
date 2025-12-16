 例如， 罗马数字 2 写做 II ，即为两个并列的 1 。12 写做 XII ，
 即为 X + II 。 27 写做  XXVII, 即为 XX + V + II 。
 通常情况下，罗马数字中小的数字在大的数字的右边。
 但也存在特例，例如 4 不写做 IIII，而是 IV。数字 1 在数字 5 的左边，
 所表示的数等于大数 5 减小数 1 得到的数值 4 。同样地，数字 9 表示为 IX。这个特殊的规则只适用于以下六种情况：
 I 可以放在 V (5) 和 X (10) 的左边，来表示 4 和 9。
 X 可以放在 L (50) 和 C (100) 的左边，来表示 40 和 90。 
 C 可以放在 D (500) 和 M (1000) 的左边，来表示 400 和 900。
 给定一个罗马数字，将其转换成整数。

如果该值不是以 4 或 9 开头，请选择可以从输入中减去的最大值的符号，将该符号附加到结果，
减去其值，然后将其余部分转换为罗马数字。
如果该值以 4 或 9 开头，使用 减法形式，表示从以下符号中减去一个符号，
例如 4 是 5 (V) 减 1 (I): IV ，9 是 10 (X) 减 1 (I)：IX。
仅使用以下减法形式：4 (IV)，9 (IX)，40 (XL)，90 (XC)，400 (CD) 和 900 (CM)。
只有 10 的次方（I, X, C, M）最多可以连续附加 3 次以代表 10 的倍数。
你不能多次附加 5 (V)，50 (L) 或 500 (D)。如果需要将符号附加4次，请使用 减法形式。
给定一个整数，将其转换为罗马数字。

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// ✅ 反转字符串 (Reverse String)
// 题目描述：反转一个字符串。输入 "abcde"，输出 "edcba"
contract RomSwitch {
    mapping(bytes1 => int256) public RomToNumMap;
    mapping(uint16 => string) public NumToRomMap;
    uint16[13] public values;

    constructor() {
        // 给特定键赋初始值
        RomToNumMap['I'] = 1;
        RomToNumMap['V'] = 5;
        RomToNumMap['X'] = 10;
        RomToNumMap['L'] = 50;
        RomToNumMap['C'] = 100;
        RomToNumMap['D'] = 500;
        RomToNumMap['M'] = 1000;


        NumToRomMap[1] = "I";
        NumToRomMap[4] = "IV";
        NumToRomMap[5] = "V";
        NumToRomMap[9] = "IX";
        NumToRomMap[10] = "X";
        NumToRomMap[40] = "XL";
        NumToRomMap[50] = "L";
        NumToRomMap[90] = "XC";
        NumToRomMap[100] = "C";
        NumToRomMap[400] = "CD";
        NumToRomMap[500] = "D";
        NumToRomMap[900] = "CM";
        NumToRomMap[1000] = "M";
        // 初始化状态变量
        values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    }

    function RomToNum( string memory Rom) public view returns (int256 num) {
        bytes memory RomBytes = bytes(Rom);
        int256 total;
        uint256 Lenth = RomBytes.length;

        for ( uint256 i; i < Lenth; i ++ ) {
            bytes1 nowByte = RomBytes[i];
            bytes1 next; 
            
            if ( i+1 < Lenth ) {
                next = RomBytes[i+1];
            }

            if (nowByte == 'I') {
                if ( next == 'V' || next == 'X' ){
                    total -= RomToNumMap[nowByte];
                }
                else {
                    total += RomToNumMap[nowByte];
                }
            }
            else if (nowByte == 'V') {
                total += RomToNumMap[nowByte];
            }
            else if (nowByte == 'X') {
                if ( next == 'L' || next == 'C' ){
                    total -= RomToNumMap[nowByte];
                }
                else {
                    total += RomToNumMap[nowByte];
                }
            }
            else if (nowByte == 'L') {
                total += RomToNumMap[nowByte];
            }
            else if (nowByte == 'C') {
                if ( next == 'D' || next == 'M' ){
                    total -= RomToNumMap[nowByte];
                }
                else {
                    total += RomToNumMap[nowByte];
                }
            }
            else if (nowByte == 'D') {
                total += RomToNumMap[nowByte];
            }
            else if (nowByte == 'M') {
                total += RomToNumMap[nowByte];
            }
        }
      
        return total;
    }
  
     function intToRoman(uint256 num) public view returns (string memory) {
        require(num >= 1 && num <= 3999);
        
        // 定义值的顺序（从大到小）

        string memory result = "";

        for (uint256 i = 0; i < 13; i++) {
            uint16 currentValue = values[i];
            
            while (num >= currentValue) {
                // 从映射中获取符号
                result = string.concat(result, NumToRomMap[currentValue]);
                num -= currentValue;
            }
        }
        
        return result;
    }
}