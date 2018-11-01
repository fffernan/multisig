pragma solidity 0.4.19;

contract MultiSig {
  address [] public owners;
  uint256 public required;

  modifer handleEdgeCases(address[] _owners, unit _required){
    require(_owners.length> 0)
    require(require > 0);
    require(_required <= _owners.length);
    owners = _owners;
    required = _required;
    _;  // checks requirements and then runs the code
  }
}