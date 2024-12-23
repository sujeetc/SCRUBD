// Note : reentrancy-eth marked in this file is different from reetrancy-eth from Slither tool
// Here we say that the function has reentrancy-eth if an attacker can get extra benefits as compared to normal non-reentrant calls
// However, if we mark that a function has reentrancy and it does not have reentrancy-eth, then we say that the function behaves differently for reentrant case and non reentrant case, but attacker won't get any benefits
// Common example for
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


    function non_buggy_single_st_req_1 () public { // reentrancy: no, reentrancy-eth: no
            require(msg.sender.call.value(b++)());
    }
    

    function bug_require_22() public{ // reentrancy: yes, reentrancy-eth: yes
        a++;
        require(msg.sender.call.value(b)());
        require(a>10);
    }   

    function non_buggy_single_st_req_2 () public { // reentrancy: yes, reentrancy-eth: no
        require(a--<10 && msg.sender.call.value(a)());
    }

    function non_buggy_single_st_req_3 () public { // reentrancy: yes, reentrancy-eth: no
        require(a++<10 && msg.sender.call.value(b)());
    }

    function slither_2b () public { // reentrancy:yes , reentrancy-eth: yes
                                    // parameter of call is updated after call
        require(msg.sender.call.value(a)() && a++<10);
    }

    function non_buggy_single_st_req_4 () public { // reentrancy:yes, reentrancy-eth: no
        require(msg.sender.call.value(b)() && a++<10);
    }


    function slither_2 () public { // reentrancy: yes, reentrancy-eth: yes
        require(a++<10 && msg.sender.call.value(a)() && a<10);
    }

    function non_buggy_1 () public { // reentrancy: no, reentrancy-eth: no
            a = a+10;
            require(c>10);
            msg.sender.call.value(b)();
            if(a>50)
                a+=10;
    }

// TODO
function buggy_require_1 () public { // reentrancy: yes, reentrancy-eth: yes
    // c = 12, a = 52
    require(c>10);
    a = a+10;
    msg.sender.call.value(b)();
    if(a>50){
        c = c - 4;
    }
}

function slither_3_DD () public { // reentrancy: yes, reentrancy-eth: yes
    require(c>10);
    c = a+4;
    msg.sender.call.value(b)();
    a = a+10;
}

function non_buggy_require_1 () public {  // reentrancy: no, reentrancy-eth: no
    require(y>10);
    z = c+10;
    msg.sender.call.value(b)();
    if(a>50){
        c = c+4;
    }
}

function buggy_require_indirect_cd () public {  // reentrancy: yes, reentrancy-eth: yes
                                // Real BUG, Slither-Plus: No Bug, Slither: No Bug, 
                                // b is getting updated before call
                                // updation of c depends on b (indirectly through a)
                                // require(c>10) might fail or success based on updation of c
                                // through reentrancy, b can be set such that c does not get updated
    // b = 32
    // a = 42
    // c = 12
    b = b + 10;
    msg.sender.call.value(z)();
    if(a>50){
        c = c - 4;
    }
    if(b<50)
        a = a+10;
    require(c>10);
}



function buggy_require_wbc_1 () public {  // reentrancy: yes, reentrancy-eth: yes
    // a = 62, c = 12
    a = a-10;                   // require checks for c, c depends on a, a is updated before call
    msg.sender.call.value(b)(); // c will get updated if reentrant calls set a greater than 50
    require(c>10);              // updation of c will impact require condition
    if(a>50){
        c = c-4;
    }
}

function slither_n31 () public { // reentrancy: yes, reentrancy-eth: yes
                            // reentrant calls will set c greater than a and require will always pass, which won't happen in normal non-reentrant scenario
                            // BUG, Slither-Plus: No Bug, Slither: No Bug, 
    a = a+10;
    c = c+4;
    msg.sender.call.value(b)();
    require(c>10);
}


// we need to think about call and correspond location 
// can there be bug if require is before call



