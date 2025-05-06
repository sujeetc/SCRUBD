pragma solidity 0.4.24;

contract SimpleDAO {
  uint public a;
  uint public b;
  uint public c;
  uint public d = 0;
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


    function withdraw_balances_re_ent8 () public {
        (bool success) = msg.sender.call.value(balances_re_ent8[msg.sender ])("");
        if (success)
            balances_re_ent8[msg.sender] = 0;
    }

    function slither_fn_2 () public { 
        if(msg.sender.call.value(a)() && a++ < 10)
            b = c;
    }

    function non_buggy_cif () public { // cif - call inside if condition
        if(a++<10 && msg.sender.call.value(a)() && a<10)
            b = b + 10;
    }

    function slither_2 () public {
        if(a++<10)
         msg.sender.call.value(a)();
         if(a<10)
            b +=10;
    }


    function slithera_13 () public {
        a = a + 10;
        if(c > 10)
            msg.sender.call.value(b)();
        if(a > 50)
            a += 10;
    }


    struct Holder   
    {
        uint unlockTime;
        uint balance;
    }
    mapping (address => Holder) public Acc;
    mapping (address => Holder) public Bcc;

    uint public MinSum;
    mapping(address => uint) balances_re_ent8;

    function Test(uint _am) public {
        var acc = Acc[msg.sender];
        msg.sender.call.value(acc.balance)();
    }

    function Collect_DD_1(uint _am) public
    {
        var acc = Acc[msg.sender];
        msg.sender.call.value(acc.balance)();
        acc.balance -= _am;
    }



        function Collect_DDz(uint _am) public
    {
        var acc = Acc[msg.sender];
        msg.sender.call.value(acc.balance)();
        msg.sender.call.value(Acc[msg.sender].balance)();
        if(acc.balance>=MinSum && msg.sender.call.value(acc.balance)() && now>acc.unlockTime)
        acc.balance -= _am;
    }

    function Collect_local_var(uint _am) public 
    {
        uint x = a;
        msg.sender.call.value(x)();
        a=a-10;
    }

    function Collect_uoiu(uint _am) public 
        // Not buggy because no state variable is getting updated
        // We checked it in Remix editor
    {
        var b = Bcc[msg.sender].balance;
        Acc[msg.sender].balance = b;

        var acc = Acc[msg.sender];
        msg.sender.call.value(acc.balance)();
        b = b - 5;
    }

    function Collect_uoiuz(uint _am) public 
        // Not buggy because no state variable is getting updated
        // We checked it in Remix editor
    {
        var b = Bcc[msg.sender];
        Acc[msg.sender].balance = b.balance;
        var acc = Acc[msg.sender];
        msg.sender.call.value(acc.balance)();
        b.balance = b.balance - _am;
    }


    function Collect_2(uint _am) public
    {
        var acc = Acc[msg.sender];
        if(acc.balance >= MinSum && msg.sender.call.value(_am)() && acc.balance >= 20)
            acc.balance -= _am;        
    }


    function Collect_khichdi(uint _am) public 
    {
        var acc = Acc[msg.sender];
        b = b + 10;
        if(acc.balance >= MinSum && msg.sender.call.value(acc.balance)() && acc.balance++ >= 20)
            _am -= 10;
    }

    function CollectReal(uint _am) public payable
    {
        var acc = Acc[msg.sender];
        if(acc.balance >= MinSum && acc.balance >= _am && now > acc.unlockTime)
        {
            // <yes> <report> REENTRANCY
            if(msg.sender.call.value(_am)())
            {
                acc.balance -= _am;
            }
        }
    }

    function test_writes_within_node() public 
    { 
        if(c++ < 10 && msg.sender.call.value(d++)() && b++ < 10)
            d++;
    }

    function test_writes_within_nodez() public 
    { 
        if(c++ < 10 && msg.sender.call.value(d++)() && b++ < 10)
            d++;
            if(a<10)
               revert();  
    }

    function no_eth() public {
        if(not_called)
            if( ! (msg.sender.call() ) ){
                revert();
            }
        not_called = false;
    }   

    function withdraw_dd() public {
        msg.sender.transfer(a);
        a = a - 10;
    }

    function slither_fP_3 () public {
        if(msg.sender.call.value(a)() && b < 10)
            b = b + 10;
    }

    function slither_fP_3z () public {
        if(msg.sender.call.value(a)() && b < 10)
            b = b + 10;
        c = a ;
    }

    function slither_fn_4 () public {
        if(msg.sender.call.value(z)() &&  msg.sender.call.value(a)())
            b = b + 10;
    }


    function slither_fn_4z () public {
        if(msg.sender.call.value(z)() &&  msg.sender.call.value(a)())
            z = z +10;
            b = b + 10;
        c =a ;
    }

    function slitherfun1 () public {
        if(msg.sender.call.value(a)() || b<10)
            b = b - 10;
    }
    function slitherfun2 () public {
        if(msg.sender.call.value(a)())
            if(b < 10)
                b = b - 10;
    }

    function slitherfun3 () public {
        if(c++ > 10 && msg.sender.call.value(a)() && b < 10)
            a = a - 10;
    }

    function slither_fn_5 () public {
        if(b < 10 || msg.sender.call.value(a)())
            b = b + 10;
    }
    function slither_fn_6 () public {
        if(msg.sender.call.value(a)() || b < 10)
            b = b + 10;
    }
    function analyze() public {
        if(b < 10)
            if(msg.sender.call.value(a)())
                b = b - 10;
    }

}