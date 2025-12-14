// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// ✅ 创建一个名为Voting的合约，包含以下功能：
// 一个mapping来存储候选人的得票数
// 一个vote函数，允许用户投票给某个候选人
// 一个getVotes函数，返回某个候选人的得票数
// 一个resetVotes函数，重置所有候选人的得票数

contract VoteSystem {
    //  主数据存储
    mapping(address => uint256) public vote_count ; // 候选人人mapping
    //  键列表（用于遍历）
    address[] public be_voted_list;

 // ✅ 修正1：构造函数添加3个测试候选人
    constructor() {
        // 添加3个测试候选人（使用简单地址）
        address candidate1 = address(0x111);
        address candidate2 = address(0x222);
        address candidate3 = address(0x333);
        
        be_voted_list.push(candidate1);
        be_voted_list.push(candidate2);
        be_voted_list.push(candidate3);
        
        // 初始化票数为0（mapping默认是0，这里为了明确显示）
        vote_count[candidate1] = 0;
        vote_count[candidate2] = 0;
        vote_count[candidate3] = 0;
    }

    function Voting ( address be_voted ) public {
        vote_count[be_voted]+=1;
        if ( vote_count[be_voted] == 0 ) {
            be_voted_list.push(be_voted);
        }
    }

    // view：声明该函数不会修改合约状态
    // 只能读取状态变量，不能写入
    // 不消耗gas（如果通过外部调用，调用者不支付gas）
    // 可以在其他view或pure函数中调用
    function getVotes ( address be_voted ) public view returns (uint256){
        return vote_count[be_voted];
    }

    function resetVotes () public {
        for ( uint256 i; i < be_voted_list.length; i ++ ) {
            vote_count[be_voted_list[i]] = 0;
        }
    }

    function get_beVoted_count () public view returns (uint256) {
        return  be_voted_list.length;
    }
}