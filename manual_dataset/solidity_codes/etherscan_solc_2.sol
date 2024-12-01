/**
 *Submitted for verification at Etherscan.io on 2021-06-08
*/

// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.8;
contract _50Win {
    struct Bet {
        address creator;
        address referrer;
        uint256 time;
        uint256 value;
        uint256 betFor; //tails or heads
    }

    address private _chef;
    mapping(address => Bet) public Bets;
    address[] public BetLUT;
    uint256 private _chefTips;
    uint256 public _tipsRate;
    uint256 public _refRate;
    uint256 public _cancelFee;

function send(address to, uint256 amt, uint256 tips, address ref) private returns (bool){
        (bool sentTo,) = address(to).call{value : amt-tips}("");
        if(tips>0) {
            if(ref != 0x0000000000000000000000000000000000000000) {
                uint256 refEarn = amt/_refRate/10000;//sharing tips with referral
                (bool sentRef,) = address(ref).call{value : refEarn}("");
                if(sentRef) tips -= refEarn;
            }

            (bool sentFee,) = address(_chef).call{value : tips}("");
            _chefTips += tips;
            return sentTo&&sentFee;
        }
        return sentTo;
    }
}

