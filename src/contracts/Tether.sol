// SPDX-License-Identifier: MIT 
pragma solidity >= 0.5.0 < 0.9.0;

contract Tether {
  string public name = 'Tether';
  string public symbol = 'USDT';
  uint256 public totalSupply = 1000000000000000000000000; // 1 million tokens
  uint8 public decimals = 18;
  
  // transfer 함수에 대한 이벤트 (logging 및 이벤트 수신을 위해 선언)
  event Transfer (
    address indexed _from,
    address indexed _to,
    uint _value
  );

  // approve 함수에 대한 이벤트 (logging 및 이벤트 수신을 위해 선언)
  event Approve(
    address indexed _owner,
    address indexed _spender,
    uint _value
  );

  // balanceOf totalSupply에서 address를 엮어 사용하기 위해 mapping
  mapping(address => uint256) public balanceOf;

  // 총 공급량을 초기화하기 위해 생성자 선언
  constructor() public {
    balanceOf[msg.sender] = totalSupply;
  }
  
  // 테더를 전환 함수
  function transfer(address _to, uint _value) public returns (bool success) {
    // 발송할 값이 기존의 잔액보다 부족한 경우 실패처리
    require(balanceOf[msg.sender] >= _value);
    // 수량 전송 후 잔액 감소
    balanceOf[msg.sender] -= _value;
    // 수량 수신자에게 추가
    balanceOf[_to] += _value;
    // Transfer 이벤트에 데이터 저장
    emit Transfer(msg.sender, _to, _value);
    return true;
  }
}