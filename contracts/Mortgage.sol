// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Mortgage {
    address payable public lender;
    address payable public borrower;
    uint256 public loanAmount;
    uint256 public interestRate; // Assuming this is an annual rate, could be represented as a percentage times 100 (e.g., 5% as 500 to allow for decimal percentages)
    uint256 public loanDuration; // In months, for example
    uint256 public monthlyPayment;
    uint256 public balanceDue;
    bool public loanActive = false;

    // Event declarations (optional but recommended for transparency)
    event LoanInitialized(address borrower, uint amount, uint interestRate, uint duration, uint monthlyPayment);
    event PaymentMade(address borrower, uint amount, uint balanceDue);

    // Constructor to set the lender at contract deployment
    constructor() {
        lender = payable(msg.sender); // The deployer of the contract is the lender
    }

    // Initialize loan terms
    function initializeLoan(address payable _borrower, uint _amount, uint _interestRate, uint _duration, uint _monthlyPayment) public {
        require(msg.sender == lender, "Only lender can initialize the loan.");
        require(!loanActive, "Loan already initialized.");
        require(_amount > 0, "Loan amount must be greater than 0.");
        require(_interestRate > 0, "Interest rate must be positive.");
        require(_duration > 0, "Loan duration must be positive.");
        require(_monthlyPayment > 0, "Monthly payment must be positive.");

        borrower = _borrower;
        loanAmount = _amount;
        interestRate = _interestRate;
        loanDuration = _duration;
        monthlyPayment = _monthlyPayment;
        balanceDue = _amount;
        loanActive = true;

        emit LoanInitialized(_borrower, _amount, _interestRate, _duration, _monthlyPayment); // Emitting event
    }

    // Make a payment towards the loan
    function makePayment() public payable {
        require(msg.sender == borrower, "Only borrower can make payments.");
        require(loanActive, "Loan not active.");
        require(msg.value == monthlyPayment, "Incorrect payment amount.");

        balanceDue -= msg.value; // Assuming `msg.value` is the payment amount
        if (balanceDue == 0) {
            loanActive = false;
        }

        emit PaymentMade(msg.sender, msg.value, balanceDue); // Emitting event
    }
}
