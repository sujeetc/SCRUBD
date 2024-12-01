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
    uint public z;
    uint public temp;
    uint public aaaa;
    uint public x;    
    struct Holder   
    {
        uint unlockTime;
        uint balance;
    }
    mapping (address => Holder) public Acc;
    mapping (address => Holder) public Bcc;

    function check_if () public {
            //slither-plus:no
            if(b<10)
                msg.sender.call.value(a)();
            b = b - 10;
    }

    function indirect_control_dep_ref () public {
        var acc = Acc[msg.sender];
        // var bcc = Bcc[msg.sender];
        // if(acc.balance > 10){
        //    bcc.balance = bcc.balance - 10;
        // }
        msg.sender.call.value(acc.balance)();
        acc.balance++;
    }

function indirect_control_dep_ref2() public {
        var acc = Acc[msg.sender];
        var bcc = Bcc[msg.sender];
        if(acc.balance > 10){
           bcc.balance = bcc.balance - 10;
        }
        msg.sender.call.value(acc.balance)();
        acc.balance++;
    }

    function require_wbc_1 () public {
	// b=30
        uint local_temp=15;
        b = b - 10;
        msg.sender.call.value(a)();
        c = b + 5;
        if(c<10)
            local_temp = local_temp-10;
        require(local_temp<10);
    }

    function require_wbc_2 () public {
	// z =25
	// b = 10
	// temp = x = 15
        z = z - 10;
        msg.sender.call.value(aaaa)();
        if (z<10)
            b = b - 10;
        c = b + 5;
        if (c<10)
            temp = temp - 10;
        if (temp < 10)
            x = x - 10;
        require (x < 10);
    }

    function require_wbc_3 () public {
	    // b = c = 25 
            uint clocal;
            b = b - 10;
            msg.sender.call.value(a)();
            if(b<10)
                c = c - 10;
            clocal =  c - 10;
            require(clocal<10);
        }

        function require_wbc_4 () public {
            uint clocal;
            //slither-plus:no
            b = b - 10;
            msg.sender.call.value(a)();
            if(b<10)
                c = c-10;
            clocal =  c - 90;
            c = b -10;
            require(clocal<10);
        }

    function Collect_2(uint _am) public 
        //slither-plus:no
    {
        if(a<10)
            b++;
        if(b<10) 
            msg.sender.call.value(_am)();
        a = a+1;
        // if(acc.balance >= MinSum && msg.sender.call.value(_am)() && acc.balance >= 20)
        //     acc.balance -= _am;
    }

    function buggy_Collect_2(uint _am) public
        //slither-plus:no
    {
        // var acc = Acc[msg.sender];
        if(a<10 && msg.sender.call.value(_am)())
            a = a+1;
        // if(acc.balance >= MinSum && msg.sender.call.value(_am)() && acc.balance >= 20)
        //     acc.balance -= _am;
    }



function Collect_222(uint _am) public 
        //slither-plus:no
    {
        var acc = Acc[msg.sender];
        if(a<10)
            b++;
        if(b<10) 
            msg.sender.call.value(_am)();
        a = a+1;
        if(acc.balance >= MinSum && msg.sender.call.value(_am)() && acc.balance >= 20)
            acc.balance -= _am;
    }


