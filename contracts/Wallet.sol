pragma solidity >=0.6.0 <=0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../node_modules/@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Wallet {
    using SafeMath for uint256;

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
        require(tokenMapping[_ticker].tokenAddress != address(0), "Token does not exist!!!!!");
        IERC20(tokenMapping[_ticker].tokenAddress).transferFrom(msg.sender, address(this), _amt);   // `transferFrom` function of ERC20
        balances[msg.sender][_ticker] = balances[msg.sender][_ticker].add(_amt);
    }

    function withdraw(bytes32 _ticker, uint256 _amt) external {
        require(tokenMapping[_ticker].tokenAddress != address(0), "Token does not exist!!!!!");
        require(balances[msg.sender][_ticker] >= _amt, "Balance not sufficient!!!!!");
        balances[msg.sender][_ticker] = balances[msg.sender][_ticker].sub(_amt);
        IERC20(tokenMapping[_ticker].tokenAddress).transfer(msg.sender, _amt);                      // `transfer` function of ERC20
    }
}