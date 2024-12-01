
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



function slithermine_1() public { // Buggy // // SLither-plus does not catch the bug

    a = a + 10;

    msg.sender.call.value(b)();

    if(a>50) 
        c = c + 4;

    require(c<10);

}

function slithermine_2() public { // Not Buggy --> Buggy Now

    a = a + 10;

    msg.sender.call.value(b)();

    require(c<10);

    if(a>50)
        c = c + 4;

}

function buggy_require_1() public { // Not Buggy --> Buggy Now
    // d = 12, a = 42, c = 3
    d = d - 1;

    // a = d + 10;

    msg.sender.call.value(b)();

    if(d > 10)
        a = a + 10;

    require(c<10);

    if(a>50)
        c = c + 8;

}



function slithermine_18() public { // Buggy // SLither-plus does not catch the bug

    if(a>15) c = c + 40;

    require(c<10);

    msg.sender.call.value(b)();

    a = a + 10;

}

function slithermine_24() public { // Buggy // SLither-plus does not catch the bug

    require(c<10);

    if(a>50) 
        c = c + 4;

    msg.sender.call.value(b)();

    a = a + 10;

}
}
