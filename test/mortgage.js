// Import the contract artifact
const Mortgage = artifacts.require("Mortgage");

contract("Mortgage", accounts => {
  let instance;

  // "beforeEach" runs before each "it" test block is executed
  beforeEach(async () => {
    instance = await Mortgage.new({ from: accounts[0], gas: 6000000});
  });

  // Example test
  it("should initialize the loan", async () => {
    // Setup
    let instance = await Mortgage.new({ from: accounts[0], gas: 6000000 });
    const lender = accounts[0];
    const borrower = accounts[1];
    const amount = web3.utils.toBN(web3.utils.toWei('100', 'ether'));
    const interestRate = 5; // 5%
    const duration = 120; // 120 months
    const monthlyPayment = web3.utils.toBN(web3.utils.toWei('1', 'ether'));

    // Invoke the initializeLoan function
    await instance.initializeLoan(borrower, amount, interestRate, duration, monthlyPayment, { from: lender });

    // Test if the values were set correctly
    const contractBorrower = await instance.borrower();
    assert.equal(contractBorrower, borrower, "The borrower address should match.");

    // Continue with other assertions for each variable...
  });

  // Add more test blocks with "it" for each function you want to test
});
