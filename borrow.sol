pragma solidity ^0.4.0;
contract Borrow {
    struct Debt {
        address from;
        address to;
        uint amount;
    }

    mapping(uint => Debt) debts;
    uint lastDebtId;

    event CreatedDebt(uint id, 
                      address from, 
                      address to, 
                      uint amount);

    event DecreasedDebt(uint id, 
                        address from, 
                        address to, 
                        uint amount, 
                        uint left);

    function createDebt(address to, uint amount) public returns (uint) {
        if (amount == 0) revert();
        uint id = lastDebtId++;
        debts[id] = Debt(msg.sender, to, amount);
        CreatedDebt(id, 
                    msg.sender, 
                    to,
                    amount);
        return id;
    }
    
    function decDebt(uint id, uint amount) public {
        if (amount == 0) revert();
        if (id > lastDebtId) revert();
        if (debts[id].to != msg.sender) revert();
        if (amount > debts[id].amount) revert();
        debts[id].amount -= amount;
        DecreasedDebt(id, 
                      debts[id].from, 
                      debts[id].to, 
                      amount, 
                      debts[id].amount);
    }

    function showDebt(uint id) public view returns (address, address, uint) {
        return (debts[id].from, debts[id].to, debts[id].amount);
    }
}