pragma solidity ^0.4.24;
contract test
{
	uint public b;
	uint public d;
	uint public a;
	uint public c;
	uint public f;
	uint public h;
	uint public g;
	uint public e;
	function buggy() public {
	    if(b<10){
			d++;
	    }
	    else if(c<10)
		    msg.sender.call.value(a)();
	    b++;
	}

	function non_buggy_2() public {
		if(b<10){
			if(d<10)
                b++;
		}
		msg.sender.call.value(a)();
		d++;
	}

	function end_if_counter_example() public {
		if(d > 10)
			if (a > 10)
				msg.sender.call.value(a)();
		else 
			a++;
	}

    function non_buggy4() public { 
        if(b<10){
            d++;
        }
            msg.sender.call.value(a)();
        b++;
    }

    function non_buggy5() public { 
        if(b<10){
            if(d>10)
                b++;
        }
        else 
            msg.sender.call.value(a)();
        d++;
    }

    function buggy6() public {  
        if(d<10){
            if(b>10)
                b++;
        }
        else if (c > 10)
            msg.sender.call.value(a)();
        d++;
    }

    function buggy7() public { 
        if(b<10){
            if(e>10) 
                d = b+10;
            else if(c<10) 
                msg.sender.call.value(a)();
        }
        e = e+10;
    }

    function buggy9() public {
        if(b>10)
            d++;
        else if(c<10){f++;}
        else if(g<10){h++;}
        else msg.sender.call.value(a)();
        b++; 
    }
}