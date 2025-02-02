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


    function non_buggy_single_st_req_1 () public {
            require(msg.sender.call.value(b++)());
    }
    

    function bug_require_22() public{
        a++;
        require(msg.sender.call.value(b)());
        require(a>10);
    }   

    function non_buggy_single_st_req_2 () public { 
        require(a--<10 && msg.sender.call.value(a)());
    }

    function non_buggy_single_st_req_3 () public {
        require(a++<10 && msg.sender.call.value(b)());
    }

    function slither_2b () public {
                                    // parameter of call is updated after call
        require(msg.sender.call.value(a)() && a++<10);
    }

    function non_buggy_single_st_req_4 () public { 
        require(msg.sender.call.value(b)() && a++<10);
    }


    function slither_2 () public { 
        require(a++<10 && msg.sender.call.value(a)() && a<10);
    }

    function non_buggy_1 () public {
            a = a+10;
            require(c>10);
            msg.sender.call.value(b)();
            if(a>50)
                a+=10;
    }

function buggy_require_1 () public { 
    // c = 12, a = 52
    require(c>10);
    a = a+10;
    msg.sender.call.value(b)();
    if(a>50){
        c = c - 4;
    }
}

function slither_3_DD () public { 
    require(c>10);
    c = a+4;
    msg.sender.call.value(b)();
    a = a+10;
}

function non_buggy_require_1 () public { 
    require(y>10);
    z = c+10;
    msg.sender.call.value(b)();
    if(a>50){
        c = c+4;
    }
}

function buggy_require_indirect_cd () public { 
                                // Real BUG
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



function buggy_require_wbc_1 () public {  
    // a = 62, c = 12
    a = a-10;                   // require checks for c, c depends on a, a is updated before call
    msg.sender.call.value(b)(); // c will get updated if reentrant calls set a greater than 50
    require(c>10);              // updation of c will impact require condition
    if(a>50){
        c = c-4;
    }
}

function slither_n31 () public { 
                            // reentrant calls will set c greater than a and require will always pass, which won't happen in normal non-reentrant scenario
                            // BUG, Slither-Plus: No Bug, Slither: No Bug, 
    a = a+10;
    c = c+4;
    msg.sender.call.value(b)();
    require(c>10);
}


// we need to think about call and correspond location 
// can there be bug if require is before call


function buggy_wac_1 () public { 
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


    function Collect_khichdaai(uint _am) public 
    {
        a = a + 10;
        b = a + 1;
        msg.sender.call.value(c)();
        require(a>50);
    }

    function Collect_khichdasai(uint _am) public 
    {
        var acc = Acc[msg.sender];
        acc.balance++;
        msg.sender.call.value(c)();
        require(acc.balance<10);
    }


    function withdraw_call(uint amount) public{
                    require(msg.sender.call.value(amount + a)());
                    a = a - 10;
    }
    function withdraw_conditional(uint amount) public{ 
                    if (a > 10)
                        require(msg.sender.call.value(amount + b)());
                    a = a - 10;
    }
    function buggy_indirect_dep_1() public {
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
                        // bug exists without require also
        if(b<10)
        {
            require(msg.sender.call.value(a)());
            b = b-10;
        }
    }




    function bug_require_1() public{ 
                                // Through reentrancy, the value of a can be set such that require condition fails, all previous reentrant calls in the stack will also fail
        require(a<10);          // However for normal non reentrant execution, initial few calls will pass
        a++;                    // But there is no reentrancy-eth as attacker won't get any benefits here
        require(msg.sender.call.value(b)());
    }   

    function non_buggy_require_2() public{ 
        a++;
        require(a<10);
        require(msg.sender.call.value(b)());
    }   

    function bug_require_3() public{ 
                                    // Through reentrancy, value of a can be set such that require always pass
        a++;
        require(msg.sender.call.value(b)());
        require(a<10);
    }

    function bug_require_4() public{ 
                                    // this is buggy because require condition might become false after upating a
        require(a<10);              // However, updation of a will be delayed in case of reentrancy
        require(msg.sender.call.value(b)());
        a++;
    }   

    function bug_require_5() public{ 
        require(msg.sender.call.value(b)());
        require(a<10);
        a++;
    }   

    function bug_require_6() public{ 
        require(msg.sender.call.value(b)());
        a++;
        require(a<10);
    }   

    // Extract parameters of require before call
    // check if same parameters are updated after require statement
    function bug_require2() public{ 
        require(not_called == true && msg.sender.call.value(b)());
        not_called = false;
    }

    function non_buggy_require_3() public{ 
        require(msg.sender.call.value(b)() && not_called == true );
        not_called = false;
    }

    function bug_require_89() public{ 
        require(msg.sender.call.value(b)() && a < 5 );
        not_called = false;
    }


    function bug_require_single_st() public{  // buggy
	// a = 6
        require(a++ > 5 && msg.sender.call.value(b)() && a>10);        
    }

    function bug_require_single_st_2() public{  
                    // This is buggy because of IR Level
        require(a++ < 10 && msg.sender.call.value(b)()); 
    }


    function non_buggy1() public{
        require(msg.sender.call.value(a++)());
    }
   


    function non_buggy_require_6() public{ 
        a = a - 10;
        bool zz = msg.sender.call.value(a)();
        require(zz);
    }

    function require_test() public{ 
        not_called = false;
        require(msg.sender.call.value(b)());        
        require(not_called);
    }   

    function require_test_5() public{ 
        a = a - 10;
        require(msg.sender.call.value(b)());        
        require(a < 10);
    }


    function bug_require_test_2() public{ 
        require(not_called);
        require(msg.sender.call.value(b)());
        y -= 10;        
    }   
    
    function multi_call() public{ 
                                // buggy because c is updated after call
                                // bug doesn't have to do anything with multicall
                                // buggy without require statement
        if(a>10)
            require(msg.sender.call.value(b)());
        require(not_called);
        require(msg.sender.call.value(c)());
        c = c -10;
    }   


    function buggy_require_wbc_2() public{ 
                                // c depends on d, d is updated after call
	// x = 12, d = 40
        c = d -10;
        require(msg.sender.call.value(c)());
        if (x > 10) 
            d = d - 5;
    }

    function non_buggy_require_4() public{ 
        c = d -10;
        require(msg.sender.call.value(c)());
    }


    function non_buggy_require_5() public{ 
        if(a>10)
            require(msg.sender.call.value(b)());
        else 
            a = a - 10;
    }    


}
