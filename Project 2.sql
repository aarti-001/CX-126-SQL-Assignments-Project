--Task-1 
--Q1) Create a database named as SupplyChainFinanceManagement 
Create database SupplyChainFinanceManagement 

--Q2) Create Nine tables which is given below along with there Columns name in the given image 
Create table dim_customers (customer_code int, customer varchar(max) ,platform varchar(max),channel varchar(max), market varchar (max) ,sub_zone varchar (max),region varchar(max))
select * from dim_customers

Create table fact_forecast_monthly (Date date,fiscal_year int, product_code varchar(max),customer_code int,forecast_quantity int, dim_customer_code int,dim_product_product_code varchar(max))
select * from fact_forecast_monthly

Create table fact_freight_cost (market varchar(max),fiscal_year int, freight_pct float, other_cost_pct float)
select * from fact_freight_cost

Create Table fact_gross_price (product_code varchar(max),fiscal_year int, gross_price decimal)
select * from fact_gross_price

Create table fact_manufacturing_cost(product_code varchar(max), cost_year int, manufacturing_cost decimal)
select * from fact_manufacturing_cost

create table fact_post_invoice_deductions(customer_code int, product_code varchar(max),Date date,discounts_pct float, other_deductions_pct float)
select * from fact_post_invoice_deductions

Create table fact_pre_invoice_deductions(customer_code int, fiscal_year int, pre_invoice_discount_pct float)
select * from fact_pre_invoice_deductions

Create table fact_sales_monthly(date date,product_code varchar(max), customer_code int,sold_quantity int) 
select * from fact_sales_monthly

Create table product_code (product_code varchar(max),division varchar(max) ,segment varchar(max),category varchar(max),product varchar(max),variant varchar(max)) 
select * from product_code

--Task-3 
--Q1) Assume calendar_date is '2023-07-15'. Apply the function to this date and explain what value it will return as the fiscal year. 
SELECT CASE WHEN MONTH('2023-07-15') >= 9 THEN YEAR('2023-07-15') + 1 ELSE YEAR('2023-07-15') END AS fiscal_year;

--Q2) Analyzing Gross Sales: Monthly Product Transactions Report 
--Write a Query  for making report on monthly product transactions, including details such as date, product code, product name, variant, sold quantity, gross price, and gross price total. The query should involves joining several tables and filtering results based on  customer code and fiscal year. 

SELECT 
    s.date,
    s.product_code,
    p.product AS product_name,
    p.variant,
    s.sold_quantity,
    g.gross_price,
    (s.sold_quantity * g.gross_price) AS gross_price_total
FROM fact_sales_monthly s
JOIN product_code p
    ON s.product_code = p.product_code
JOIN fact_gross_price g
    ON s.product_code = g.product_code
    AND s.product_code = g.product_code
WHERE s.customer_code = 70002017
AND g.fiscal_year = 2018
ORDER BY s.date;

SELECT 
    s.date,
    s.product_code,
    p.product AS product_name,
    p.variant,
    s.sold_quantity,
    gp.gross_price,
    (s.sold_quantity * gp.gross_price) AS gross_price_total

FROM fact_sales_monthly s

JOIN product_code p
ON s.product_code = p.product_code

JOIN fact_gross_price gp
ON s.product_code = gp.product_code
AND s.date = gp.fiscal_year

JOIN dim_customers c
ON s.customer_code = c.customer_code

WHERE s.customer_code = 90002002
AND s.fiscal_year = 2021

ORDER BY s.date;

--Task-4 
--Sales Trend Analysis: 
--Query the fact_monthly_sales table to identify the monthly sales trend for each product. How do the sales volumes fluctuate over time?
SELECT product_code, YEAR(date) AS sales_year,MONTH(date) AS sales_month, SUM(sold_quantity) AS total_sales_volume FROM fact_sales_monthly GROUP BY product_code,YEAR(date),MONTH(date) ORDER BY product_code,sales_year,sales_month;

2--Customer Segmentation: 
--Utilizing the dim_customer table, segment customers based on their purchasing behavior. Which customer segments contribute the most to sales revenue? 
SELECT c.customer,c.platform,c.channel,c.market,c.region,SUM(s.sold_quantity * g.gross_price) AS total_sales_revenue FROM dim_customers  c INNER JOIN fact_sales_monthly s ON c.customer_code = s.customer_code
INNER JOIN fact_gross_price g ON s.product_code = g.product_code AND s.product_code = g.product_code
GROUP BY c.customer,c.platform,c.channel,c.market,c.region ORDER BY total_sales_revenue DESC;

--Product Performance Comparison: 
--Compare the performance of products in terms of sales quantity and revenue generated. Which products are the top performers, and which ones need improvement? 
SELECT 
    p.product_code,
    p.product AS product_name,
    p.variant,
    SUM(s.sold_quantity) AS total_quantity_sold,
    SUM(s.sold_quantity * g.gross_price) AS total_revenue
