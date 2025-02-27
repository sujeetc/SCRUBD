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

  function non_reentrant() public{ // Real: No Bug
    if(d==0){
      d=1;
      require(msg.sender.call.value(a)());}
    else {
      revert();
    }
    d = 0;
  }


  function withdraw_call(uint amount) public {
    if ( c > 5 )
	    d = d + 5;
    require(msg.sender.call.value(amount + a)());
		d = d - 5;
    if ( a >= amount ) {
      a -= amount;
    }
	  b = b - 10;
  }

  function withdraw_call_2(uint amount) public{
    require(msg.sender.call.value(amount + e)());
    e = e + 10;
  }


   function withdraw_call_3(uint amount) public{
    a = a + 10;
   if ( c > 5) {
              c = d + 5;
	            amount = c + d;
              require(msg.sender.call.value(amount)());
            }
          else {
                d = d - 5;
            }
            if (a > 10)
              e = e + 10;
            else
              z = z + 45;
            c = c + 10;


  }

  function withdraw_call_3z(uint amount) public{
    a = a + 10;
   if ( c > 5) {
              c = d + 5;
	            amount = c + d;
              require(msg.sender.call.value(amount)());
            }
          else {
                c = c + 10;
                d = d - 5;
            }
            if (a > 10)
              e = e + 10;
            else
              z = z + 45;
            c = c + 10;


  } 

   function withdraw_call_if() public { 
              if (a > 10)
		  a = a + 10;
	      else if (b < 10)
	      {
		  d = d - 10;
                  require(msg.sender.call.value(c)());
	      }
              a = a + 10;
  } 

  function withdraw_call_ifz() public { 
	      b = a + 10;
	      a = a + 10;
              if (a > 10)
		  a = a + 10;
	      else if (b < 10)
	      {
		  d = d - 10;
                  require(msg.sender.call.value(c)());
	      }
              a = a + 10;
  } 

  function withdraw_call_else() public {
    if (a > 10)
      a = a - 10;
    else
      require(msg.sender.call.value(c)());
  }





   function buggy_multi_dep() public {
   // b depends on z, z depends on a, a depends on e, e depends on x, x is updated after call, so its buggy
    b = z;
    c = m;
    
    if (c >  10)
    {
      m = m - 10;
      e = e + 10;
      y = y + 10;
      if (x > 10) {
        w = w + 10;

        if (x > 10)
          e = e +1;
      }
    }
    else if (a > 10)
    {
      d = d + 10;
      z = z + 10;
    }
    else if (z > 10)
    {
      y = y +10;
    }
    else if (e > 10)
      c = c + 10;
    else
      a = a + 10;
    // n = 1; 
    if (n > 10)
    {
        m = x - 10;
        bool success = msg.sender.call.value(b)();
        if (!success) {
            revert();
        }
        x = x - 10;
    }
  }



  function buggy_require_1() public {
     // a = 12, d = 8,
     if(a > 10){
       if (d > 10)
          b = b - 10;
     }
    require(msg.sender.call.value(b)());
    d = d + 10;
   }



    function non_buggy_1() public {
    c = a + 10;
     if(c > 10){
       d = b - 10;
     }
     b = d + 10;
     require(msg.sender.call.value(b)());
     a = a - 10;
   } 

    function test() public {
     b = a;
     require(msg.sender.call.value(b)());
     a = a;
   } 


   function testzz() public {
      z = a;
      if (z > 10)
        b = b - 10;
     b = a;
     require(msg.sender.call.value(b)());
     a = a;
   } 


   function testz() public {
     b = a;
     require(msg.sender.call.value(b)());
     a = a;
     if (c > 10)
        a = a - 1;
      z = a;
   } 


function testzzz() public {
      z = a;
      if (z > 10)
        b = b - 10;
     b = a;
     require(msg.sender.call.value(b)());
     a = a;

     if (c > 10)
        a = a - 1;
      z = a;
   } 

  
   // 1. Parameters of if is data dependent on variables updated after call
   // 2. Parameter to call is data dependent on updates inside if block

   // Create a data structure for parameters of if: [node: set(variables)]
   // Create a data structure for parameters of call: [node: set(variables)]




  function withdraw_while_loop() public {
      if (c > 10)
      {
          a = a + 20;
          c = d - 10;
      }
          require(msg.sender.call.value(b)());

          c = a + 10;
  }


  function withdraw_while_loopz() public {
      b = a + 10;
     c = a + 10;
      if (c > 10)
      {
          a = a + 20;
          c = d - 10;
      }
          require(msg.sender.call.value(b)());

          c = a + 10;
  }


  function withdraw_call_4() public {
                d = a +10;
		            c = d + 20;
                require(msg.sender.call.value(c)());
              a = d + 10;
  }
  function withdraw_call_5() public {
	  if(a> 10)
                require(msg.sender.call.value(c)());
	  if(a<=10)
                c = d + 10;
  }

  function withdraw_send(uint amount) public{
    if (a>= amount) {
      require(msg.sender.send(amount + a));
      a -= amount;
    }
	b = b - 10;
  }


  function withdraw_transfer(uint amount) public{
    if (a>= amount) {
      msg.sender.transfer(amount + a);
      a -= amount;
    }
	b = b - 10;
  } 

}