USE sql_retail_store;

select *
from  retail_sales

select count(*)
from  retail_sales

-- FIRST THING we want to do is create a staging table. This is the one we will work in and clean the data.
--  We want a table with the raw data in case something happens
CREATE TABLE sql_retail_store.retail_sales_staging 
LIKE sql_retail_store.retail_sales;

-- check table wthether created or not
select *
from  retail_sales_staging

INSERT retail_sales_staging 
SELECT * FROM sql_retail_store.retail_sales;

-- check table wthether created or not
select *
from  retail_sales_staging


-- now when we are data cleaning we usually follow a few steps
-- 1. check for duplicates and remove any
-- 2. standardize data and fix errors
-- 3. Look at null values and see what 
-- 4. remove any columns and rows that are not necessary - few ways

-- 1. Remove Duplicates
# First let's check for duplicates

SELECT *
FROM sql_retail_store.retail_sales_staging;

-- THESE ARE OUR REAL DUPLICATES
-- Create a new col to extreme right to see whether record id duplicate or not
SELECT ï»¿transactions_id, sale_date, sale_time, customer_id,gender,age, category,`quantiy`, price_per_unit,cogs,total_sale,
	ROW_NUMBER() OVER (
	PARTITION BY ï»¿transactions_id, sale_date, sale_time, customer_id,gender,age, category, `quantiy`, price_per_unit,cogs,total_sale
) AS row_num
 FROM 
		sql_retail_store.retail_sales_staging;           

-- Check whether any record is duplicate
-- No records are retrieved means no duplicate records exist
SELECT *
FROM (
	SELECT ï»¿transactions_id, sale_date, sale_time, customer_id,gender,age, category,`quantiy`, price_per_unit,cogs,total_sale,
		ROW_NUMBER() OVER (
			PARTITION BY ï»¿transactions_id, sale_date, sale_time, customer_id,gender,age, category, `quantiy`, price_per_unit,cogs,total_sale
			) AS row_num
	FROM 
		sql_retail_store.retail_sales_staging
) duplicates
WHERE 
	row_num > 1;

-- CHECK FOR NULL or BLANK VALUES Iin COLUMNS
-- "ï»¿transactions_id" col
SELECT *
FROM sql_retail_store.retail_sales_staging
WHERE ï»¿transactions_id IS NULL 

-- "sale_date" col
SELECT *
FROM sql_retail_store.retail_sales_staging
WHERE sale_date IS NULL 

-- "sale_time" col
SELECT *
FROM sql_retail_store.retail_sales_staging
WHERE sale_time IS NULL 

-- "customer_id" col
SELECT *
FROM sql_retail_store.retail_sales_staging
WHERE customer_id IS NULL 

-- "gender" col
SELECT *
FROM sql_retail_store.retail_sales_staging
WHERE gender IS NULL 

-- "age" col
SELECT *
FROM sql_retail_store.retail_sales_staging
WHERE age IS NULL 

-- "category" col
SELECT *
FROM sql_retail_store.retail_sales_staging
WHERE category IS NULL 

-- "quantity" col
SELECT *
FROM sql_retail_store.retail_sales_staging
WHERE quantiy IS NULL 

-- "price_per_unit" col
SELECT *
FROM sql_retail_store.retail_sales_staging
WHERE price_per_unit IS NULL 

-- "cogs" col
SELECT *
FROM sql_retail_store.retail_sales_staging
WHERE cogs IS NULL 

-- Check for null values using multiple cols
-- Youcan check wthether records in imp cols are empty if null remove those records or do replacement
SELECT * FROM retail_sales
WHERE
	
    ï»¿transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    customer_id IS NULL
    OR
    gender IS NULL
    OR
    age IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    price_per_unit IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
    
-- "total_sale" col
SELECT *
FROM sql_retail_store.retail_sales_staging
WHERE total_sale IS NULL 
-- no null values in any columns so we can proceed to do DATA EXPLORATION

-- 3. Standardize Data
-- You can observe that sale_dateand sale_time cols are in TEXT format not in DATE and TIME format
ALTER TABLE sql_retail_store.retail_sales_staging
    MODIFY sale_date DATE,
    MODIFY sale_time TIME;
    
-- Check for table
SELECT *
FROM sql_retail_store.retail_sales_staging;
