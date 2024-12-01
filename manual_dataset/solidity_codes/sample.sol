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

// Slither-Plus says following functions has reentrancy
// CollectReal(uint256)
// Collect_1(uint256)
// Collect_DD(uint256)
// Collect_khichdi(uint256)
// analyze()
// analyze()
// slither_fn_2()
// slither_fn_5()
// slither_fn_6()
// slithera_13()
// slitherfun3()
// test_writes_within_node()
// withdraw_balances_re_ent8()

    function withdraw_balances_re_ent8 () public {
        // slither-plus:yes
        // check_indirect_cd -- reentrancy.py
        (bool success) = msg.sender.call.value(balances_re_ent8[msg.sender ])("");
        if (success)
            balances_re_ent8[msg.sender] = 0;
    }

    function slither_fn_2 () public { // Real: Yes, Slither: No, Our : Yes
        //slither-plus:yes
        // check_writes_af_call_node -- reentrancy.py
        // check_indirect_cd -- reentrancy.py
        if(msg.sender.call.value(a)() && a++ < 10)
            b = c;
    }

    function slither () public {
        //slither-plus:no
        if(a++<10 && msg.sender.call.value(a)() && a<10)
            b = b + 10;
    }

    function slither_2 () public {
        //slither-plus:no
        if(a++<10)
         msg.sender.call.value(a)();
         if(a<10)
            b +=10;
    }


    function slithera_13 () public {
        // Slither-Plus does not flag this function as buggy if we check for only this function
        // However, it mark it as buggy when checked with other functions also
        //slither-plus: yes
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
        //slither-plus:no
        var acc = Acc[msg.sender];
        msg.sender.call.value(acc.balance)();
    }

    function Collect_DD_1(uint _am) public // Buggy and our tool says its buggy
        //slither-plus:yes
    {
        var acc = Acc[msg.sender];
        msg.sender.call.value(acc.balance)();
        acc.balance -= _am;
    }



        function Collect_DDz(uint _am) public // Buggy and our tool says its buggy
        //slither-plus:yes
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
        //slither-plus:no
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
        //slither-plus:no
        // Not buggy because no state variable is getting updated
        // We checked it in Remix editor
    {
        var b = Bcc[msg.sender];
        Acc[msg.sender].balance = b.balance;
        var acc = Acc[msg.sender];
        msg.sender.call.value(acc.balance)();
        b.balance = b.balance - _am;
    }


    function Collect_2(uint _am) public // TODO: Buggy and Tool also says non Buggy
        //slither-plus:no
    {
        var acc = Acc[msg.sender];
        if(acc.balance >= MinSum && msg.sender.call.value(_am)() && acc.balance >= 20)
            acc.balance -= _am;        
    }


    function Collect_khichdi(uint _am) public 
        //slither-plus:yes
        // check_writes_af_call_node() function -- reentrancy.py
    {
        var acc = Acc[msg.sender];
        b = b + 10;
        if(acc.balance >= MinSum && msg.sender.call.value(acc.balance)() && acc.balance++ >= 20)
            _am -= 10;
    }

    function CollectReal(uint _am) public payable
        // checkWrites -- reentrancy.py
        //slither-plus:yes
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
        //slither-plus:yes
        // check_dd_if -- reentrancy.py
        // check_indirect_cd -- reentrancy.py
    { 
        if(c++ < 10 && msg.sender.call.value(d++)() && b++ < 10)
            d++;
    }

    function test_writes_within_nodez() public 
        //slither-plus:yes
        // check_dd_if -- reentrancy.py
        // check_indirect_cd -- reentrancy.py
    { 
        if(c++ < 10 && msg.sender.call.value(d++)() && b++ < 10)
            d++;
            if(a<10)
               revert();  
    }

    function no_eth() public {
        //slither-plus:no
        if(not_called)
            if( ! (msg.sender.call() ) ){
                revert();
            }
        not_called = false;
    }   

    function withdraw_dd() public {
        //slither-plus:no
        msg.sender.transfer(a);
        a = a - 10;
    }

    function slither_fP_3 () public { // Real: No, Slither: Yes, Our : Yes
        //slither-plus:no
        if(msg.sender.call.value(a)() && b < 10)
            b = b + 10;
    }

    function slither_fP_3z () public { // Real: No, Slither: Yes, Our : Yes
        //slither-plus:no
        if(msg.sender.call.value(a)() && b < 10)
            b = b + 10;
        c = a ;
    }

    function slither_fn_4 () public {
        //slither-plus:no
        if(msg.sender.call.value(z)() &&  msg.sender.call.value(a)())
            b = b + 10;
    }


    function slither_fn_4z () public {
        //slither-plus:no
        if(msg.sender.call.value(z)() &&  msg.sender.call.value(a)())
            z = z +10;
            b = b + 10;
        c =a ;
    }

    function slitherfun1 () public {
        //slither-plus:no
        if(msg.sender.call.value(a)() || b<10)
            b = b - 10;
    }
    function slitherfun2 () public {
        //slither-plus:no
        if(msg.sender.call.value(a)())
            if(b < 10)
                b = b - 10;
    }

    function slitherfun3 () public {
        // slither-plus:yes
        // check_dd_if -- reentrancy.py
        // check_indirect_cd -- reentrancy.py
        if(c++ > 10 && msg.sender.call.value(a)() && b < 10)
            a = a - 10;
    }

    function slither_fn_5 () public { // Real: No, Slither: Yes, Our : Yes
        // slither-plus:yes
        // check_dd_if -- reentrancy.py
        if(b < 10 || msg.sender.call.value(a)())
            b = b + 10;
    }
    function slither_fn_6 () public { // Real: No, Slither: Yes, Our : Yes
        //slither-plus:yes
        if(msg.sender.call.value(a)() || b < 10)
            b = b + 10;
    }
    function analyze() public { // Real:Yes, Slither: Yes, Our: No
        // checkWrites -- reentrancy.py
        // slither-plus:yes
        if(b < 10)
            if(msg.sender.call.value(a)())
                b = b - 10;
    }

}