function buggy_wac_1 () public { // reentrancy: yes, reentrancy-eth: yes
    // a = 8                           // 1st reason for bug: a is updated after call, call is control dependent on a
    
    if(a<10)                    // 2nd reason for bug: require has c in it. c is updated after call
    {                           // maybe we can split this example into two buggy cases
        d = a+10;
        msg.sender.call.value(b)();
            if(d<10){
                // msg.sender.call.value(b)();
                a = a + 10;
            }
            if(a<50)
                c = c - 10;
    }
    require(c>10);
}

// Parameters of require is updated after call

    function Collect_khichdaai(uint _am) public // reentrancy: yes, reentrancy-eth: yes
    {
        a = a + 10;
        b = a + 1;
        msg.sender.call.value(c)();
        require(a>50);
    }

    function Collect_khichdasai(uint _am) public // reentrancy: yes, reentrancy-eth: yes
    {
        var acc = Acc[msg.sender];
        acc.balance++;
        msg.sender.call.value(c)();
        require(acc.balance<10);
    }


    // function test_writes(uint amount) public{
    //     e = z - 10;                  // no need to mark this function as this function was created to test writes and not to test bug
    //     if (b < 10)
    //         m = z - 10;
    //     else
    //     {
    //         n = a - 10;
    //         require(msg.sender.call.value(amount + a)());
    //     }
    //     f = y - 10;
    //     require(msg.sender.call.value(n)());
    //     k = w - 10;
    //     require(msg.sender.call.value(n)());
    // }






    function withdraw_call(uint amount) public{ // reentrancy: yes, reentrancy-eth: yes
                    require(msg.sender.call.value(amount + a)());
                    a = a - 10;
    }
    function withdraw_conditional(uint amount) public{ // reentrancy: yes, reentrancy-eth: yes
                    if (a > 10)
                        require(msg.sender.call.value(amount + b)());
                    a = a - 10;
    }
    function buggy_indirect_dep_1() public { // reentrancy: yes, reentrancy-eth: yes
                                    // parameter of call: x
                                    // x depends on b, b depends on z, z depends on a
                                    // a is updated after call, thats whu buggy
         // a = 1                           // Slither: Yes, Our tool: Yes, Real : Yes
        z = a + 10;
        if(z > 10){
            b = b + 10;
        }
        x = b + x;
        require(msg.sender.call.value(x)());
        a = a - 1;
    }

    function withdraw_cd(uint amount) public{ // reentrancy: yes, reentrancy-eth: yes
        if(a > 10)                            // bug exists without require also
          require(msg.sender.call.value(b)());
        a = a - 10;
     }


    function withdraw_dd(uint amount) public{ // reentrancy: yes, reentrancy-eth: yes
        require(msg.sender.call.value(a)());  // bug exists without require also
        a = a - 10;
     }



    function withdraw_send() public{ 
        require(msg.sender.send(a));
        a = a - 10;
     }


    function withdraw_cd() public{
        if(a > 10)
          require(msg.sender.send(b));
        a = a - 10;
     }

    function withdraw_indirect_cd() public{
        if(a>10)
          b = b - 10;
        require(msg.sender.send(b));
        a = a - 10;
     }

    function analyze() public { 
                        // reentrancy: yes, reentrancy-eth: yes
                        // bug exists without require also
                        // Real :yes, Slither: Yes, Our: No
        if(b<10)
        {
            require(msg.sender.call.value(a)());
            b = b-10;
        }
    }




    function bug_require_1() public{ 
                                // reentrancy:yes, reentrancy-eth: no
                                // Through reentrancy, the value of a can be set such that require condition fails, all previous reentrant calls in the stack will also fail
        require(a<10);          // However for normal non reentrant execution, initial few calls will pass
        a++;                    // But there is no reentrancy-eth as attacker won't get any benefits here
        require(msg.sender.call.value(b)());
    }   

    function non_buggy_require_2() public{ 
                                // reentrancy: yes, reentrancy-eth: no
        a++;
        require(a<10);
        require(msg.sender.call.value(b)());
    }   

    function bug_require_3() public{ 
                                    // reentrancy:yes, reentrancy-eth: yes
                                    // Through reentrancy, value of a can be set such that require always pass
        a++;
        require(msg.sender.call.value(b)());
        require(a<10);
    }

    function bug_require_4() public{ // reentrancy:yes, reentrancy-eth: yes
                                    // this is buggy because require condition might become false after upating a
        require(a<10);              // However, updation of a will be delayed in case of reentrancy
        require(msg.sender.call.value(b)());
        a++;
    }   

    function bug_require_5() public{ // reentrancy: yes, reentrancy-eth: no
        require(msg.sender.call.value(b)());
        require(a<10);
        a++;
    }   

    function bug_require_6() public{ // reentrancy: yes, reentrancy-eth: no
        require(msg.sender.call.value(b)());
        a++;
        require(a<10);
    }   

    // Extract parameters of require before call
    // check if same parameters are updated after require statement
    function bug_require2() public{ // reentrancy: yes, reentrancy-eth: yes
        require(not_called == true && msg.sender.call.value(b)());
        not_called = false;
    }

    function non_buggy_require_3() public{ // reentrancy: yes, reentrancy-eth: no
        require(msg.sender.call.value(b)() && not_called == true );
        not_called = false;
    }

    function bug_require_89() public{ // reentrancy: no, reentrancy-eth: no
        require(msg.sender.call.value(b)() && a < 5 );
        not_called = false;
    }


    function bug_require_single_st() public{  // reentrancy: yes, reentrancy-eth: yes
                        // Buggy but SLither_plus says not buggy
	// a = 6
        require(a++ > 5 && msg.sender.call.value(b)() && a>10);        
    }

    function bug_require_single_st_2() public{  //reentrancy: yes, reentrancy-eth: no
                    // This is buggy because of IR Level
        require(a++ < 10 && msg.sender.call.value(b)()); 
    }


    function non_buggy1() public{ // reentrancy: no, reentrancy-eth: no
        require(msg.sender.call.value(a++)());
    }
   


    function non_buggy_require_6() public{ // reentrancy: no, reentrancy-eth:no
        a = a - 10;
        bool zz = msg.sender.call.value(a)();
        require(zz);
    }

    function require_test() public{ // reentrancy: yes, reentrancy-eth: yes
        not_called = false;
        require(msg.sender.call.value(b)());        
        require(not_called);
    }   

    function require_test_5() public{ // reentrancy: yes, reentrancy-eth: yes
        a = a - 10;
        require(msg.sender.call.value(b)());        
        require(a < 10);
    }


    function bug_require_test_2() public{ // reentrancy: no, reentrancy-eth: no
        require(not_called);
        require(msg.sender.call.value(b)());
        y -= 10;        
    }   
    
    function multi_call() public{ // reentrancy: yes, reentrancy-eth: yes
                                // buggy because c is updated after call
                                // bug doesn't have to do anything with multicall
                                // buggy without require statement
        if(a>10)
            require(msg.sender.call.value(b)());
        require(not_called);
        require(msg.sender.call.value(c)());
        c = c -10;
    }   


    function buggy_require_wbc_2() public{ // reentrancy: yes, reentrancy-eth: yes
                                // c depends on d, d is updated after call
	// x = 12, d = 40
        c = d -10;
        require(msg.sender.call.value(c)());
        if (x > 10) 
            d = d - 5;
    }

    function non_buggy_require_4() public{ // reentrancy: no, reentrancy-eth: no
        c = d -10;
        require(msg.sender.call.value(c)());
    }


    function non_buggy_require_5() public{ // reentrancy: no, reentrancy-eth: no
        if(a>10)
            require(msg.sender.call.value(b)());
        else 
            a = a - 10;
    }    


}
