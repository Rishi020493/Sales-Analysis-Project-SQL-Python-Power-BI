-- Creating new databse named "sales" for sales insights data analysis project

CREATE DATABASE sales;

-- Creating Tables for our analysis
-- Customers Table

USE sales;
CREATE TABLE customers (
customer_code VARCHAR(20) PRIMARY KEY,
custmer_name VARCHAR(50),
customer_type varchar(50)
);

-- date Table

CREATE TABLE date (
date DATE PRIMARY KEY,
cy_date DATE,
year INT, 
month_name VARCHAR(50),
date_yy_mmm VARCHAR(50)
);

-- market Table

CREATE TABLE market (
markets_code VARCHAR(50) PRIMARY KEY,
markets_name VARCHAR(50),
zone VARCHAR(50)
);

-- product Table

CREATE TABLE product (
product_code varchar(50) PRIMARY KEY,
product_type varchar(50)
);

-- tansaction Table
-- Since, transaction table is fact table we need to create relation with other dim tables.

CREATE TABLE transaction (
product_code varchar(50),
customer_code varchar(50),
markets_code varchar(50),
order_date date,
sales_qty int,
sales_amount double,
currency varchar(50),
FOREIGN KEY (product_code) REFERENCES product(product_code), -- referencing to product table
FOREIGN KEY (customer_code) REFERENCES customers(customer_code), -- referencing to product table
FOREIGN KEY (markets_code) REFERENCES market(markets_code), -- referencing to market table
FOREIGN KEY (order_date) REFERENCES date(date) -- referencing to date table
);