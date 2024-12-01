/*

 * @source: http://blockchain.unica.it/projects/ethereum-survey/attacks.html#simpledao

 * @author: Atzei N., Bartoletti M., Cimoli T

 * Modified by Josselin Feist

 */

pragma solidity 0.4.24;



contract SimpleDAO {

  uint public a;

  uint public b;

  uint public c;

  uint public d=0;

  uint public e;

  uint public z;

  uint public m;

  uint public n;



  uint public f;

  uint public k;



  uint public y;

  uint public x;

  uint public w;

  bool public not_called;

    bool intitalized;



function buggy_require_wbc_1() public { // Buggy // // SLither-plus does not catch the bug
    // a = 25
    // c = 13
    a = a + 10;

    msg.sender.call.value(b)();

    if(a>50) 
        c = c - 4;

    require(c<10);

}



function buggy_require_wbc_2() public {
    // a = 62
    // c = 7
    a = a - 10;

    msg.sender.call.value(b)();

    require(c<10);

    if(a>50)
        c = c + 4;

}



function buggy_require_wbc_3() public {

    // a = 62
    // c = 13
    a = a - 10;

    if(a>50) 
    	c = c - 4;

    msg.sender.call.value(b)();

    require(c<10);

}



function non_buggy_require_wbc_1() public { // Not Buggy

    a = a + 10;

    if(a>50) c = c + 4;

    require(c<10);

    msg.sender.call.value(b)();

}



function slithermine_5() public { // Buggy

    a = a + 10;

    require(c<10);

    msg.sender.call.value(b)();

    if(a>50) c = c + 4;

}



function slithermine_6() public { // Not Buggy

    a = a + 10;

    require(c<10);

    if(a>50) c = c + 4;

    msg.sender.call.value(b)();

}



function slithermine_7() public { // Not Buggy

    msg.sender.call.value(b)();

    a = a + 10;

    if(a>50) c = c + 4;

    require(c<10);

}



function slithermine_8() public { // Not Buggy

    msg.sender.call.value(b)();

    a = a + 10;

    require(c<10);

    if(a>50) c = c + 4;

}



function slithermine_9() public { // Not Buggy

    msg.sender.call.value(b)();

    if(a>50) c = c + 4;

    a = a + 10;

    require(c<10);

}



function slithermine_10() public { // Not Buggy

    msg.sender.call.value(b)();

    if(a>50) c = c + 4;

    require(c<10);

    a = a + 10;

}



function slithermine_11() public { // Not Buggy

    msg.sender.call.value(b)();

    require(c<10);

    a = a + 10;

    if(a>50) c = c + 4;

}



function slithermine_12() public { // Not Buggy

    msg.sender.call.value(b)();

    require(c<10);

    if(a>50) c = c + 4;

    a = a + 10;

}



function buggy_require_wbc_4() public {  //  Buggy
    // a = 30, c = 8
    if(a>50) 
	c = c + 4;

    a = a + 10;

    msg.sender.call.value(b)();

    require(c>10);

}

function buggy_require_wbc_5() public {  //  Buggy
    // a = 55, c = 2
    if(a>50)
        c = c + 4;

    msg.sender.call.value(b)();

    a = a - 10;
    
    require(c>10);

}


function slithermine_14() public { // Not Buggy

    if(a>50) c = c + 4;

    a = a + 10;

    require(c<10);

    msg.sender.call.value(b)();

}



function slithermine_15() public { // Buggy

    if(a>50) c = c + 4;

    msg.sender.call.value(b)();

    a = a + 10;

    require(c<10);

}



function slithermine_16() public { // Buggy

    if(a>50) c = c + 4;

    msg.sender.call.value(b)();

    require(c<10);

    a = a + 10;

}



function slithermine_17() public { // Not Buggy

    if(a>50) c = c + 4;

    require(c<10);

    a = a + 10;

    msg.sender.call.value(b)();

}



function slithermine_18() public { // Buggy // SLither-plus does not catch the bug

    if(a>15) c = c + 40;

    require(c<10);

    msg.sender.call.value(b)();

    a = a + 10;

}



function slithermine_19() public { // Buggy // SLither-plus does not catch the bug // Debug the reason for it

    require(c<10);

    a = a + 10;

    msg.sender.call.value(b)();

    if(a>50) 
        c = c + 4;

}



function slithermine_20() public { // Not Buggy

    require(c<10);

    a = a + 10;

    if(a>50) c = c + 4;

    msg.sender.call.value(b)();

}



function slithermine_21() public { // Buggy

    require(c<10);

    msg.sender.call.value(b)();

    a = a + 10;

    if(a>50) c = c + 4;

}



function slithermine_22() public { // Buggy

    require(c<10);

    msg.sender.call.value(b)();

    if(a>8) c = c + 40;

    a = a + 10;

}



function slithermine_23() public { // Not Buggy

    require(c<10);

    if(a>50) c = c + 4;

    a = a + 10;

    msg.sender.call.value(b)();

}



function slithermine_24() public { // Buggy // SLither-plus does not catch the bug

    require(c<10);

    if(a>50) 
        c = c + 4;

    msg.sender.call.value(b)();

    a = a + 10;

}

}


