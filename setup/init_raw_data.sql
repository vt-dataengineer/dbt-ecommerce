CREATE DATABASE IF NOT EXISTS raw_ecommerce;
CREATE DATABASE IF NOT EXISTS dev_ecommerce;

USE raw_ecommerce;

-- Customers
CREATE TABLE IF NOT EXISTS customers (
  customer_id INT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(100),
  city VARCHAR(50),
  created_at DATETIME
);

-- Products
CREATE TABLE IF NOT EXISTS products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100),
  category VARCHAR(50),
  price DECIMAL(10,2)
);

-- Orders
CREATE TABLE IF NOT EXISTS orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATETIME,
  status VARCHAR(20)
);

-- Order items
CREATE TABLE IF NOT EXISTS order_items (
  order_item_id INT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  unit_price DECIMAL(10,2)
);

-- Payments
CREATE TABLE IF NOT EXISTS payments (
  payment_id INT PRIMARY KEY,
  order_id INT,
  payment_method VARCHAR(30),
  amount DECIMAL(10,2),
  payment_date DATETIME
);


INSERT INTO customers VALUES
(1,'Amit','Sharma','amit@email.com','Delhi','2023-01-15 10:00:00'),
(2,'Priya','Verma','priya@email.com','Mumbai','2023-02-20 11:30:00'),
(3,'Rahul','Singh','rahul@email.com','Bangalore','2023-03-05 09:15:00'),
(4,'Sneha','Patel','sneha@email.com','Ahmedabad','2023-03-18 14:00:00'),
(5,'Karan','Mehta','karan@email.com','Chandigarh','2023-04-01 08:45:00');

INSERT INTO products VALUES
(1,'Wireless Headphones','Electronics',2999.00),
(2,'Running Shoes','Footwear',1499.00),
(3,'Yoga Mat','Sports',799.00),
(4,'Coffee Maker','Appliances',3499.00),
(5,'Backpack','Accessories',1199.00);

INSERT INTO orders VALUES
(1,1,'2024-01-10 10:00:00','completed'),
(2,2,'2024-01-12 11:00:00','completed'),
(3,3,'2024-01-15 09:30:00','returned'),
(4,4,'2024-01-18 14:00:00','completed'),
(5,5,'2024-01-20 16:00:00','pending'),
(6,1,'2024-02-01 10:00:00','completed'),
(7,2,'2024-02-05 13:00:00','completed');

INSERT INTO order_items VALUES
(1,1,1,1,2999.00),
(2,1,5,2,1199.00),
(3,2,2,1,1499.00),
(4,3,3,2,799.00),
(5,4,4,1,3499.00),
(6,5,1,1,2999.00),
(7,6,2,2,1499.00),
(8,7,5,1,1199.00);

INSERT INTO payments VALUES
(1,1,'credit_card',5397.00,'2024-01-10 10:05:00'),
(2,2,'upi',1499.00,'2024-01-12 11:05:00'),
(3,4,'debit_card',3499.00,'2024-01-18 14:05:00'),
(4,6,'credit_card',2998.00,'2024-02-01 10:05:00'),
(5,7,'upi',1199.00,'2024-02-05 13:05:00');