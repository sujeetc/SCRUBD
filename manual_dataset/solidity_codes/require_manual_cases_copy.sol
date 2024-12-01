pragma solidity 0.4.24;

contract SimpleDAO {

// Following functions are buggy according to Slither-plus
// Collect_khichdaai(uint256)
// analyze()
// analyze()
// bug_require()
// bug_require_22()
// bug_require_3()
// bug_require_4()
// bug_require_4()
// bug_require_5()
// bug_require_6()
// bug_require_single_st()
// bug_require_single_st_2()
// multi_call()
// multi_call()
// not_covered()
// require_1()
// require_test()
// require_test_5()
// slither_2()
// slither_2a()
// slither_2a_1()
// slither_2b()
// slither_31()
// slither_318()
// slither_32341()
// slither_3_DD()
// slither_n31()
// test_writes_before_calls(uint256)
// withdraw_call(uint256)
// withdraw_cd(uint256)
// withdraw_conditional(uint256)
// withdraw_dd(uint256)
// withdraw_indirect_cd(uint256)

  uint public a;
  uint public b;
  uint public c;
  uint public d=0;
  uint public e;
  uint public z;
  uint public m;
  uint public n;

  uint public y;
  uint public x;
  uint public w;
  bool public not_called;
  bool public called;

    struct Holder   
    {
        uint unlockTime;
        uint balance;
    }
    mapping (address => Holder) public Acc;

    uint public MinSum;

    function slither_fn_1 () public { // reentrancy: no, reentrancy-eth: no
                                      // slither-plus: no
        require(msg.sender.call.value(b++)());
    }
    
    function bug_require() public { // reentrancy: yes, reentrancy-eth: yes
// slither-plus: yes
        require(not_called);
        require(msg.sender.call.value(b)());
        not_called = false;
    }   


    function slither_2a () public { // reentrancy: yes, reentrancy-eth: no
// slither-plus: yes
        require(a++<10 && msg.sender.call.value(a)());
    }




    function slither_2b_2 () public { // reentrancy: yes, reentrancy-eth: no
// slither-plus: yes
        require(msg.sender.call.value(b)() && a++<10);
    }


    function slither_13 () public { // reentrancy: no, reentrancy-eth: no
// slither-plus: no
        a = a+10;
        require(c>10);
        msg.sender.call.value(b)();
        if(a>50)
            a+=10;
    }

    // TODO
    function slither_32341 () public { // reentrancy: yes, reentrancy-eth: yes
// slither-plus: yes
        require(c>10);
        a = a+10;
        msg.sender.call.value(b)();
        if(a>50){
            c = c+4;
        }
    }

    function slither_321 () public { // reentrancy: yes, reentrancy-eth: yes
// slither-plus: yes
// same logic as above code
// Real BUG, Slither-Plus: No Bug, Slither: No Bug, 
        a = a+10;
        msg.sender.call.value(b)();
        if(a>50){
            c = c+4;
        }
        require(c>10);
    }

    function slither_3_DD () public { // reentrancy: yes, reentrancy-eth: yes
// slither-plus: yes
        require(c>10);
        c = a+4;
        msg.sender.call.value(b)();
        a = a+10;
    }

    function slither_123 () public {  // reentrancy: no, reentrancy-eth: no
// slither-plus: no
        require(y>10);
        z = c+10;
        msg.sender.call.value(b)();
        if(a>50){
            c = c+4;
        }
    }

    function slither_3 () public {  // reentrancy: yes, reentrancy-eth: yes
// slither-plus: yes
// Real BUG, Slither-Plus: No Bug, Slither: No Bug, 
// b is getting updated before call
// updation of c depends on b (indirectly through a)
// require(c>10) might fail or success based on updation of c
// through reentrancy, b can be set such that c does not get updated
        b = b+10;
        msg.sender.call.value(z)();
        if(a>50){
            c = c+4;
        }
        if(b<50)
            a = a+4;
        require(c>10);
    }


    function slither_12131 () public {  // reentrancy: yes, reentrancy-eth: yes
// slither-plus: yes
        a = a+10;                       // require checks for c, c depends on a, a is updated before call
        msg.sender.call.value(b)();     // c will get updated if reentrant calls set a greater than 50
        require(c>10);                  // updation of c will impact require condition
        if(a>50){
            c = c+14;
        }
    }

    function slither_n31 () public { // reentrancy: yes, reentrancy-eth: yes
// slither-plus: yes
// reentrant calls will set c greater than a and require will always pass, which won't happen in normal non-reentrant scenario
// BUG, Slither-Plus: No Bug, Slither: No Bug, 
        a = a+10;
        c = c+4;
        msg.sender.call.value(b)();
        require(c>10);
    }

    // we need to think about call and correspond location 
    // can there be bug if require is before call


    function slither_318 () public { // reentrancy: yes, reentrancy-eth: yes
// slither-plus: yes
// 1st reason for bug: a is updated after call, call is control dependent on a
        if(a<10)                    // 2nd reason for bug: require has c in it. c is updated after call
        {                           // maybe we can split this example into two buggy cases
            d = a+10;
            msg.sender.call.value(b)();
            if(d<10){
                // msg.sender.call
            }
        }
    }
}
