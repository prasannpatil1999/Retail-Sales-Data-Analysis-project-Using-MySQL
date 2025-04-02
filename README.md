# Retail Sales Data Analysis project

## Tables of Contents: 
- [Project Overview](#project-overview)  
- [Tools Used](#tools-used)  
- [Data Sources](#data-sources)  
- [Data Cleaning/Preparation](#data-cleaningpreparation)  
- [Key Business Questions Answered](#key-business-questions-answered)  
- [Project Files](#project-files)  
- [How to Use](#how-to-use)  
- [Insights & Findings](#insights--findings)  
- [Recommendations](#recommendations)  
- [Conclusion](#conclusion)
  
### Project Overview
The "Retail Sales Data Analysis" project focuses on analyzing sales trends, customer purchasing behavior, and revenue patterns in the retail sector. It aims to provide insights for improving sales performance, inventory management, and strategic decision-making.

### Tools Used
- MySQL

### Data Sources
The "Retail Sales Analysis_utf.csv" file contains transactional data related to retail sales, including details such as product categories, sales revenue, transaction dates, customer demographics, and store locations. This dataset helps analyze sales trends, customer preferences, and overall business performance in the retail sector.

### Data Cleaning/Preparation
- In the initial data preparation phase, we performed the following tasks:

1. Imported data into the MySQL database and conducted an inspection.
2. Handled duplicates values, handles null and Blank values
3. Standardize Data by correcting spelling errors, typos, neither were found

### Key Business Questions Answered
- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05 ?
- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022 ?
- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category. ?
- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category. ?
- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000. ?
- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category. ?
- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year ?
- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales  ?
- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category. ?
- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17) ?

### Project Files
- 📊 "Retail Sales Analysis_utf.csv" (CSV File) - Contains all data.
- 📝 Problem Statement (Word File) - Outlines the business questions and objectives.

 ### How to Use
1. Review the Problem Statement Word file to understand the key objectives.
2. Use the Readme file to get answers

### Insights & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05 ?
````sql
SELECT *
FROM sql_retail_store.retail_sales_staging
WHERE sale_date = "2022-11-05";
````
**Results:**

- We get bunch of records that match condition

| Transaction ID | Sale Date  | Sale Time | Customer ID | Gender | Age | Category   | Quantity | Price Per Unit | COGS | Total Sales |
|--------------|------------|----------|------------|--------|-----|------------|----------|---------------|------|-------------|
| 180         | 2022-11-05 | 10:47:00 | 117        | Male   | 41  | Clothing   | 3        | 300           | 129  | 900         |
| 240         | 2022-11-05 | 11:49:00 | 95         | Female | 23  | Beauty     | 1        | 300           | 123  | 300         |
| 1256        | 2022-11-05 | 09:58:00 | 29         | Male   | 23  | Clothing   | 2        | 500           | 190  | 1000        |
| 1587        | 2022-11-05 | 20:06:00 | 140        | Female | 40  | Beauty     | 4        | 300           | 105  | 1200        |
| 1819        | 2022-11-05 | 20:44:00 | 83         | Female | 35  | Beauty     | 2        | 50            | 14   | 100         |
| 943         | 2022-11-05 | 19:29:00 | 90         | Female | 57  | Clothing   | 4        | 300           | 318  | 1200        |
| 1896        | 2022-11-05 | 20:19:00 | 87         | Female | 30  | Electronics| 2        | 25            | 31   | 50          |
| 1137        | 2022-11-05 | 22:34:00 | 104        | Male   | 46  | Beauty     | 2        | 500           | 145  | 1000        |
| 856         | 2022-11-05 | 17:43:00 | 102        | Male   | 54  | Electronics| 4        | 30            | 9    | 120         |
| 214         | 2022-11-05 | 16:31:00 | 53         | Male   | 20  | Beauty     | 2        | 30            | 8    | 60          |
| 1265        | 2022-11-05 | 14:35:00 | 86         | Male   | 55  | Clothing   | 3        | 300           | 111  | 900         |

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022 ?

````sql
SELECT *
FROM sql_retail_store.retail_sales_staging
WHERE category = "Clothing" and `retail_sales_staging`.`quantiy` >= 4 and month(sale_date) = "11";
````
**Results:**
- We get bunch of records that match conditions

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.?
````sql
SELECT category,sum(total_sale) as total_revenue
FROM sql_retail_store.retail_sales_staging
group by category
order by total_revenue  desc
````
**Results:**
| Category    | Total Revenue |
|------------|--------------|
| Electronics | 311,445      |
| Clothing    | 309,995      |
| Beauty      | 286,790      |
 
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.?
````sql
SELECT ROUND(AVG(age), 2) as average_age
FROM sql_retail_store.retail_sales_staging
where category ="Beauty";
````
**Results:**
Avereage age of custoemrs|
---------------------|
40.42    |
 
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.?
````sql
SELECT *
FROM sql_retail_store.retail_sales_staging
where total_sale > 1000
````
**Results:**
- Some 306 records matched the condition

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
````sql
SELECT category,gender,count(`retail_sales_staging`.`ï»¿transactions_id`) as no_of_transaction
FROM sql_retail_store.retail_sales_staging
group by category,gender
order by no_of_transaction desc
````
**Results:**
| Category    | Gender | No. of Transactions |
|------------|--------|---------------------|
| Clothing   | Male   | 351                 |
| Clothing   | Female | 347                 |
| Electronics| Male   | 343                 |
| Electronics| Female | 335                 |
| Beauty     | Female | 330                 |
| Beauty     | Male   | 281                 |
  
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
````sql
-- Write a SQL query to calculate the average sale for each month
SELECT month(sale_date) as months ,avg(total_sale) as average_revenue
FROM sql_retail_store.retail_sales_staging
group by months
order by months asc

-- Find out best selling month in each year
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

````
**Results:**
-- Write a SQL query to calculate the average sale for each month  
| Month | Average Revenue |
|-------|----------------|
| 1     | 396.79         |
| 2     | 453.63         |
| 3     | 453.45         |
| 4     | 485.19         |
| 5     | 463.87         |
| 6     | 457.12         |
| 7     | 464.96         |
| 8     | 444.55         |
| 9     | 473.19         |
| 10    | 433.16         |
| 11    | 463.42         |
| 12    | 474.83         |

-- Find out best selling month in each year
| Year | Month | Average Revenue | Month Rank |
|------|-------|----------------|------------|
| 2022 | 7     | 541.34         | 1          |
| 2022 | 3     | 521.22         | 2          |
| 2022 | 4     | 500.61         | 3          |
| 2022 | 9     | 485.20         | 4          |
| 2022 | 6     | 481.40         | 5          |
| 2022 | 5     | 480.00         | 6          |
| 2022 | 11    | 472.02         | 7          |
| 2022 | 10    | 467.14         | 8          |
| 2022 | 12    | 460.77         | 9          |
| 2022 | 1     | 397.11         | 10         |
| 2022 | 8     | 390.28         | 11         |
| 2022 | 2     | 366.14         | 12         |
| 2023 | 2     | 535.53         | 1          |
| 2023 | 8     | 495.96         | 2          |
| 2023 | 12    | 490.39         | 3          |
| 2023 | 4     | 466.49         | 4          |
| 2023 | 9     | 462.74         | 5          |
| 2023 | 11    | 453.45         | 6          |
| 2023 | 5     | 450.17         | 7          |
| 2023 | 6     | 438.48         | 8          |
| 2023 | 7     | 427.68         | 9          |
| 2023 | 10    | 399.17         | 10         |
| 2023 | 1     | 396.50         | 11         |
| 2023 | 3     | 394.81         | 12         |


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
````sql
SELECT customer_id,sum(total_sale) as total_revenue
FROM sql_retail_store.retail_sales_staging
group by customer_id
order by total_revenue desc
limit 5
````
**Results:**
| Customer ID | Total Revenue |
|------------|--------------|
| 3          | 38,440       |
| 1          | 30,750       |
| 5          | 30,405       |
| 2          | 25,295       |
| 4          | 23,580       |
 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
````sql
SELECT category,count(DISTINCT customer_id) as unique_custoemrs
FROM sql_retail_store.retail_sales_staging
group by category
order by unique_custoemrs desc
````
**Results:**
| Category    | Unique Customers |
|------------|------------------|
| Clothing   | 149              |
| Electronics| 144              |
| Beauty     | 141              |
  
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
````sql
-- Final Result
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
````
**Results:**
| Shift   | Order Count |
|---------|-------------|
| Evening | 1,275       |
| Morning | 548         |
| Afternoon| 164        |


### Recommendations
1. Sales on 2022-11-05: Analyze customer behavior for targeted marketing based on transaction frequency.

2. Clothing Category Transactions: Focus on increasing sales for clothing items with higher quantities.

3. Category-wise Revenue: Invest more in Electronics and Clothing to maximize revenue.

4. Average Age of Beauty Category Buyers: Tailor marketing strategies to target a mature customer base for beauty products.

5. Total Sales Above 1000: Offer premium or bundled deals for high-value transactions to maximize sales.

6. Gender-wise Transactions by Category: Develop gender-specific promotions to increase sales in each category.

7. Monthly Average Sales: Focus on boosting sales during low-performing months like February and January.

8. Top 5 Customers by Total Sales: Reward top customers with loyalty programs to retain their business.

9. Unique Customers per Category: Increase customer engagement strategies for categories with fewer unique buyers.

10. Shift-wise Order Count: Optimize staffing and inventory based on peak order times (evening) to improve service.

### Conclusion
The Retail Sales Data Analysis provides valuable insights into sales trends, customer demographics, and purchasing behavior. Electronics and Clothing drive the highest revenue, while evenings see the most orders. Targeted marketing strategies, customer loyalty programs, and optimized inventory management can enhance sales performance. Leveraging these insights will help improve decision-making, boost customer engagement, and maximize profitability.

### Author
- Prasannagoud Patil

### Email
- Prasannpatil31@gmail.com
