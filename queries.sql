

USE banking_system;

-- Basic SELECT queries
-- 1. Get all customers
SELECT * FROM customers;

-- 2. Get all accounts with customer information
SELECT a.account_id, a.account_type, a.balance, 
       c.first_name, c.last_name, c.email
FROM accounts a
JOIN customers c ON a.customer_id = c.customer_id;

-- Filtering with WHERE
-- 3. Find customers with savings accounts
SELECT c.customer_id, c.first_name, c.last_name, a.account_type, a.balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.account_type = 'Savings';

-- 4. Find accounts with balance over $5000
SELECT account_id, account_type, balance, customer_id
FROM accounts
WHERE balance > 5000
ORDER BY balance DESC;

-- Aggregations
-- 5. Calculate total balance for each customer
SELECT c.customer_id, c.first_name, c.last_name,
       SUM(a.balance) AS total_balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_balance DESC;

-- 6. Count number of accounts by type
SELECT account_type, COUNT(*) AS account_count
FROM accounts
GROUP BY account_type;

-- 7. Find average transaction amount by transaction type
SELECT transaction_type, AVG(amount) AS average_amount
FROM transactions
GROUP BY transaction_type;

-- Joins
-- 8. Get all transactions with account and customer details
SELECT t.transaction_id, t.transaction_type, t.amount, t.transaction_date,
       a.account_type, a.account_id,
       c.first_name, c.last_name
FROM transactions t
JOIN accounts a ON t.account_id = a.account_id
JOIN customers c ON a.customer_id = c.customer_id
ORDER BY t.transaction_date DESC;

-- 9. Find customers with loans and their account balances
SELECT c.customer_id, c.first_name, c.last_name,
       l.loan_id, l.loan_amount, l.remaining_balance AS loan_balance,
       SUM(a.balance) AS total_account_balance
FROM customers c
JOIN loans l ON c.customer_id = l.customer_id
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, l.loan_id, l.loan_amount, l.remaining_balance;

-- Subqueries
-- 10. Find customers whose total balance exceeds their loan amount
SELECT c.customer_id, c.first_name, c.last_name,
       (SELECT SUM(balance) FROM accounts WHERE customer_id = c.customer_id) AS total_balance,
       l.loan_amount
FROM customers c
JOIN loans l ON c.customer_id = l.customer_id
WHERE (SELECT SUM(balance) FROM accounts WHERE customer_id = c.customer_id) > l.loan_amount;

-- Transaction examples
-- 11. Transaction to transfer money between accounts
START TRANSACTION;

-- Withdraw from source account
UPDATE accounts 
SET balance = balance - 1000 
WHERE account_id = 1;

-- Deposit to destination account
UPDATE accounts 
SET balance = balance + 1000 
WHERE account_id = 2;

-- Record the transaction
INSERT INTO transactions (account_id, transaction_type, amount, description, recipient_account_id)
VALUES (1, 'Transfer', 1000, 'Transfer to account #2', 2);

COMMIT;

-- Advanced queries
-- 12. Calculate loan-to-deposit ratio for each customer
SELECT c.customer_id, c.first_name, c.last_name,
       SUM(l.loan_amount) AS total_loans,
       SUM(a.balance) AS total_deposits,
       CASE 
           WHEN SUM(a.balance) = 0 THEN NULL
           ELSE SUM(l.loan_amount) / SUM(a.balance)
       END AS loan_to_deposit_ratio
FROM customers c
LEFT JOIN loans l ON c.customer_id = l.customer_id
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 13. Find customers with no loans
SELECT c.customer_id, c.first_name, c.last_name, c.email
FROM customers c
LEFT JOIN loans l ON c.customer_id = l.customer_id
WHERE l.loan_id IS NULL;

-- 14. Find the customer with the highest total balance
SELECT c.customer_id, c.first_name, c.last_name, SUM(a.balance) AS total_balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_balance DESC
LIMIT 1;
