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



 
    function bug_revert_test_1() public{ // BUG: YES
        if(not_called == false)
        {
               revert();
        }
        msg.sender.call.value(b)();

        not_called = false;        
    }   

    function bug_return_test() public{ // BUG: YES
        if(not_called == false)
        {
               return;
        }
        msg.sender.call.value(b)();

        not_called = false;        
    }   


    function bug_revert_test_4() public{  // NO BUG
        msg.sender.call.value(b)();

        if(not_called == false)
        {
               revert();
        }

        not_called = false;        
    }   

    function bug_revert_test_5() public{  // NO BUG
        if(not_called == false)
        {
            
            revert();
        }

        not_called = false;        
        msg.sender.call.value(b)();
    }   


    function revert_test_20_rq() public{ // BUG PRESENT                                     
            if(b<10)
               require(x++ > 10 && a++ > 10);
            msg.sender.call.value(c)();
            if(a<10)
               revert();  
    }   


    function revert_test_20() public{ // BUG PRESENT                                     
            if(b<10)
               a = a + 10;
            msg.sender.call.value(c)();
            if(a<10)
               revert();  
    }   


    function revert_test_ddd() public{ // BUG 
            // if(b<10)
               b = b + 10;
            msg.sender.call.value(c)();
            a = b + 10;
            if(a<10)
               revert();  
            // b++;          
    }   


    function bug_revert_test_2() public{ // BUG EXISTS, revert condition true or fail depends on a, it might be true if checked before updating a
            a = a + 10;            
            msg.sender.call.value(b)();
            if(a<10)
               revert();            
    }   


    function bug_revert_test_10() public{ // BUG EXISTS, revert condition true or fail depends on a, it might be true if checked before updating a
            if(a<10)
               revert();            
            msg.sender.call.value(b)();
            a = a + 10;
    }   


            

    function bug_revert_test_11() public{ // Not buggy
            if(a<20){
                revert();
                msg.sender.call.value(b)();
            }
            a = a + 10;
    }  



    function bug_revert_test_6() public{ // no bug
            msg.sender.call.value(b)();
            
            if(a<10)
               revert();            
            a = a + 10;
    }   

    function bug_revert_test_6_2() public{ 
            c = c - 10;
            msg.sender.call.value(b)();
            
            if(a<10)
               revert();            
            if (c > 10) 
                a = a + 10;
    }   



    function bug_revert_test_7() public{  // no bug
            a = a + 25;
            if(a<50)
               revert();            
            msg.sender.call.value(b)();
    }   


    function bug_revert_test_3() public{ 
        if(not_called == false)
        {
            msg.sender.call.value(b)();
            if(a<10)
               revert();
            a = a-10;
        }
    }   

    function bug_revert_test_3z() public{ 
        if(not_called == false)
        {
            msg.sender.call.value(b)();
            if(a<10)
               revert();
            a = a-10;
        }
        msg.sender.call.value(b)();
        not_called = false;        
    }   
}