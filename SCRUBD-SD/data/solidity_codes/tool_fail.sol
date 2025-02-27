pragma solidity ^0.4.24;
contract tool_fail{
    uint public a;
    uint public b;
    uint public c;
    uint public d;
    uint public e;
    bool public boolean;
    bool public not_called;

function buggy1(uint amount) public{
    if(b<10)
       require(b++<10 && msg.sender.call.value(b)()  );
}


function buggy27(uint amount) public{
        require(not_called);
        if( ! (msg.sender.send(1 ether) ) ){
            revert();
        }
        not_called = false;
}

function buggy3(uint amount) public{
        b = c+1;
        (msg.sender.call.value(b)()  );
        require(b<10);
}

function buggy21(uint amount) public{
        if(d<10)
            c++;
        if( msg.sender.call.value(c)() && d++ < 10 )
            e++;
}

    function non_buggy_case1() public { 
        if(msg.sender.call.value(a)() && b<10) 
            b=b-10; 
    }

    function buggy_case4() public { 
        if(b<10 && msg.sender.call.value(a)()) 
            b=b-10; 
    }

    function buggy_case3() public { 
        if(msg.sender.call.value(a)() && b<10 && msg.sender.call.value(a)() && c > 10) 
            c=b-10; 
    }

    function buggy_case7 () public {
        require(msg.sender.call.value(a)());
        require(msg.sender.call.value(b)() && a++ < 10);
    }

    function buggy1() public{
        if( b < 19 )
            a++;        
        if(msg.sender.call.value(a)() && b++ < 10 )
            c++;
    }

    function buggy_require_wbc_1() public{     
	// b = 8
        (msg.sender.call.value(b++)());
        require(b>11);
    }

function requiredee() public{     
            (msg.sender.call.value(b++)());
            require(b<10);               
        }


    function requirdeepf() public{
        require(b<10);
        ( msg.sender.call.value(b++ ));
    }

    function buggy_case() public{     
            e = d;
            c = d+1;
            msg.sender.call.value(b);
            d = d+1;
            require(c<10);
    }

    function buggy_case2() public{     
        if(d<10)
            e = e+1;
        c = d+1;
        msg.sender.call.value(b);
        d = d+1;
        require(e<10);
    }

    function non_buggy_requirem() public{     
        require(b<10);
        (msg.sender.call.value(b)());
        require(b<10);
    }


    function buggy_local() public{
        uint local;
        local = a + 2  ;
        if(local < 10)
            msg.sender.call.value(b)();
            a += 10;
    }

    function case_1() public{        
        assert(msg.sender.call.value(b)() && a++ < 10 && msg.sender.call.value(a)());
    }

    function buggy_if() public{        
        if(a>10)
            require(msg.sender.call.value(b)() && a++ < 10 && msg.sender.call.value(a)());
    }

    function case_if_2() public{        
        if(a>10)
            require(a++ < 10 && msg.sender.call.value(d)());
    }

    function buggy_require() public{     
            uint local;
            b = b + 10;
            local = b;
            require(msg.sender.call.value(local)() && local > 10);
    }

    function buggy_require_2() public{     

            require(msg.sender.call.value(b++)() && b<10);
    }


    function buggy21() public{
        if(d<10)
            c++;
        if(msg.sender.call.value(c)() && d++<10 )
            e++;
    }

    function buggy_cross_function() public {
        if(msg.sender.call.value(d)() && non_buggy_funct())
            c++;
    }


    function non_buggy_single_statement() public{
        require(msg.sender.call.value(b+c)()    && a<10 );
    }
 
}
