/*
 * @source: http://blockchain.unica.it/projects/ethereum-survey/attacks.html#simpledao
 * @author: Atzei N., Bartoletti M., Cimoli T
 * Modified by Josselin Feist
 */
pragma solidity 0.4.24;

contract SimpleDAO {
    uint public a;
    address public addr_a;
    address public addr_b;
    uint public b;
    uint public c;
    uint public z;
    uint public temp;
    uint public aaaa;
    uint public x;    
    function check_multi_call () public {
        uint alocal = 10;
        msg.sender.call.value(alocal)();
        msg.sender.send(alocal); msg.sender.send(alocal);
        msg.sender.transfer(alocal);
        if(msg.sender.send(alocal))
            alocal = alocal + 10;
        addr_a.send(alocal);
    }
    function check_multi_call_2 () public {
        uint alocal = 10;
        if(a<10)
        {
            addr_a.send(alocal);
        }
        else
            msg.sender.send(alocal);
        addr_a.send(alocal);
    }
    function check_multi_call_3 () public {
        uint alocal = 10;
        if(a<10)
        {
            addr_a.send(alocal);
        }
        else
            msg.sender.send(alocal);
        addr_a.send(alocal);
        msg.sender.send(alocal);
    }

    function check_multi_loop () public {
        uint alocal = 10;
        while(a<10)
        {
            addr_a.send(alocal);
            msg.sender.send(alocal);    
            a++;
        }
    }
    function check_multi_loop_require () public {
        uint alocal = 10;
        while(msg.sender.send(a))
        {
            require(addr_a.send(alocal));    
            a++;
        }
    }

    function check_multi_for_loop () public {
        uint alocal = 10;
        for(a=0; a<10; a++)
        {
            addr_a.send(alocal);
            while(a<10)
                msg.sender.send(a);
            a++;
        }
            msg.sender.send(alocal);    
    }
}