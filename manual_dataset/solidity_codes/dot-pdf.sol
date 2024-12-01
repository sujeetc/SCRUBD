pragma solidity 0.4.24;

contract SimpleDAO {
    struct Holder   
    {
        uint unlockTime;
        uint balance;
    }
    mapping (address => Holder) public Acc;
    uint public x;
    uint public a;
    uint public b;
    uint public c;

    function simple() public
    {
    var acc = Acc[msg.sender];
    if(msg.sender.call.value(acc.balance)() && acc.balance++ + x<10)
        x = x + 10;
    }

    function non_buggy_multi_call_if_1() public
    {
        if(msg.sender.call.value(a)() && b++ < 10 && msg.sender.call.value(b++)()) //1==1 ? b++ < 10: 0 < 10)
            x = x + 10;
    }

    function buggy_multi_call_if_2() public
    {
        if(msg.sender.call.value(a)() && b++<10 && msg.sender.call.value(b++)() && 1==1 ? b-- < 10: 0 < 10)
            x = x + 10;
    }

    function buggy_multi_call_if_3() public
    {
        if(a++ < 10 && msg.sender.call.value(b)() && a++ + b < 10 && 1==1 ? b-- < 10: 0 < 10)
            x = x + 10;
    }

    function non_buggy_multi_call_if_2() public
    {   
        if(msg.sender.call.value(a)() && b++<10 && msg.sender.call.value(b++)() && 1==1 ? c-- < 10: 0 < 10) 
            x = x + 10; 
    }   

    function non_buggy_multi_call_if_3() public
    {   
        if(a++ < 10 && msg.sender.call.value(c)() && a++ + b < 10 && 1==1 ? b-- < 10: 0 < 10) 
            x = x + 10; 
    }   


    function buggy_simple_require() public
    {
	// x = acc.balance = 4
        var acc = Acc[msg.sender];
        require(msg.sender.call.value(acc.balance++)() && acc.balance + x > 10);
    }

}