FROM fact_sales_monthly s
JOIN product_code p
    ON s.product_code = p.product_code
JOIN fact_gross_price g
    ON s.product_code = g.product_code
GROUP BY p.product_code, p.product, p.variant
ORDER BY total_revenue DESC;
--Market Expansion Opportunities: 
--Analyze the fact_forecast_monthly table to identify potential market expansion opportunities. Which markets show the highest forecasted demand growth? 
SELECT 
    c.market,
    MAX(f.forecast_quantity) AS highest_forecast_demand
FROM fact_forecast_monthly f
INNER JOIN dim_customers c
    ON f.customer_code = c.customer_code
GROUP BY c.market
ORDER BY highest_forecast_demand DESC;
--Cost Analysis: 
--Calculate the total manufacturing cost for each product and compare it with the gross price to determine profitability. Which products have the highest profit margins? 
SELECT 
    p.product_code,
    p.product AS product_name,
    m.manufacturing_cost,
    g.gross_price,
    (g.gross_price - m.manufacturing_cost) AS profit_per_unit,
    ROUND(((g.gross_price - m.manufacturing_cost) / g.gross_price) * 100, 2) AS profit_margin_percent
FROM product_code p
JOIN fact_manufacturing_cost m
    ON p.product_code = m.product_code
JOIN fact_gross_price g
    ON p.product_code = g.product_code
ORDER BY profit_margin_percent DESC;

--Discount Impact Analysis: 
--Assess the impact of pre-invoice discounts on sales revenue. How do varying discount levels affect overall revenue and customer retention?
SELECT 
    c.customer,
    s.product_code,
    SUM(s.sold_quantity * g.gross_price) AS gross_revenue,
    AVG(d.pre_invoice_discount_pct) AS avg_discount,
    SUM((s.sold_quantity * g.gross_price) * (1 - d.pre_invoice_discount_pct)) AS net_revenue
FROM fact_sales_monthly s
JOIN fact_gross_price g
    ON s.product_code = g.product_code
JOIN fact_pre_invoice_deductions d
    ON s.customer_code = d.customer_code
    AND s.customer_code = d.customer_code
JOIN dim_customers c
    ON s.customer_code = c.customer_code
GROUP BY c.customer, s.product_code
ORDER BY avg_discount DESC;


--Market-specific Freight Costs: 
--Determine the average freight costs for different markets over the years. Are there any noticeable trends or outliers in freight expenses? 
SELECT 
    c.market,
    f.date,
    ROUND(AVG(f.other_deductions_pct), 4) AS avg_freight_cost
FROM fact_post_invoice_deductions f
JOIN dim_customers c
    ON f.customer_code = c.customer_code
GROUP BY c.market, f.date
ORDER BY c.market, f.date;

--Seasonal Sales Patterns:
--Explore the fact_monthly_sales table to identify seasonal sales patterns. How do sales volumes vary throughout the year, and are there any recurring trends? 
SELECT MONTH(date) AS month,product_code,SUM(sold_quantity) AS total_sales_volume
FROM fact_sales_monthly GROUP BY product_code, MONTH(date) ORDER BY product_code, month;

--Customer Loyalty Analysis: 
--Analyze customer purchase frequency and retention rates over time. Which customers exhibit the highest levels of loyalty, and how can their behavior be leveraged for targeted marketing campaigns? 
SELECT 
    s.customer_code,
    COUNT(DISTINCT s.date) AS purchase_frequency,
    SUM(s.sold_quantity) AS total_quantity_purchased
FROM fact_sales_monthly s
GROUP BY s.customer_code
ORDER BY purchase_frequency DESC;

--Forecast Accuracy Evaluation: 
--Evaluate the accuracy of sales forecasts by comparing forecasted quantities with actual sales data. Are there any significant discrepancies, and how can forecast models be improved?
SELECT 
    f.date,
    f.product_code,
    f.sold_quantity,
    s.sold_quantity AS actual_sales,
    (s.sold_quantity - f.sold_quantity) AS forecast_error
FROM fact_sales_monthly f
JOIN fact_sales_monthly s
    ON f.date = s.date
    AND f.product_code = s.product_code
ORDER BY f.date, f.product_code;

--Channel Performance Assessment: 
--Compare sales performance across different sales channels (e.g., E-Commerce vs. Brick & Mortar). Which channels are most effective in driving sales, and are there any opportunities for optimization?
SELECT 
    c.channel,
    SUM(s.sold_quantity) AS total_quantity_sold,
    SUM(s.sold_quantity * g.gross_price) AS total_revenue
FROM fact_sales_monthly s
JOIN dim_customers c
    ON s.customer_code = c.customer_code
