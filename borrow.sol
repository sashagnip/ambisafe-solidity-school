pragma solidity ^0.4.0;
contract Borrow {
    struct Debt {
        address from;
        address to;
        uint amount;
    }

    uint lastDebtId;
    mapping(uint => Debt) debts;

    function createDebt(address _to, uint _amount) public returns (uint thisId) {
        thisId = lastDebtId++;
        debts[thisId] = Debt(msg.sender, _to, _amount);
    }
    
    function decDebt(uint _id, uint _amount) public {
        if (_id > lastDebtId) revert();
        if (debts[_id].to != msg.sender) revert();
        if (_amount > debts[_id].amount) revert();
        debts[_id].amount -= _amount;
    }
    
    function showDebt(uint _id) public view returns (address, address, uint) {
        return (debts[_id].from, debts[_id].to, debts[_id].amount);
    }
}