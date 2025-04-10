

-- 1. INNER JOIN: Show all transactions with account and customer information
SELECT t.transaction_id, t.transaction_type, t.amount, 
       a.account_id, a.account_type, 
       c.first_name, c.last_name, c.email
FROM transactions t
INNER JOIN accounts a ON t.account_id = a.account_id
INNER JOIN customers c ON a.customer_id = c.customer_id
ORDER BY t.transaction_id;

-- 2. LEFT JOIN: Show all customers and their accounts (including customers with no accounts)
SELECT c.customer_id, c.first_name, c.last_name, c.email,
       a.account_id, a.account_type, a.balance
FROM customers c
LEFT JOIN accounts a ON c.customer_id = a.customer_id
ORDER BY c.customer_id, a.account_id;

-- 3. UPDATE: Apply a 2% interest rate increase to all savings accounts
UPDATE accounts
SET interest_rate = interest_rate + 0.5
WHERE account_type = 'Savings';

-- 4. DELETE: Remove all transactions with amounts less than $200
DELETE FROM transactions
WHERE amount < 200.00;

-- 5. AGGREGATION with GROUP BY and HAVING: Find customers with total account balance over $20,000
SELECT c.customer_id, c.first_name, c.last_name,
       SUM(a.balance) AS total_balance,
       COUNT(a.account_id) AS account_count
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(a.balance) > 20000
ORDER BY total_balance DESC;

-- 6. SUBQUERY: Find customers who have more than the average account balance
SELECT c.customer_id, c.first_name, c.last_name, a.account_id, a.account_type, a.balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.balance > (
    SELECT AVG(balance) 
    FROM accounts
)
ORDER BY a.balance DESC;
