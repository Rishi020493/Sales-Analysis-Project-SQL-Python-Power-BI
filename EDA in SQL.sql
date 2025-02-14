-- Basic Exploratory Data Analysis (EDA) using SQL
-- This EDA will let us understand our data little bit

-- How many total records are there in transactions table?

SELECT count(*) FROM sales.transactions;

-- Total sales transactions
# 150283

-- How many customers we have?

SELECT count(*) FROM sales.customers;

-- customers
#38

-- Which years of data are available in our records?

select distinct year from sales.date

/*
year
2017
2018
2019
2020
*/
-- We have in total 4 years of data from 2027 to 2022


-- Which product_code had the highest sales in year 2020?

SELECT t.product_code,
SUM(t.sales_amount) as total_sales
FROM sales.transactions t
JOIN sales.date d
ON t.order_date = d.date
WHERE d.year = 2020
GROUP BY 1
ORDER BY 2 DESC
limit 1;

# Prod318	8785483 

-- Which product_code had second highest sales in year 2019?

WITH salesrank AS (
	SELECT t.product_code as product_code,
    SUM(t.sales_amount) as total_sales,
    ROW_NUMBER() OVER(ORDER BY SUM(t.sales_amount) DESC) AS rank_
    FROM sales.transactions t
    JOIN sales.date d
    ON t.order_date = d.date
    WHERE d.year = 2019
    GROUP BY 1
    )
SELECT product_code, total_sales
FROM salesrank
WHERE rank_=2;

# Prod316	21026709

-- What are the product types we have?
select distinct product_type from sales.products;
-- Which is the top 1 average product type by sales quantity in year 2020?

SELECT p.product_type AS product_type,
ROUND(AVG(t.sales_qty)) AS AVERAGE_QUANTITY
FROM sales.transactions t
JOIN sales.date d
ON t.order_date = d.date
JOIN sales.products p
ON t.product_code = p.product_code
WHERE d.year = 2020
GROUP BY 1
LIMIT 1;


/*
product_type	AVERAGE_QUANTITY
Own Brand		23
*/

-- Customers Analysis

-- Name the customers we have

select distinct customer_code, custmer_name from sales.customers;

/*
customer_code 	custmer_name
Cus001	Surge Stores
Cus002	Nomad Stores
Cus003	Excel Stores
Cus004	Surface Stores
Cus005	Premium Stores
Cus006	Electricalsara Stores
Cus007	Info Stores
Cus008	Acclaimed Stores
Cus009	Electricalsquipo Stores
Cus010	Atlas Stores
Cus011	Flawless Stores
Cus012	Integration Stores
Cus013	Unity Stores
Cus014	Forward Stores
Cus015	Electricalsbea Stores
Cus016	Logic Stores
Cus017	Epic Stores
Cus018	Electricalslance Stores
Cus019	Electricalsopedia Stores
Cus020	Nixon
Cus021	Modular
Cus022	Electricalslytical
Cus023	Sound
Cus024	Power
Cus025	Path
Cus026	Insight
Cus027	Control
Cus028	Sage
Cus029	Electricalsocity
Cus030	Synthetic
Cus031	Zone
Cus032	Elite
Cus033	All-Out
Cus034	Expression
Cus035	Relief
Cus036	Novus
Cus037	Propel
Cus038	Leader

*/

-- Top 5 customer with highest sales

SELECT c.*,
SUM(t.sales_amount)
from sales.customers c
JOIN sales.transactions t
ON (c.customer_code = t.customer_code)
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

/*
customer_code	custmer_name	customer_type	SUM(t.sales_amount)
Cus031			Zone			E-Commerce		5067349
Cus013			Unity Stores	Brick & Mortar	12618892
Cus030			Synthetic		E-Commerce		6173068
Cus001			Surge Stores	Brick & Mortar	28833717
Cus004			Surface Stores	Brick & Mortar	15249738

*/