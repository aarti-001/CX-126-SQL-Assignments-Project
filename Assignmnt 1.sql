-----Basics Questions:- 

----1. Create two Databases Name :- Brands , and  Products 

Create database Brands
Create database Products 

-----2.Create two tables in SQL Server  name  as ITEMS_TABLE in Brands database and PRODUCT_TABLE  in Products database. 

Create Table ITEMS_TABLE  (Item_Id int, Item_description varchar(max),vendor_nos int, vendor_name varchar(max),bottle_size varchar(max),
bottle_price Float)
select * from ITEMS_TABLE

----3. After Creating both the tables Add records in that tables (records are available in ITEMS_TABLE Sheet and PRODUCTS_TABLE Sheet) 

Create Table  PRODUCT_TABLE  (Product_Id int, Country varchar(max), Product varchar(max), UnitSold Float, ManufacturingPrice int,SalesPrice int,GrossSales int, Sales int, COGS int, Profit int, Date Date, MonthNumber int, MonthName varchar(max), Year int)
select * from PRODUCT_TABLE

----4. Delete those product having the Units Sold 1618.5 , 888 and 2470. 

Delete from PRODUCT_TABLE where UnitSold=1618.5
Delete from PRODUCT_TABLE where UnitSold=888
Delete from PRODUCT_TABLE where UnitSold=2470

----5. Select all records from the ITEMS_TABLE table. 
select * from ITEMS_TABLE
select * from PRODUCT_TABLE

----6.Select the item_description and bottle_price for all items in the ITEMS_TABLE table. 
SELECT 
    item_description,
    bottle_price
FROM ITEMS_TABLE;

----7. Find the item_description and bottle_price of items where bottle_price is greater than 20. 
Select item_description, bottle_price from ITEMS_TABLE
where bottle_price>=20

----8. Select Unique Country from the product_sales table 
Select Distinct Country from PRODUCT_TABLE

----9. Count the number of Countries in the product_sales table 
Select Count(Country) 'Total Country' from PRODUCT_TABLE

----10. How Many Countries are there which contain the sales price between 10 to 20 
Select * from PRODUCT_TABLE where SalesPrice between 10 and 20 

------Intermediate Questions 
----PRODUCTS_SALES_TABLE:- 

-----1. Find the Total Sale Price  and  Gross Sales  
Select SUM(SalesPrice) 'Total SalesPrice ' from PRODUCT_TABLE
Select *,(SalesPrice )*UnitSold 'GrossSales'
from PRODUCT_TABLE

----2. In which year we have got the highest sales 
Select Max(Sales) 'Highest Sales' from PRODUCT_TABLE

----3. Which Product having the sales of $ 37,050.00 
Select * from PRODUCT_TABLE where Sales=37050 

----4. Which Countries lies between profit of $ 4,605 to $  22 , 662.00 
Select * from PRODUCT_TABLE where Profit between 4605 and 22662

----5. Which Product Id having the sales of $ 24 , 700.00 
Select * from PRODUCT_TABLE where Sales=24700

----6. Find the total Units Sold for each Country. 
Select * from PRODUCT_TABLE
Select Country, Sum(UnitSold) 'Total UnitSold' from PRODUCT_TABLE
Group by Country

---7. Find the average sales for each country 
Select Country, AVG(Sales) 'Average Sales' from PRODUCT_TABLE
Group by Country

---8. Retrieve all products sold in 2014 
SELECT *
FROM PRODUCT_TABLE
WHERE YEAR = 2014;

----9. Find the maximum Profit in the product_sales table. 
Select Max(Profit) 'Maximum Profit' from PRODUCT_TABLE

----10. Retrieve the records from product_sales where Profit is greater than the average Profit of all records. 
SELECT *
FROM PRODUCT_TABLE
WHERE Profit > (
    SELECT AVG(Profit)
    FROM PRODUCT_TABLE
);

---11.Find the item_description having the bottle size of 750 
select * from ITEMS_TABLE
Select * from ITEMS_TABLE where bottle_size=750

---12.What is total Bottle_price  
Select Sum(bottle_price) 'Total Bottle Price' from ITEMS_TABLE

--13.Find the vendor Name having the vendor_nos 305 , 380 , 
Select * from ITEMS_TABLE in vendor_nos value is(305,380,391)

---14.Make Primary Key to Item_id 
update ITEMS_TABLE set Item_Id where Primary_key

