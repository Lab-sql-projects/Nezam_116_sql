-- insert.sql
-- Sample data for Banking System Database

USE banking_system;

-- Insert Customers
INSERT INTO customers (first_name, last_name, email, phone, address, date_of_birth) VALUES
('John', 'Smith', 'john.smith@email.com', '555-123-4567', '123 Main St, Anytown, USA', '1985-06-15'),
('Sarah', 'Johnson', 'sarah.j@email.com', '555-987-6543', '456 Oak Ave, Somewhere, USA', '1990-03-22'),
('Michael', 'Williams', 'michael.w@email.com', '555-456-7890', '789 Pine Rd, Nowhere, USA', '1978-11-30'),
('Emma', 'Brown', 'emma.b@email.com', '555-234-5678', '321 Elm St, Anywhere, USA', '1995-08-12');

-- Insert Accounts
INSERT INTO accounts (customer_id, account_type, balance, interest_rate) VALUES
(1, 'Checking', 2500.00, 0.25),
(1, 'Savings', 10000.00, 1.50),
(2, 'Checking', 3750.00, 0.25),
(2, 'Savings', 15000.00, 1.50),
(3, 'Checking', 1800.00, 0.25),
(3, 'Investment', 25000.00, 3.25),
(4, 'Savings', 8500.00, 1.50);

-- Insert Transactions
INSERT INTO transactions (account_id, transaction_type, amount, description) VALUES
(1, 'Deposit', 1000.00, 'Initial deposit'),
(1, 'Withdrawal', 250.00, 'ATM withdrawal'),
(2, 'Deposit', 5000.00, 'Savings deposit'),
(3, 'Deposit', 2000.00, 'Paycheck deposit'),
(3, 'Withdrawal', 150.00, 'Grocery shopping'),
(4, 'Deposit', 10000.00, 'Bonus deposit'),
(5, 'Withdrawal', 300.00, 'Utility bills payment'),
(6, 'Deposit', 15000.00, 'Investment fund');

-- Insert Transfer transaction
INSERT INTO transactions (account_id, transaction_type, amount, description, recipient_account_id) VALUES
(1, 'Transfer', 500.00, 'Transfer to savings', 2);

-- Insert Loans
INSERT INTO loans (customer_id, loan_amount, interest_rate, term_months, monthly_payment, remaining_balance) VALUES
(1, 25000.00, 4.5, 60, 466.08, 25000.00),
(2, 15000.00, 3.75, 36, 442.13, 15000.00),
(3, 50000.00, 5.25, 120, 535.82, 50000.00);
