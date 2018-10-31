ipragma solidity 0.4.19;

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
}
