-- Lab 3: Advanced SQL Operations

-- Create database and tables
DROP DATABASE IF EXISTS lab3_demo;
CREATE DATABASE lab3_demo;
USE lab3_demo;

-- Create users table with dummy data
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    age INT,
    join_date DATE NOT NULL,
    last_purchase DATE,
    bio TEXT,
    active BOOLEAN DEFAULT TRUE,
    salary DECIMAL(10,2)
);

INSERT INTO users (username, email, password_hash, age, join_date, last_purchase, bio, active, salary) VALUES
('johndoe', 'john@example.com', 'hashed_pw1', 28, '2023-01-15', '2023-05-20', 'Software engineer', TRUE, 75000.00),
('janedoe', 'jane@example.com', 'hashed_pw2', 32, '2023-02-10', '2023-06-15', 'Data analyst', TRUE, 68000.00),
('bobsmith', 'bob@example.com', 'hashed_pw3', 45, '2022-11-05', '2023-04-30', 'Marketing manager', TRUE, 82000.00),
('alicej', 'alice@example.com', 'hashed_pw4', 22, '2023-03-22', NULL, 'Student', TRUE, 25000.00),
('mikeb', 'mike@example.com', 'hashed_pw5', 35, '2022-09-18', '2023-07-10', 'Graphic designer', FALSE, 55000.00),
('sarahk', 'sarah@example.com', 'hashed_pw6', 29, '2023-04-05', '2023-07-25', 'Product manager', TRUE, 90000.00),
('davidl', 'david@example.com', 'hashed_pw7', 41, '2022-12-12', '2023-06-30', 'CTO', TRUE, 120000.00),
('emilyw', 'emily@example.com', 'hashed_pw8', 27, '2023-01-30', NULL, 'UX designer', TRUE, 65000.00),
('tomh', 'tom@example.com', 'hashed_pw9', 38, '2022-10-25', '2023-05-15', 'DevOps engineer', TRUE, 95000.00),
('lisam', 'lisa@example.com', 'hashed_pw10', 31, '2023-02-28', '2023-07-20', 'Data scientist', TRUE, 110000.00);

-- Create products table with dummy data
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(50),
    stock_quantity INT NOT NULL
);

INSERT INTO products (name, price, category, stock_quantity) VALUES
('Laptop Pro', 1299.99, 'Electronics', 50),
('Wireless Mouse', 29.99, 'Electronics', 200),
('Desk Chair', 199.99, 'Furniture', 30),
('Smartphone X', 899.99, 'Electronics', 75),
('Coffee Maker', 49.99, 'Home', 100),
('Notebook', 9.99, 'Office', 500),
('Headphones', 79.99, 'Electronics', 150),
('Water Bottle', 19.99, 'Home', 300),
('Backpack', 59.99, 'Accessories', 80),
('Monitor 27"', 299.99, 'Electronics', 40);

-- Create orders table with dummy data
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Processing'
);

INSERT INTO orders (user_id, order_date, total_amount, status) VALUES
(1, '2023-05-20 10:30:00', 1299.99, 'Completed'),
(2, '2023-06-15 14:45:00', 179.97, 'Completed'),
(3, '2023-04-30 09:15:00', 299.99, 'Completed'),
(1, '2023-07-01 16:20:00', 59.99, 'Processing'),
(6, '2023-07-25 11:10:00', 1029.98, 'Completed'),
(7, '2023-06-30 13:25:00', 199.99, 'Completed'),
(9, '2023-05-15 15:50:00', 399.98, 'Completed'),
(10, '2023-07-20 10:05:00', 129.98, 'Completed'),
(4, '2023-08-01 12:30:00', 29.99, 'Shipped'),
(8, '2023-08-02 09:45:00', 79.99, 'Processing');

-- Create order_items table with dummy data
CREATE TABLE order_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10,2) NOT NULL
);

INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase) VALUES
(1, 1, 1, 1299.99),
(2, 2, 3, 29.99),
(2, 6, 2, 9.99),
(3, 10, 1, 299.99),
(4, 9, 1, 59.99),
(5, 1, 1, 1299.99),
(6, 3, 1, 199.99),
(7, 4, 1, 899.99),
(7, 7, 1, 79.99),
(8, 7, 1, 79.99),
(8, 8, 1, 19.99),
(9, 2, 1, 29.99),
(10, 7, 1, 79.99);

-- Task 1: Create a VIEW that hides sensitive columns
CREATE VIEW user_public_profile AS
SELECT user_id, username, join_date, bio, age
FROM users
WHERE active = TRUE;

SELECT * FROM user_public_profile;

-- Task 2: Add at least TWO INTEGRITY CONSTRAINTS
ALTER TABLE users
ADD CONSTRAINT chk_email_format CHECK (email LIKE '%@%.%');

ALTER TABLE orders
ADD CONSTRAINT fk_user_id 
FOREIGN KEY (user_id) REFERENCES users(user_id);

SHOW CREATE TABLE users;
SHOW CREATE TABLE orders;

-- Task 3: Create an INDEX on frequently queried column
CREATE INDEX idx_orders_user_id ON orders(user_id);
SHOW INDEX FROM orders;

-- Task 4: Create and test a TRANSACTION
START TRANSACTION;

INSERT INTO orders (user_id, order_date, total_amount, status)
VALUES (5, NOW(), 349.98, 'Processing');

SET @new_order_id = LAST_INSERT_ID();

INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase)
VALUES (@new_order_id, 5, 1, 49.99),
       (@new_order_id, 7, 1, 79.99),
       (@new_order_id, 8, 2, 19.99);

UPDATE products SET stock_quantity = stock_quantity - 1 WHERE product_id = 5;
UPDATE products SET stock_quantity = stock_quantity - 1 WHERE product_id = 7;
UPDATE products SET stock_quantity = stock_quantity - 2 WHERE product_id = 8;

SELECT * FROM orders WHERE order_id = @new_order_id;
SELECT * FROM order_items WHERE order_id = @new_order_id;
SELECT product_id, name, stock_quantity FROM products WHERE product_id IN (5,7,8);

COMMIT;

-- Task 5: Complex Query with JOIN, SUBQUERY, and WHERE/HAVING
SELECT 
    u.user_id,
    u.username,
    u.join_date,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent,
    AVG(o.total_amount) AS avg_order_value,
    MAX(o.order_date) AS last_order_date
FROM users u
JOIN orders o ON u.user_id = o.user_id
WHERE u.active = TRUE
AND o.status = 'Completed'
AND u.join_date > '2023-01-01'
GROUP BY u.user_id, u.username, u.join_date
HAVING SUM(o.total_amount) > (
    SELECT AVG(total_amount) 
    FROM orders 
    WHERE status = 'Completed'
)
ORDER BY total_spent DESC;

-- Bonus: Create Role and Grant Privileges
CREATE ROLE 'lab3_reader';

GRANT SELECT ON lab3_demo.user_public_profile TO 'lab3_reader';
GRANT SELECT ON lab3_demo.products TO 'lab3_reader';

CREATE USER 'lab3_user'@'localhost' IDENTIFIED BY 'Lab3Secure!123';
GRANT 'lab3_reader' TO 'lab3_user'@'localhost';
SET DEFAULT ROLE 'lab3_reader' TO 'lab3_user'@'localhost';

SHOW GRANTS FOR 'lab3_user'@'localhost';
