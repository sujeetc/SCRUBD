pragma solidity 0.4.19;

contract SimpleDAO {
    mapping (address => uint) public credit;
    uint public a;
    uint public b;
    uint public c;
    uint public amount;
    mapping (address => uint) userBalance;

    function non_buggy_1() public {
        uint x = credit[msg.sender];
        msg.sender.call.value(c)("");
        credit[msg.sender]-=amount;
    }
    function non_buggy_2() public {
        require(msg.sender.call.value(c)() && credit[msg.sender] < 10);
        credit[msg.sender]-=amount;
    }
    function non_buggy_send() public{
        if( msg.sender.send(a)  && userBalance[msg.sender] > 0) {
            userBalance[msg.sender] = 0;
        }        
    }

    function non_buggy_call() public{
        if( msg.sender.call.value(a)()  && userBalance[msg.sender] > 0) {
            userBalance[msg.sender] = 0;
        }        
    }

    function buggy_multi_call(address a1, address a2) public {
        require(a1 != a2);
        a1.call.value(address(this).balance/2)("");
        a2.call.value(address(this).balance/2)("");
    }

    function non_buggy_single_call(address a1, address a2) public {
        a2.call.value(address(this).balance/2)("");
    }

    function buggy_single_statement() public {
        if(msg.sender.call.value(a)() && a-- < 10)
            b = c;
    }

    function buggy_indirect_control_dep() public {
        if(a > 10)
            b = b - 10;
        msg.sender.call.value(b)("");
        a = a - 10;
    }

    function buggy_withdrawBalance() public{
        if( ! (msg.sender.call.value(userBalance[msg.sender])() ) ){
            revert();
        }
        userBalance[msg.sender] = 0;
    }
}
