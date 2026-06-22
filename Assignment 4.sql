CREATE DATABASE Customers_Orders_Products; 
Create database Customers_Orders_Products;

USE Customers_Orders_Products; -- Create the Customers table

Create Table Customers_table (CustomerID int PRIMARY KEY, Name varchar(max),Email VARCHAR(max))
Select* from Customers_table

Create Table Orders (OrderID int PRIMARY KEY, CustomerID INT, ProductName VARCHAR(max),OrderDate DATE, Quantity INT)
Select * from Orders
 
CREATE TABLE Products (ProductID INT PRIMARY KEY, ProductName VARCHAR(max), Price DECIMAL(10, 2))
Select * from Products

INSERT INTO Customers_table VALUES  
(1, 'John Doe', 'johndoe@example.com'),  
(2, 'Jane Smith', 'janesmith@example.com'),  
(3, 'Robert Johnson', 'robertjohnson@example.com'),  
(4, 'Emily Brown', 'emilybrown@example.com'),  
(5, 'Michael Davis', 'michaeldavis@example.com'),  
(6, 'Sarah Wilson', 'sarahwilson@example.com'),  
(7, 'David Thompson', 'davidthompson@example.com'),  
(8, 'Jessica Lee', 'jessicalee@example.com'),  
(9, 'William Turner', 'williamturner@example.com'),  
(10, 'Olivia Martinez', 'oliviamartinez@example.com'), 
(11, 'James Anderson', 'jamesanderson@example.com'), 
(12, 'Kelly Clarkson', 'kellyclarkson@example.com')

INSERT INTO Products VALUES  
(1, 'Product A', 10.99),  
(2, 'Product B', 8.99),  
(3, 'Product C', 5.99),  
(4, 'Product D', 12.99),  
(5, 'Product E', 7.99),  
(6, 'Product F', 6.99),  
(7, 'Product G', 9.99),  
(8, 'Product H', 11.99),  
(9, 'Product I', 14.99),  
(10, 'Product J', 4.99), 
(11, 'Product K', 3.99), 
(12, 'Product L', 15.99)

INSERT INTO Orders VALUES  
(1, 1, 'Product A', '2023-07-01', 5),  
(2, 2, 'Product B', '2023-07-02', 3),  
(3, 3, 'Product C', '2023-07-03', 2),  
(4, 4, 'Product A', '2023-07-04', 1),  
(5, 5, 'Product B', '2023-07-05', 4),  
(6, 6, 'Product C', '2023-07-06', 2),  
(7, 7, 'Product A', '2023-07-07', 3),  
(8, 8, 'Product B', '2023-07-08', 2),  
(9, 9, 'Product C', '2023-07-09', 5),  
(10, 10, 'Product A', '2023-07-10', 1), 
(11, 11, 'Product D', '2023-07-10', 3), 
(12, 12, 'Product E', '2023-07-11', 6), 
(13, 5, 'Product G', '2023-07-12', 2), 
(14, 4, 'Product H', '2023-07-13', 4), 
(15, 6, 'Product I', '2023-07-14', 3)

--Task 1 :- 
--1. Write a query to retrieve all records from the Customers table.. 
Select* from Customers_table

--2. Write a query to retrieve the names and email addresses of customers whose names start with 'J'. 
Select * from Customers_table where Name like 'J%'

--3. Write a query to retrieve the order details (OrderID, ProductName, Quantity) for all orders.. 
Select  OrderID, ProductName, Quantity from Orders

--4.Write a query to calculate the total quantity of products ordered.
Select SUM(Quantity) 'Total Quantity' from Orders

--5. Write a query to retrieve the names of customers who have placed an order. 

SELECT DISTINCT c.name
FROM Customers_table c
INNER JOIN Orders o
    ON c.customerid = o.customerid;

--6. Write a query to retrieve the products with a price greater than $10.00. 
Select * from Products where Price>$10.00