JOIN fact_gross_price g
    ON s.product_code = g.product_code
GROUP BY c.channel
ORDER BY total_revenue DESC;

SELECT 
    c.channel,
    SUM(s.sold_quantity * g.gross_price) AS revenue,
    ROUND(
        SUM(s.sold_quantity * g.gross_price) * 100 /
        SUM(SUM(s.sold_quantity * g.gross_price)) OVER (),2
    ) AS revenue_percentage
FROM fact_sales_monthly s
JOIN dim_customers c
    ON s.customer_code = c.customer_code
JOIN fact_gross_price g
    ON s.product_code = g.product_code
GROUP BY c.channel
ORDER BY revenue DESC;

--Geographical Sales Distribution: 
--Analyze sales distribution across different geographical regions. How does sales performance vary by region, and are there any emerging markets worth focusing on?
SELECT 
    c.market AS region,
    SUM(s.sold_quantity) AS total_quantity_sold,
    SUM(s.sold_quantity * g.gross_price) AS total_revenue
FROM fact_sales_monthly s
JOIN dim_customers c
    ON s.customer_code = c.customer_code
JOIN fact_gross_price g
    ON s.product_code = g.product_code
GROUP BY c.market
ORDER BY total_revenue DESC;



--Customer Acquisition Cost Analysis: 
--Calculate the customer acquisition cost (CAC) for each market and channel. Which acquisition channels provide the highest return on investment (ROI), and where should resources be allocated for customer acquisition? 
WITH new_customers AS (
    SELECT 
        customer_code,
        MIN(date) AS first_purchase_year
    FROM fact_sales_monthly
    GROUP BY customer_code
)
SELECT 
    c.market,
    c.channel,
    COUNT(n.customer_code) AS new_customers_acquired
FROM new_customers n
JOIN dim_customers c
    ON n.customer_code = c.customer_code
GROUP BY c.market, c.channel
ORDER BY new_customers_acquired DESC;




--Product Mix Optimization: 
--Determine the optimal product mix based on sales volume, profitability, and market demand. How can product portfolios beadjusted to maximize overall revenue?
SELECT 
    p.product_code,
    p.product,
    SUM(s.sold_quantity) AS total_sales_volume,
    SUM(s.sold_quantity * g.gross_price) AS total_revenue,
    AVG(m.manufacturing_cost) AS manufacturing_cost,
    AVG(g.gross_price) AS gross_price,
    (AVG(g.gross_price) - AVG(m.manufacturing_cost)) AS profit_per_unit
FROM fact_sales_monthly s
JOIN product_code p
    ON s.product_code = p.product_code
JOIN fact_gross_price g
    ON s.product_code = g.product_code
JOIN fact_manufacturing_cost m
    ON s.product_code = m.product_code
GROUP BY p.product_code, p.product
ORDER BY total_revenue DESC;

--Customer Lifetime Value Calculation: 
--Calculate the customer lifetime value (CLV) for each customer segment. Which segments are the most valuable in terms of long-term revenue generation? 
SELECT 
    c.market AS customer_segment,
    SUM(s.sold_quantity * g.gross_price) AS total_clv,
    AVG(s.sold_quantity * g.gross_price) AS avg_clv_per_customer
FROM fact_sales_monthly s
JOIN dim_customers c
    ON s.customer_code = c.customer_code
JOIN fact_gross_price g
    ON s.product_code = g.product_code
GROUP BY c.market
ORDER BY total_clv DESC;

--Inventory Management Analysis:
--Analyze inventory turnover rates and identify slow-moving or obsolete products. How can inventory management practices be optimized to reduce carrying costs and improve cash flow? 
SELECT 
    p.product_code,
    p.product,
    SUM(s.sold_quantity) AS total_units_sold
FROM fact_sales_monthly s
JOIN product_code p
    ON s.product_code = p.product_code
GROUP BY p.product_code, p.product
ORDER BY total_units_sold ASC;



--Competitor Benchmarking: 
--Compare sales performance with competitors in the same market segments. How does your company's market share and growth rate compare to industry benchmarks? 
SELECT 
    company_name,
    SUM(sales_amount) AS total_sales
FROM sales_data
GROUP BY company_name
ORDER BY total_sales DESC;


--Price Elasticity Estimation: 
--Assess the price elasticity of demand for different product categories. How sensitive are sales volumes to changes in product prices, and what pricing strategies can be implemented to maximize revenue?
SELECT 
    product_category,
    year,
    AVG(price) AS avg_price,
    SUM(quantity_sold) AS total_quantity
FROM sales_data
GROUP BY product_category, year
ORDER BY product_category, year;

