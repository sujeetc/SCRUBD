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
  uint public d;
  uint public e;
  uint public z;
  uint public m;
  uint public n;

  uint public y;
  uint public x;
  uint public w;


  function withdraw_multi_call(address a1, address a2) public { // This case is not captured by our tool
            require(a1.call.value(c)());                        // It can be captured easily
            require(a2.call.value(c)());                        // Look out for first call then scan all its son nodes
                                                                // If any of the son contains another call then match a1 and a2 of both
                                                                // If a1 is not equal to a2 then buggy
                                                                  // @ Sujeet: I am not doing this currently because I think its a rare case
  }

  function withdraw_for_loop(address[] addr) public { // Slither: Yes, Our tool: Yes, We are capturing this bug
        for (a=0; a>10; a++)    {
            require(addr[a].call.value(c)());
        }
    }
  function withdraw_for_loop_1(address[] addr, address a2) public { // Slither: Yes, Our tool: Yes, We are capturing this bug
        for (a=0; a>10; a++)    {
            require(addr[a].call.value(c)());
        }
            require(a2.call.value(c)());
    }


   function withdraw_while_1() public {  // Slither: Yes, Our TOol: Yes, Real: Yes
      while (b > 10)
      {
        c = c - 10;
        require(msg.sender.call.value(c)());
      }
  }

   function withdraw_while_2() public {  // Slither: Yes, Our TOol: Yes, Real: Yes
      while (b > 10)
      {
        c = c - 10;
        b = b - 10;
        require(msg.sender.call.value(c)());
      }
  }


   function non_buggy_while_1() public {  // Slither: Yes, Our TOol: No, Real: No
      while (b > 10)
      {
        a = a - 10;
        require(msg.sender.call.value(c)());
      }
  }


   function non_buggy_do_while_1() public {  // Our: no, Slither: Yes, Real: No bug
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



   function buggy_for_1() public {  // Slither: Yes, Our Tool: Yes, Real : Yes
      for (b=0; b > 10; b++)
      {
        require(msg.sender.call.value(c)());
      }
  }


}