--7. Write a query to retrieve the customer name and order date for all orders placed on or after '2023-07-05'
SELECT Customers_table.Name, Orders.OrderDate from Orders 
INNER JOIN Customers_table ON Orders.customerid = Customers_table.customerid WHERE Orders.orderdate >= '2023-07-05'

. 
--8. Write a query to calculate the average price of all products. 
Select Avg(Price) 'Average Price' from Products

--9. Write a query to retrieve the customer names along with the total quantity of products they have ordered.
Select * from Customers_table
Select * from Orders
Select Customers_table.CustomerID, Customers_table.Name, Orders.CustomerID, Orders.Quantity from Customers_table
left join Orders
on Customers_table.CustomerID =Orders.CustomerID

	--10. Write a query to retrieve the products that have not been ordered.
SELECT p.productid, p.productname
FROM Products p
LEFT JOIN Orders o
    ON p.productname = o.productname
WHERE o.productname IS NULL;

--Task 2 :- 
--1. Write a query to retrieve the top 5 customers who have placed the highest total quantity of orders. 
SELECT TOP 5
    c.name,
    SUM(o.quantity) AS total_quantity
FROM Customers_table c
INNER JOIN Orders o
    ON c.customerid = o.customerid
GROUP BY c.name
ORDER BY total_quantity DESC;


--2. Write a query to calculate the average price of products for each product category. 
SELECT 
    ProductName,
    AVG(price) AS average_price
FROM Products
GROUP BY ProductName;

--3. Write a query to retrieve the customers who have not placed any orders.
Select Customers_table.CustomerID,Customers_table.Name from Customers_table left join Orders on Customers_table.CustomerID=Orders.CustomerID where Orders.CustomerID is null

--4. Write a query to retrieve the order details (OrderID, ProductName,Quantity) for orders placed by customers whose names start with 'M'. 
Select o.orderid, o.productname,o.quantity from Orders o inner join Customers_table c on o.customerid= c.customerid  where c.name like 'M%'

--5. Write a query to calculate the total revenue generated from all orders. 
Select Sum(Orders.Quantity*p.price) as total_revenue from Orders inner join Products p on Orders.productname=p.ProductName

--6. Write a query to retrieve the customer names along with the total revenue generated from their orders. 
SELECT 
    c.name,
    SUM(O.quantity * p.price) AS total_revenue
FROM Customers_table c
INNER JOIN Orders  o
    ON c.customerid = o.customerid
INNER JOIN Products p
    ON o.productname = p.productname
GROUP BY c.name
ORDER BY total_revenue DESC;

--7. Write a query to retrieve the customers who have placed at least one order for each product category. 
SELECT 
    c.customerid,
    c.name
FROM Customers_table c
JOIN Orders o
    ON c.customerid = o.customerid
JOIN Products p
    ON o.productname = p.productname
GROUP BY c.customerid, c.name
HAVING COUNT(DISTINCT p.ProductName) = (SELECT COUNT(DISTINCT ProductName)
    FROM Products)


--8. Write a query to retrieve the customers who have placed orders on consecutive days. 

    SELECT DISTINCT c.customerid, c.name
FROM Orders o1
JOIN Orders o2
    ON o1.customerid = o2.customerid
   AND o2.orderdate = DATEADD(DAY, 1, o1.orderdate)
JOIN Customers_table c
    ON c.customerid = o1.customerid;

--9. Write a query to retrieve the top 3 products with the highest average quantity ordered. 
SELECT TOP 3
    O.productname,
    AVG(O.quantity) AS avg_quantity
FROM Orders o
GROUP BY o.productname
ORDER BY avg_quantity DESC

--10. Write a query to calculate the percentage of orders that have a quantity greater than the average quantity.
SELECT  note done
    (COUNT(CASE WHEN quantity > (SELECT AVG(quantity) FROM Orders) THEN 1 END) 
     * 100.0 / COUNT(*)) AS percentage_above_average
FROM Orders;








