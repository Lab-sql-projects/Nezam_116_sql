-- schema.sql
-- Banking System Database Schema

-- Create database
CREATE DATABASE IF NOT EXISTS banking_system;
USE banking_system;

-- Create Customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(200),
    date_of_birth DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Accounts table
CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    account_type VARCHAR(50) CHECK (account_type IN ('Checking', 'Savings', 'Investment')),
    balance DECIMAL(15, 2) DEFAULT 0.00,
    interest_rate DECIMAL(5, 2),
    is_active BOOLEAN DEFAULT TRUE,
    opened_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- Create Transactions table
CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    transaction_type VARCHAR(50) CHECK (transaction_type IN ('Deposit', 'Withdrawal', 'Transfer')),
    amount DECIMAL(15, 2) NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description VARCHAR(200),
    recipient_account_id INT,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id),
    FOREIGN KEY (recipient_account_id) REFERENCES accounts(account_id)
);

-- Create Loans table
CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    loan_amount DECIMAL(15, 2) NOT NULL,
    interest_rate DECIMAL(5, 2) NOT NULL,
    start_date DATE DEFAULT (CURRENT_DATE),
    term_months INT NOT NULL,
    monthly_payment DECIMAL(15, 2) NOT NULL,
    remaining_balance DECIMAL(15, 2) NOT NULL,
    loan_status VARCHAR(50) DEFAULT 'Active' CHECK (loan_status IN ('Active', 'Paid', 'Defaulted')),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
