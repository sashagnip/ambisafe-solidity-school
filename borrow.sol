pragma solidity ^0.4.0;
contract Borrow {
    struct Debt {
        address from;
        address to;
        bytes32 info;
        bool is_active;
    }

    uint lastDebtId;
    mapping(uint => Debt) debts;

    function createDebt(address _to, bytes32 _info) public returns (uint thisId) {
        thisId = lastDebtId++;
        debts[thisId] = Debt(msg.sender, _to, _info, true);
    }
    
    function destroyDebt(uint _id) public returns (bool result){
        if (_id < 0 || _id > lastDebtId) return false;
        if (debts[_id].to != msg.sender) return false;
        debts[_id].is_active = false;
        return true;
    }
}