----15.Which item id having the bottle_price of $ 5.06
Select * from ITEMS_TABLE where bottle_price=5.06

In which year we have got the highest sales 
Select * from PRODUCT_TABLE where Sales in (Select Max(Sales) from PRODUCT_TABLE) 

----15.Which item id having the bottle_price of $ 5.06
Select * from ITEMS_TABLE where bottle_price=5.06



----Advance Question

----1. Apply INNER  , FULL OUTER , LEFT JOIN types on both the table  
Create Table ITEMS_TABLE  (Item_Id int, Item_description varchar(max),vendor_nos int, vendor_name varchar(max),bottle_size varchar(max),
bottle_price Float)
select * from ITEMS_TABLE
Create Table  PRODUCT_TABLE  (Product_Id int, Country varchar(max), Product varchar(max), UnitSold Float, ManufacturingPrice int,SalesPrice int,GrossSales int, Sales int, COGS int, Profit int, Date Date, MonthNumber int, MonthName varchar(max), Year int)
select * from PRODUCT_TABLE

Select * from ITEMS_TABLE
Select * from PRODUCT_TABLE

----1-Left Join
Select ITEMS_TABLE.Item_Id,ITEMS_TABLE.Item_description,ITEMS_TABLE.vendor_nos,PRODUCT_TABLE.Country,PRODUCT_TABLE.Product from ITEMS_TABLE
left join PRODUCT_TABLE
on ITEMS_TABLE.Item_Id=PRODUCT_TABLE.Product_Id

---2-Right Join
Select ITEMS_TABLE.Item_Id,ITEMS_TABLE.Item_description,ITEMS_TABLE.vendor_nos,PRODUCT_TABLE.Country,PRODUCT_TABLE.Product from ITEMS_TABLE
Right join PRODUCT_TABLE
on ITEMS_TABLE.Item_Id=PRODUCT_TABLE.Product_Id

---3-Inner Join
Select ITEMS_TABLE.Item_Id,ITEMS_TABLE.Item_description,ITEMS_TABLE.vendor_nos,PRODUCT_TABLE.Product_Id, PRODUCT_TABLE.Country,PRODUCT_TABLE.Product from ITEMS_TABLE
Inner join PRODUCT_TABLE
on ITEMS_TABLE.Item_Id=PRODUCT_TABLE.Product_Id

---4-Full Join
Select ITEMS_TABLE.Item_Id,ITEMS_TABLE.Item_description,ITEMS_TABLE.vendor_nos,PRODUCT_TABLE.Product_Id, PRODUCT_TABLE.Country,PRODUCT_TABLE.Product from ITEMS_TABLE
Full join PRODUCT_TABLE
on ITEMS_TABLE.Item_Id=PRODUCT_TABLE.Product_Id

---2. Find the item_description and Product having the gross sales of 13,320.00 

Select *from ITEMS_TABLE
Select *from PRODUCT_TABLE
Select * from ITEMS_TABLE where Item_Id =(Select Product_Id from PRODUCT_TABLE where GrossSales='13320')

---3. Split the Item_description Column into Columns Item_desc1 and Item_desc2 
SELECT 
    value
FROM ITEMS_TABLE
CROSS APPLY STRING_SPLIT(item_description, '-');

---4. Find the top 3 most expensive items in the ITEMS_TABLE table. 
SELECT TOP 3
    item_description,
    bottle_price
FROM ITEMS_TABLE
ORDER BY bottle_price DESC;

---5. Find the total Gross Sales and Profit for each Product in each Country. 
Select Country, Sum(GrossSales) 'Total GrossSales' from PRODUCT_TABLE
Group by Country
Select Country, Sum(Profit) 'Total Profit' from PRODUCT_TABLE
Group by Country

----6. Find the vendor_name and item_description of items with a bottle_size of 750 and bottle_price less than 10. 
Select * from ITEMS_TABLE where bottle_size=750 and bottle_price<10

---7. Find the Product with the highest Profit in 2019. 
Select * from PRODUCT_TABLE where Year=2019 

---8. Retrieve the Product_Id and Country of all records where the Profit is at least twice the COGS. 
SELECT 
    Product_Id,
    Country, Profit
FROM PRODUCT_TABLE
WHERE Profit >= 2 * COGS;

----9. Find the Country that had the highest total Gross Sales in 2018 
SELECT TOP 1
    Country,
    SUM(Sales) AS Total_Gross_Sales
