pragma solidity ^0.5.0;

contract Tether {
    string public name = 'Tether';
    string public symbol = 'USDT';
    uint256 public totalSupply = 1000000000000000000000000; // 1 MILLION TOKENS
    uint8 decimals = 18;

    event Transfer {
        address indexed _from,
        address indexed _to,
        uint _value
    };

    event Approve {
        address indexed _owner,
        address indexed _spender,
        uint _value
    };

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint256 _value) public returns (bool success){
        // require that the value is greater than or equal to the transfer
        require(balanceOf[msg.sender] >= _value);         
        // transfer the amount and subtract the balance
        balanceOf[msg.sender] -= _value;
        // add the balance 
        balanceof[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true; 
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require((_value >= balanceOf[_from]));
        require((_value <= allowance[_from][msg.sender]));
        
        balanceOf[_to] += _value;    
        
        balanceof[_from] -= _value; 

        allowance[msg.sender][_from] -= _value;

        emit Transfer(_from, _to, _value);

        return true; 
    };
}
