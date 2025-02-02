pragma solidity 0.4.24;

contract SimpleDAO {
  uint public a;
  uint public b;
  uint public c;
  uint public d;
  uint public e;
  uint public z;
  uint public m;
  uint public n;

  uint public y;
  uint public x;
  uint public w;


  function withdraw_multi_call(address a1, address a2) public { 
            require(a1.call.value(c)());                       
            require(a2.call.value(c)());                        
  }

  function withdraw_for_loop(address[] addr) public { 
        for (a=0; a>10; a++)    {
            require(addr[a].call.value(c)());
        }
    }
  function withdraw_for_loop_1(address[] addr, address a2) public {
        for (a=0; a>10; a++)    {
            require(addr[a].call.value(c)());
        }
            require(a2.call.value(c)());
    }


   function withdraw_while_1() public {  
      while (b > 10)
      {
        c = c - 10;
        require(msg.sender.call.value(c)());
      }
  }

   function withdraw_while_2() public {  
      while (b > 10)
      {
        c = c - 10;
        b = b - 10;
        require(msg.sender.call.value(c)());
      }
  }


   function non_buggy_while_1() public {  
      while (b > 10)
      {
        a = a - 10;
        require(msg.sender.call.value(c)());
      }
  }


   function non_buggy_do_while_1() public {  
      do
      {
        a = a - 10;
        require(msg.sender.call.value(c)());
      } while(b > 10);
  }



   function withdraw_do_while_2() public {
      do
      {
        a = b - 10;
        require(msg.sender.call.value(c)());
      } while(a > 10);
  }



   function buggy_for_1() public { 
      for (b=0; b > 10; b++)
      {
        require(msg.sender.call.value(c)());
      }
  }


}
