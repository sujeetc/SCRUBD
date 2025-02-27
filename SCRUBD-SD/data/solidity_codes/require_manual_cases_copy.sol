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

    function slither_n31 () public { 
// reentrant calls will set c greater than a and require will always pass, which won't happen in normal non-reentrant scenario
        a = a+10;
        c = c+4;
        msg.sender.call.value(b)();
        require(c>10);
    }

    // we need to think about call and correspond location 
    // can there be bug if require is before call


    function slither_318 () public {
// 1st reason for bug: a is updated after call, call is control dependent on a
        if(a<10)                    // 2nd reason for bug: require has c in it. c is updated after call
        {                           // maybe we can split this example into two buggy cases
            d = a+10;
            msg.sender.call.value(b)();
            if(d<10){
                // msg.sender.call
            }
        }
    }
}
