pragma solidity ^0.4.24;
contract tool_fail{
    uint public a;
    uint public b;

    function non_buggy_local() public {
        uint local;
        local = a + 10;
        require(msg.sender.call.value(a++)());
    }

    function non_buggy_single_statement() public{
        require(a < 10 && msg.sender.call.value(a++)());
    }

    function non_buggy1() public{
        require(msg.sender.call.value(a++)());
    }

    function buggy_require() public{
        require(msg.sender.call.value(a++)());
        a = a + 1;
        require(a>10);
    }

    function buggy_single_statement_3() public{
        require(b-- < 10 && msg.sender.call.value(a)() && b < 10);
    }

    function buggy_require_2() public{     
                ( msg.sender.call.value(b++ )());
                require(b<10);               
    }

    function buggy_require_3() public{
        b = b - 10;
        msg.sender.call.value(a)();
        require(b<10);
    }

    function buggy_require_4() public{
        b = b - 10;
        require(msg.sender.call.value(a)() && b < 10);
    }

    function non_buggy_require() public{
        require(b-- < 10 && msg.sender.call.value(a)());
    }

}