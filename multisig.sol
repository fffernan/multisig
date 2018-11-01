pragma solidity 0.4.19;

contract MultiSig {
  address[] public owners;
  uint256 public required;

  struct Transaction {
    address destinationAddress;
    uint256 valueInWei;
    bool transactionStatus;
  }
  uint256 public transactionCount; 
  mapping (uint=>Transaction) public transactions;
  mapping (uint=>mapping(address=>bool)) public confirmations;

  modifier handleEdgeCases(address[] _owners, uint _required) {
    require(_owners.length > 0);
    require(_required > 0);
    require(_required <= _owners.length);
    _;
  }

  function MultiSig(address[] _owners, uint256 _required) handleEdgeCases(_owners, _required) public {
    owners = _owners;
    required = _required;
  }

  function addTransaction(address _dest, uint256 _value) public returns (uint256) {
    require(_dest != address(0));

    transactions[transactionCount] = Transaction (
      _dest, _value, false
    );

    transactionCount++;
    return transactionCount - 1;
  }  

  function confirmTransaction(uint txId) public {
    confirmations[txId][msg.sender] = true;

  }

  function getConfirmations(uint _transactionId) public view returns(address[] memory confirmators) {
    uint count = 0;
    for (uint j = 0; j<owners.length; j++) {
      if (confirmations[_transactionId][owners[j]]) {
        count ++;
      }
    }
    confirmators = new address[](count);
    uint ind = 0;
    for (uint i = 0; i<owners.length; i++) {
      if (confirmations[_transactionId][owners[i]]) {
        confirmators[ind++] = owners[i];
      }
    }
 
  }
}