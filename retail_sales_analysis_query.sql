-- create the database
CREATE DATABASE sql_projec1;


-- create the table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender varchar(10),
	age INT,
	category varchar(25),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT

);

SELECT * FROM retail_sales;

SELECT COUNT(*) FROM retail_sales;

-- Data Cleaning

SELECT * FROM retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR	
	customer_id IS NULL
	OR
	gender IS NULL
	OR 	
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR	
	total_sale IS NULL

--

DELETE FROM retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR	
	customer_id IS NULL
	OR
	gender IS NULL
	OR 	
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR	
	total_sale IS NULL

-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) AS total_sales FROM retail_sales;

-- How many unique customer we have?
SELECT COUNT(DISTINCT customer_id) AS total_customer FROM retail_sales

-- What are the different category
SELECT category FROM retail_sales
GROUP BY category


-- Data Analysis Problem and answers

SELECT * FROM retail_sales

-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';


-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT * FROM retail_sales
WHERE 
	category = 'Clothing' 
	AND 
	quantiy >= 4 
	AND 
	(sale_date BETWEEN '2022-11-01' AND '2022-11-30');

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category, SUM(total_sale) AS net_sales, COUNT(total_sale) AS total_sales FROM retail_sales
GROUP BY category;

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT ROUND(AVG(age), 2) AS average_age FROM retail_sales
WHERE category = 'Beauty';

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT gender, category, COUNT(*) AS total_transaction FROM retail_sales
GROUP BY gender, category;

-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
WITH temp AS(
	SELECT 
		EXTRACT(YEAR FROM sale_date) AS year,
		EXTRACT(MONTH FROM sale_date) AS month,
		AVG(total_sale) AS average_sales,
		RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
	FROM retail_sales
	GROUP BY year, month
)
SELECT year, month, average_sales FROM temp
WHERE rank = 1

-- 8. Write a SQL query to find the top 5 customers based on the highest total sales
SELECT * FROM retail_sales

SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category

SELECT category, COUNT(DISTINCT customer_id) total_unique_customer FROM retail_sales
GROUP BY category

-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH data_with_shift AS(
	SELECT 
		*,
		CASE
			WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
			WHEN EXTRACT(HOUR FROM sale_time) >= 12 AND EXTRACT(HOUR FROM sale_time) < 17 THEN 'Afternoon'
			ELSE 'Evening'
		END AS shift
	FROM retail_sales
)
SELECT shift, COUNT(*) total_orders FROM data_with_shift
GROUP BY shift


















