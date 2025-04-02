-- Check for table
SELECT *
FROM sql_retail_store.retail_sales_staging;

-- DATA EXPLORATION
-- There are 1987 records
SELECT count(*)
FROM sql_retail_store.retail_sales_staging;

-- There are 155 DIFFERENT customers
SELECT count(DISTINCT customer_id)
FROM sql_retail_store.retail_sales_staging;

-- There are 3 DIFFERENT category
SELECT count(DISTINCT category)
FROM sql_retail_store.retail_sales_staging;

-- DATA ANALYSIS
-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT *
FROM sql_retail_store.retail_sales_staging
WHERE sale_date = "2022-11-05";

-- Q.2 Write a SQL query to retrieve all transactions where the category is 
-- 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
SELECT *
FROM sql_retail_store.retail_sales_staging
WHERE category = "Clothing" and `retail_sales_staging`.`quantiy` >= 4 and month(sale_date) = "11";

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category,sum(total_sale) as total_revenue
FROM sql_retail_store.retail_sales_staging
group by category
order by total_revenue  desc

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age), 2) as average_age
FROM sql_retail_store.retail_sales_staging
where category ="Beauty";

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT *
FROM sql_retail_store.retail_sales_staging
where total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category,gender,count(`retail_sales_staging`.`ï»¿transactions_id`) as no_of_transaction
FROM sql_retail_store.retail_sales_staging
group by category,gender
order by no_of_transaction desc

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- start date is 2022-01-01
SELECT min(sale_date)
FROM sql_retail_store.retail_sales_staging
-- end date is 2023-12-31
SELECT max(sale_date)
FROM sql_retail_store.retail_sales_staging

-- Write a SQL query to calculate the average sale for each month
SELECT month(sale_date) as months ,avg(total_sale) as average_revenue
FROM sql_retail_store.retail_sales_staging
group by months
order by months asc

-- Find out best selling month in each year
-- Write a SQL query to calculate the average sale for each month

-- Initial build up
SELECT year(sale_date) as years,month(sale_date) as months ,avg(total_sale) as average_revenue
FROM sql_retail_store.retail_sales_staging
group by years, months
order by years asc

-- Final result
with cte as (
SELECT year(sale_date) as years,month(sale_date) as months ,avg(total_sale) as average_revenue
FROM sql_retail_store.retail_sales_staging
group by years, months
)
select years,months,average_revenue,RANK() OVER (PARTITION BY years ORDER BY average_revenue DESC) AS month_rank
from cte
ORDER BY years ASC, month_rank ASC;

-- 2nd way
SELECT year(sale_date) as years,month(sale_date) as months ,avg(total_sale) as average_revenue,
RANK() OVER(PARTITION BY year(sale_date) ORDER BY avg(total_sale) DESC) as month_rank
FROM sql_retail_store.retail_sales_staging
group by years, months
order by years asc

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id,sum(total_sale) as total_revenue
FROM sql_retail_store.retail_sales_staging
group by customer_id
order by total_revenue desc
limit 5

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category,count(DISTINCT customer_id) as unique_custoemrs
FROM sql_retail_store.retail_sales_staging
group by category
order by unique_custoemrs desc

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

-- Initial Build Up
SELECT *,CASE 
WHEN sale_time < "12:00:00" THEN "Morning" 
WHEN sale_time >= "12:00:00" and sale_time < "17:00:00"  THEN "Afternoon" 
ELSE "Evening"
END AS shift
FROM sql_retail_store.retail_sales_staging

-- Fianl Result
WITH cte as (
SELECT *,CASE 
WHEN sale_time < "12:00:00" THEN "Morning" 
WHEN sale_time >= "12:00:00" and sale_time < "17:00:00"  THEN "Afternoon" 
ELSE "Evening"
END AS shift
FROM sql_retail_store.retail_sales_staging
)
select shift,count(*) as count_of_orders
from cte
group by shift
order by count_of_orders desc

-- END of PROJECT