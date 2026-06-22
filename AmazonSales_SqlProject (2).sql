create database amazonsales;
use amazonsales;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    price INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Details (
    order_id INT,
    product_id INT,
    quantity INT,
    sales INT,
    profit INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Shipping (
    shipping_id INT PRIMARY KEY,
    order_id INT,
    shipping_date DATE,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Customers VALUES
(1,'Chaitanya','India'),
(2,'Rahul','India'),
(3,'Amit','India'),
(4,'John','USA'),
(5,'David','UK'),
(6,'Emma','Canada'),
(7,'Sophia','USA'),
(8,'Liam','UK'),
(9,'Noah','Canada'),
(10,'Olivia','India'),
(11,'Ava','USA'),
(12,'Isabella','UK'),
(13,'Mason','Canada'),
(14,'Ethan','India'),
(15,'Lucas','USA'),
(16,'Mia','UK'),
(17,'Charlotte','Canada'),
(18,'Amelia','India'),
(19,'Harper','USA'),
(20,'Evelyn','UK');

INSERT INTO Categories VALUES
(1,'Electronics'),
(2,'Clothing'),
(3,'Books'),
(4,'Home'),
(5,'Sports'),
(6,'Beauty'),
(7,'Toys'),
(8,'Automotive'),
(9,'Garden'),
(10,'Health'),
(11,'Furniture'),
(12,'Groceries'),
(13,'Music'),
(14,'Office Supplies'),
(15,'Pet Supplies'),
(16,'Jewelry'),
(17,'Footwear'),
(18,'Accessories'),
(19,'Gaming'),
(20,'Stationery');

INSERT INTO Products VALUES
(101,'Wireless Mouse',1,500),
(102,'T-Shirt',2,300),
(103,'Python Book',3,400),
(104,'Mixer Grinder',4,2000),
(105,'Football',5,800),
(106,'Face Cream',6,600),
(107,'Toy Car',7,700),
(108,'Car Cover',8,1500),
(109,'Garden Hose',9,900),
(110,'Vitamins',10,1200),
(111,'Sofa',11,15000),
(112,'Rice Bag',12,1000),
(113,'Guitar',13,5000),
(114,'Notebook Pack',14,400),
(115,'Dog Food',15,2000),
(116,'Gold Ring',16,25000),
(117,'Sneakers',17,3000),
(118,'Watch',18,4500),
(119,'Gaming Console',19,30000),
(120,'Pen Set',20,300);

INSERT INTO Orders VALUES
(1001,1,'2024-01-01'),
(1002,2,'2024-01-02'),
(1003,3,'2024-01-03'),
(1004,4,'2024-01-04'),
(1005,5,'2024-01-05'),
(1006,6,'2024-01-06'),
(1007,7,'2024-01-07'),
(1008,8,'2024-01-08'),
(1009,9,'2024-01-09'),
(1010,10,'2024-01-10'),
(1011,11,'2024-01-11'),
(1012,12,'2024-01-12'),
(1013,13,'2024-01-13'),
(1014,14,'2024-01-14'),
(1015,15,'2024-01-15'),
(1016,16,'2024-01-16'),
(1017,17,'2024-01-17'),
(1018,18,'2024-01-18'),
(1019,19,'2024-01-19'),
(1020,20,'2024-01-20');

INSERT INTO Order_Details VALUES
(1001,101,2,1000,200),
(1002,102,3,900,150),
(1003,103,1,400,80),
(1004,104,1,2000,300),
(1005,105,2,1600,250),
(1006,106,2,1200,200),
(1007,107,3,2100,350),
(1008,108,1,1500,300),
(1009,109,2,1800,250),
(1010,110,1,1200,200),
(1011,111,1,15000,3000),
(1012,112,2,2000,300),
(1013,113,1,5000,800),
(1014,114,3,1200,200),
(1015,115,1,2000,300),
(1016,116,1,25000,5000),
(1017,117,2,6000,1000),
(1018,118,1,4500,800),
(1019,119,1,30000,6000),
(1020,120,4,1200,200);

INSERT INTO Shipping VALUES
(1,1001,'2024-01-03'),
(2,1002,'2024-01-04'),
(3,1003,'2024-01-05'),
(4,1004,'2024-01-06'),
(5,1005,'2024-01-07'),
(6,1006,'2024-01-08'),
(7,1007,'2024-01-09'),
(8,1008,'2024-01-10'),
(9,1009,'2024-01-11'),
(10,1010,'2024-01-12'),
(11,1011,'2024-01-13'),
(12,1012,'2024-01-14'),
(13,1013,'2024-01-15'),
(14,1014,'2024-01-16'),
(15,1015,'2024-01-17'),
(16,1016,'2024-01-18'),
(17,1017,'2024-01-19'),
(18,1018,'2024-01-20'),
(19,1019,'2024-01-21'),
(20,1020,'2024-01-22');

-- Aggregate Functions
SELECT SUM(sales) AS total_sales FROM Order_Details;

SELECT AVG(profit) FROM Order_Details;

-- Joins
SELECT c.name, o.order_id, p.product_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id;

-- Subquery
SELECT product_name
FROM Products
WHERE product_id IN (
    SELECT product_id FROM Order_Details WHERE profit > 150
);

-- Views
CREATE VIEW sales_summary AS
SELECT o.order_id, c.name, SUM(od.sales) AS total_sales
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
GROUP BY o.order_id, c.name;

SELECT * FROM sales_summary;