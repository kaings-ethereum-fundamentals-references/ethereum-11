pragma solidity >=0.6.0 <=0.8.0;

contract Wallet {
    
    struct Token {
        bytes32 ticker;
        address tokenAddress;
    }
    mapping(bytes32 => Token) public tokenMapping;
    bytes32[] public tokenList;
    mapping(address => mapping(bytes32 => uint256)) public balances;

    function addToken(bytes32 _ticker, address _tokenAddress) external {
        tokenMapping[_ticker] = Token(_ticker, _tokenAddress);
        tokenList.push(_ticker);
    }

    function deposit(bytes32 _ticker, uint256 _amt) external {

    }

    function withdraw(bytes32 _ticker, uint256 _amt) external {
        
    }
}