function Collect_23(uint _am) public // Non Buggy and Tool also says non Buggy
        //slither-plus:no
        {
            var acc = Acc[msg.sender];
            if(a<10 && msg.sender.call.value(_am)())
                a = a+1;
            if(acc.balance >= MinSum && msg.sender.call.value(_am)() && acc.balance >= 20)
                acc.balance -= _am;
        }

        function Collect_12(uint _am) public // Non Buggy and Tool also says non Buggy
        //slither-plus:no
        {
            if(a<10 && msg.sender.call.value(_am)() && a++<10)
                b = b+1;
        }

    function slither_31 () public { // reentrancy: yes, reentrancy-eth: yes
// slither-plus: no
// only one non-reentrant call will pass, others will fail
// in case of reentrancy, all calls will pass
        if(a>50) {                  // Slither: Yes, Our: No, Real: Yes
            c = c-10;
        }
        msg.sender.call.value(b)();
        a = a+50;
        require(c>10);
    }

        function indirect_control_dep_1() public {
	  // a = 5
          if(a > 10){
            b = b - 10;
          }
          require(msg.sender.call.value(b)());
          a = a + 10;
        }

    function slither_dd () public { // reentrancy: yes, reentrancy-eth: yes
        msg.sender.call.value(b)();
        b = b+50;
    }

    function slither_dd_if () public { // reentrancy: yes, reentrancy-eth: yes
        if (msg.sender.call.value(b)())
            b = b+50;
    }

        function test_call(uint _am) public // Non Buggy and Tool also says non Buggy
        //slither-plus:no
        {
            if(msg.sender.call.value(a)() && a++<10)
                b = b + 1;
            // if(acc.balance >= MinSum && msg.sender.call.value(_am)() && acc.balance >= 20)
            //     acc.balance -= _am;
        }


        function test_call2(uint _am) public // Non Buggy and Tool also says non Buggy
        //slither-plus:no
        {
            var acc = Acc[msg.sender];
            if(msg.sender.call.value(a)() && a++<10)
                b = b + 1;
            if(acc.balance >= MinSum && msg.sender.call.value(_am)() && acc.balance >= 20)
                acc.balance -= _am;
        }


        
    function for_case_1() public { 
        // if(b < 10)
            for (z=0;z<10;z++)
                msg.sender.call.value(a)();
        b = b - 10;
    }

    function for_case_2() public { 
	// b = 5
        if(b < 10)
            for (z=0;z<10;z++)
                msg.sender.call.value(a)();
        b = b + 10;
    }

    function fun_1 () public {  // NON Buggy
         if(b<10 && msg.sender.call.value(a)() && b-- < 10)
         {
                 c = c - 10;
         }
    }
    uint public MinSum;

    function Collect_1(uint _am) public // Buggy but our tool says its not buggy
    {
        var acc = Acc[msg.sender];
        if( acc.balance>=MinSum && msg.sender.call.value(acc.balance)() && now>acc.unlockTime)
            acc.balance-=_am;        
    }

    function Collect_21(uint _am) public 
        //slither-plus:yes
    {
        var acc = Acc[msg.sender];
        if(acc.balance >= MinSum && msg.sender.call.value(_am)() && acc.balance++ >= 20)
            acc.balance -= _am;        
    }
    
    mapping(address => uint) balances_re_ent8;
    function dd_wac_1 () public {
        // slither-plus:yes
        // check_indirect_cd -- reentrancy.py
        msg.sender.call.value(balances_re_ent8[msg.sender ])("");
        balances_re_ent8[msg.sender] = 0;
    }
    function Collect_21_updated(uint _am) public
        //slither-plus:no
    {
        var acc = Acc[msg.sender];
        if(a >= MinSum && msg.sender.call.value(_am)() && a++ >= 20)
            a -= _am;
    }

    function Collect_khichdi(uint _am) public 
        //slither-plus:yes
        // check_writes_af_call_node() function -- reentrancy.py
    {
        b = b + 10;
        if(msg.sender.call.value(a)() && a++ >= 20)
            _am -= 10;
    }

    function check_dd(uint _am) public // Buggy and tool says Buggy
    {
        msg.sender.call.value(a)();
        a -= _am;        
    }

    function check_dd_local(uint _am) public // Buggy and tool says Buggy
    {
        uint alocal = 10;
        uint blocal = 20;
        uint clocal = 30;
        msg.sender.call.value(alocal + blocal + c)();
        b = b - 10;
        alocal = b - blocal; 
        b = alocal + blocal;      
    }
    


    function check_cd_local(uint _am) public // Buggy and tool says Buggy
    {
        uint alocal = 10;
        uint blocal = 20;
        uint clocal = 30;
        msg.sender.call.value(alocal + blocal + c)();
        b = b - 10;
        alocal = b - blocal; 
        b = alocal + blocal;      
        if(alocal<10)
            clocal = clocal+10;
        if(blocal<10)
            alocal = alocal + 10;
        if(clocal<30)
            blocal = blocal + 20;
    }

    modifier mod_slither_dd () {
        _;
        require(msg.sender.call.value(b)());
        b = b+50;
    }

    function update_var() public mod_slither_dd {
        // b = c + 10;
        c = c - 10;
	    require(b==c);
    }

    function update_var2() public mod_slither_dd {
        b = c + 10;
        c = c - 10;
	require(b==c);
    }

    constructor() public{
        require(b==c);
    }

 function check_writes_within_call_node_require(uint _am) public {
	//  a = 21
	if(a > 20)
	require(msg.sender.call.value(b)() && a-- >= 5);
	z++;
   }

    function check_writes_af_call_node(uint _am) public
        //slither-plus:no
    {
        if(msg.sender.call.value(a)() && a++ >= 20)
            b -= _am;
    }

    function check_writes_within_call_node(uint _am) public
    {
	// a =  21
        if(a >= 20)
            if(msg.sender.call.value(b)() && a++ >= 5)
            {
                z ++;
            }
    }
    function analyze() public { // Real:Yes, Slither: Yes, Our: No
        // checkWrites -- reentrancy.py
        // slither-plus:yes
        if(b < 10)
            if(msg.sender.call.value(a)())
                b = b - 10;
    }

    function check_control_dep_unsafe() public {
	// a = 5
        if(a > 10)
            b = b - 10;
        msg.sender.call.value(b)();
        a = a + 10;
    }

    function check_control_dep_safe() public {
        if(a > 10)
            b = b - 10;
        msg.sender.call.value(c)();
        a = a - 10;
    }

    function checkWrites_unsafe_1() public { 
        if(b < 10)
            if(msg.sender.call.value(a)())
                b = b - 10;
    }

    function checkWrites_safe() public { 
        c = b + 10;
        if(z < 10)
            if(msg.sender.call.value(a)())
                c = c - 10;
        b = b - 10;
    }

    function unsafe_process_require_assert_wbc(uint) public // reentrancy: yes, reentrancy-eth: yes
    {
        a = a + 10;
        msg.sender.call.value(b)();
        require(a>50);
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

    function non_buggy_1() public {
        if(b<10 && msg.sender.call.value(a)())
        {
                b = c;
        }
    }

    function call_within_if_dd() public {  // Buggy
        if(b<10 && msg.sender.call.value(a)())
        {
                a = c;
        }
    }

    function non_buggy_call_within_if_1() public {  // Non Buggy
        if(b<10 && msg.sender.call.value(a)() && c<10)
        {
                c = c+10;
        }
    }
}