FROM PRODUCT_TABLE
WHERE YEAR = 2018
GROUP BY Country
ORDER BY Total_Gross_Sales DESC;

----10. Calculate the total Sales for each Month Name across all years. 
Select MonthNumber, Sum(Sales) 'Total Sales' from PRODUCT_TABLE
Group by MonthNumber

----11. List the item_description and vendor_name for items whose vendor_nos exists more than once in the ITEMS_TABLE table.
SELECT vendor_nos
FROM ITEMS_TABLE
GROUP BY vendor_nos
HAVING COUNT(*) > 1

----12.Find the average Manufacturing Price for Product in each Country and only include those Country and Product combinations where the average is above 3
Select Country, Avg(ManufacturingPrice) 'Avg ManufacturingPrice' from PRODUCT_TABLE
Group by Country Having Avg(ManufacturingPrice)>3



------Super-Advance Questions:- 

----1. Find the item_description and bottle_price of items that have the same vendor_name as items with Item_Id 1. 
SELECT 
    item_description,
    bottle_price
FROM ITEMS_TABLE
WHERE vendor_name = (
    SELECT vendor_name
    FROM ITEMS_TABLE
    WHERE Item_Id = 1
);

---2. Create a stored procedure to retrieve all records from the ITEMS_TABLE table where bottle_price is greater than a given value
CREATE PROCEDURE Get_Items_By_Price
    @MinPrice DECIMAL(10,2)
AS
BEGIN
    SELECT *
    FROM ITEMS_TABLE
    WHERE bottle_price > @MinPrice;
END;

---3. Create a stored procedure to insert a new record into the product_sales table.
CREATE PROCEDURE Insert_Product_Sales
    @Product_Id INT,
    @Country VARCHAR(50),
    @Gross_Sales DECIMAL(10,2),
    @COGS DECIMAL(10,2),
    @Profit DECIMAL(10,2),
    @Sale_Date DATE
AS
BEGIN
    INSERT INTO product_sales (
        Product_Id,
        Country,
        Gross_Sales,
        COGS,
        Profit,
        Sale_Date
    )
    VALUES (
        @Product_Id,
        @Country,
        @Gross_Sales,
        @COGS,
        @Profit,
        @Sale_Date
    );
END;

----4. Create a trigger to automatically update the Gross_Sales field in the product_sales table whenever Units_Sold or Sale_Price is updated. 
CREATE TRIGGER trg_Update_GrossSales
ON product_table
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE pt
    SET Sales = i.UnitsSold * i.SalePrice
    FROM PRODUCT_TABLE pt
    INNER JOIN inserted i
        ON pt.Product_Id = i.Product_Id;
END;


---5. Write a query to find all item_description in the ITEMS_TABLE table that contain the word "Whisky" regardless of case. 
SELECT 
    item_description
FROM ITEMS_TABLE
WHERE LOWER(item_description) LIKE '%whisky%';

---6. Write a query to find the Country and Product where the Profit is greater than the average Profit of all products.
SELECT 
    Country,
    Product
FROM PRODUCT_TABLE
WHERE Profit > (
    SELECT AVG(Profit)
    FROM PRODUCT_TABLE
);

--7. Write a query to join the ITEMS_TABLE and product_sales tables on a common field (e.g., vendor_nos) and select relevant fields from both tables. 
SELECT 
    i.item_description,
    i.vendor_name,
    i.bottle_price,
    p.Product_Id,
    p.Country,
    p.Sales,
    p.Profit
FROM ITEMS_TABLE i
INNER JOIN PRODUCT_TABLE p
    ON i.Item_Id = p.Product_Id;

----8. Write a query to combine item_description and vendor_name into a single string for each record in the ITEMS_TABLE table, separated by a hyphen. 
SELECT 
    item_description + ' - ' + vendor_name AS Item_Vendor
FROM ITEMS_TABLE;

---9. Write a query to display the bottle_price rounded to one decimal place for each record in the ITEMS_TABLE table. 
SELECT 
    ROUND(bottle_price, 1) AS rounded_price
FROM ITEMS_TABLE;

----10. Write a query to calculate the number of days between the current date and the Date field for each record in the product_sales table.
SELECT 
    Product_Id,
    Date,
    DATEDIFF(DAY, Date, GETDATE()) AS Days_Difference
FROM PRODUCT_TABLE;