//SPDX-License-Identifier: UNLICENSED

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.9;

// We import this library to be able to use console.log
import "hardhat/console.sol";

// This is the main building block for smart contracts.
contract Token {
    // Some string type variables to identify the token.
    string public name = "My Hardhat Token";
    string public symbol = "MHT";

    // The fixed amount of tokens stored in an unsigned integer type variable.
    uint256 public totalSupply = 1000000;

    // An address type variable is used to store ethereum accounts.
    address public owner;

    // A mapping is a key/value map. Here we store each account balance.
    mapping(address => uint256) balances;

    // NEW CODE START
    struct EmployeeInfo {
        string name;
        uint256 salary;
    }

    mapping(uint256 => EmployeeInfo) employees;
    mapping(address => uint256[]) avaliableEmployeesIds;
    mapping(address => uint256[]) employeesIdsOnwer;

    function registerEmployee(
        string memory _name,
        uint256 _salary,
        uint256 _id
    ) public {
        EmployeeInfo storage newEmployee = employees[_id];
        newEmployee.name = _name;
        newEmployee.salary = _salary;
        avaliableEmployeesIds[owner].push(_id);
    }

    function purchaseEmployee(uint256 _id) public {
        EmployeeInfo storage newEmployee = employees[_id];
        balances[msg.sender] = balances[msg.sender] - newEmployee.salary;
        employeesIdsOnwer[msg.sender].push(_id);
    }

    function getAvaliableEmployees()
        public
        view
        returns (EmployeeInfo[] memory)
    {
        uint256[] memory ids = avaliableEmployeesIds[owner];
        EmployeeInfo[] memory _allEmployees = new EmployeeInfo[](ids.length);
        for (uint256 i = 0; i < ids.length; i++) {
            _allEmployees[i] = employees[ids[i]];
        }
        return _allEmployees;
    }

    function getEmployees(address _ownerAdress)
        public
        view
        returns (EmployeeInfo[] memory)
    {
        uint256[] memory ids = employeesIdsOnwer[_ownerAdress];
        EmployeeInfo[] memory ownedEmployees = new EmployeeInfo[](ids.length);
        for (uint256 i = 0; i < ids.length; i++) {
            ownedEmployees[i] = employees[ids[i]];
        }
        return ownedEmployees;
    }

    // NEW CODE END
    // The Transfer event helps off-chain aplications understand
    // what happens within your contract.
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    /**
     * Contract initialization.
     */
    constructor() {
        // The totalSupply is assigned to the transaction sender, which is the
        // account that is deploying the contract.
        balances[msg.sender] = totalSupply;
        owner = msg.sender;
    }

    /**
     * A function to transfer tokens.
     *
     * The `external` modifier makes a function *only* callable from outside
     * the contract.
     */
    function transfer(address to, uint256 amount) external {
        // Check if the transaction sender has enough tokens.
        // If `require`'s first argument evaluates to `false` then the
        // transaction will revert.
        require(balances[msg.sender] >= amount, "Not enough tokens");

        // We can print messages and values using console.log, a feature of
        // Hardhat Network:
        console.log(
            "Transferring from %s to %s %s tokens",
            msg.sender,
            to,
            amount
        );

        // Transfer the amount.
        balances[msg.sender] -= amount;
        balances[to] += amount;

        // Notify off-chain applications of the transfer.
        emit Transfer(msg.sender, to, amount);
    }

    /**
     * Read only function to retrieve the token balance of a given account.
     *
     * The `view` modifier indicates that it doesn't modify the contract's
     * state, which allows us to call it without executing a transaction.
     */
    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }
}
