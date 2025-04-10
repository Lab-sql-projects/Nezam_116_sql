# SQL Operations & Database Management 

This repository contains SQL queries for the Banking System database as part of the SQL Operations & Database Management 2 lab assignment.

## Database Structure

The Banking System database consists of four main tables:
- `customers`: Stores customer personal information
- `accounts`: Contains different account types and balances for each customer
- `transactions`: Records all financial transactions
- `loans`: Tracks loan information for customers

## Queries Implemented

The lab2_queries.sql file includes the following required queries:

### JOIN Queries
1. **INNER JOIN**: Shows all transactions with corresponding account and customer information
   - Links transactions, accounts, and customers tables
   - Displays transaction details along with account type and customer name

2. **LEFT JOIN**: Shows all customers and their accounts (including customers with no accounts)
   - Preserves all customer records even if they don't have any accounts
   - Provides a complete view of customer-account relationships

### Data Modification Queries
3. **UPDATE**: Applies a 0.5% interest rate increase to all savings accounts
   - Targets only savings account types
   - Modifies the interest_rate field

4. **DELETE**: Removes all transactions with amounts less than $200
   - Cleans up small transactions from the database
   - Uses a WHERE clause to filter by amount

### Advanced Queries
5. **AGGREGATION with GROUP BY and HAVING**: Finds customers with total account balances over $20,000
   - Calculates sum of balances across all accounts per customer
   - Groups results by customer
   - Uses HAVING clause to filter aggregated results
   - Includes count of accounts per customer

6. **SUBQUERY**: Finds accounts with balances higher than the average account balance
   - Uses a subquery to calculate the average balance across all accounts
   - Compares each account's balance against this average
   - Joins with customer information for complete results

## How to Run

1. Ensure you have MySQL installed and running
2. Connect to your MySQL server
3. Execute the queries in the lab2_queries.sql file

## Note

These queries are designed to work with the Banking System database schema provided in schema.sql. The database should be populated with sample data from insert.sql before running these queries.