--Customer Satisfaction Analysis: 
--Utilize customer feedback data to assess overall satisfaction levels and identify areas for improvement. How do customer satisfaction scores correlate with sales performance? 
SELECT 
    customer_code,
    AVG(satisfaction_score) AS avg_satisfaction_score
FROM customer_feedback
GROUP BY customer_code;

--Marketing Campaign Effectiveness:
--Evaluate the effectiveness of marketing campaigns in driving sales and brand awareness. Which campaigns have yielded the highest return on investment, and how can future campaigns be optimized for better results?
SELECT 
    mc.campaign_id,
    mc.campaign_name,
    SUM(fs.sold_quantity * fs.gross_price) AS total_sales
FROM marketing_campaigns mc
JOIN fact_sales_monthly fs
ON fs.date BETWEEN mc.start_date AND mc.end_date
GROUP BY mc.campaign_id, mc.campaign_name
ORDER BY total_sales DESC;

---Task-5 
--1. Define a user-defined function to calculate the total forecasted quantity for a given product and fiscal year. 
CREATE FUNCTION get_total_forecast_quantity (
    p_product_code VARCHAR(20),
    p_fiscal_year INT
)
RETURNS INT
DETERMINISTIC
BEGIN

    DECLARE total_forecast INT;

    SELECT SUM(forecast_quantity)
    INTO total_forecast
    FROM fact_forecast_monthly
    WHERE product_code = p_product_code
    AND fiscal_year = p_fiscal_year;

    RETURN total_forecast;

END;
--2. Write a query to find the customers who made purchases exceeding the average monthly sales quantity across all products. 
WITH avg_monthly_sales AS (
    SELECT 
        AVG(monthly_qty) AS avg_qty
    FROM (
        SELECT 
            date,
            SUM(sold_quantity) AS monthly_qty
        FROM fact_sales_monthly
        GROUP BY date
    ) t
)

SELECT 
    customer_code,
    date,
    SUM(sold_quantity) AS customer_monthly_sales
FROM fact_sales_monthly
GROUP BY customer_code, date
HAVING SUM(sold_quantity) > (SELECT avg_qty FROM avg_monthly_sales)
ORDER BY customer_monthly_sales DESC;

--3. Create a stored procedure to update the gross price of a product for a specific fiscal year. 
DELIMITER //

CREATE PROCEDURE update_gross_price(
    IN p_product_code VARCHAR(20),
    IN p_fiscal_year INT,
    IN p_new_price DECIMAL(10,2)
)

BEGIN

UPDATE fact_gross_price
SET gross_price = p_new_price
WHERE product_code = p_product_code
AND fiscal_year = p_fiscal_year;

END //

DELIMITER ;

--4. Implement a trigger that automatically inserts a record into the audit log table whenever a new entry is added to the sales table.
DELIMITER //

CREATE TRIGGER sales_insert_audit
AFTER INSERT ON fact_sales_monthly
FOR EACH ROW
BEGIN

INSERT INTO sales_audit_log (
    product_code,
    customer_code,
    sold_quantity,
    action_type,
    action_time
)

VALUES (
    NEW.product_code,
    NEW.customer_code,
    NEW.sold_quantity,
    'INSERT',
    NOW()
);

END //

DELIMITER ;

--5. Use a window function to rank products based on their monthly sales quantity, partitioned by fiscal year. 
SELECT 
    fiscal_year,
    product_code,
    SUM(sold_quantity) AS total_sales,

    DENSE_RANK() OVER(
        PARTITION BY fiscal_year
        ORDER BY SUM(sold_quantity) DESC
    ) AS rank_in_year

FROM fact_sales_monthly
GROUP BY fiscal_year, product_code;


--6. Utilize the STRING_AGG function to concatenate the names of all customers who purchased a specific product within a given timeframe. 
SELECT 
    fs.product_code,
    STRING_AGG(dc.customer, ', ') AS customers_list
FROM fact_sales_monthly fs
JOIN dim_customers dc
ON fs.customer_code = dc.customer_code
WHERE fs.product_code = 'P001'
AND fs.date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY fs.product_code;

--7. Develop a user-defined function that calculates the total manufacturing cost for a product over a specified range of years, using a subquery to retrieve the necessary data.
DELIMITER //

CREATE FUNCTION total_manufacturing_cost_range(
    p_product_code VARCHAR(20),
    start_year INT,
    end_year INT
)

RETURNS DECIMAL(12,2)
DETERMINISTIC

BEGIN

    DECLARE total_cost DECIMAL(12,2);

    SELECT SUM(manufacturing_cost)
    INTO total_cost
    FROM (
        SELECT manufacturing_cost
        FROM fact_manufacturing_cost
        WHERE product_code = p_product_code
        AND cost_year BETWEEN start_year AND end_year
    ) AS cost_data;

    RETURN total_cost;

END //

DELIMITER ;



