/*=========================================================================
DATE EXPLORATION
===========================================================================
Purpose: 
    To find the date range for our data along with specific date column

SQL Functions Used:
    -Max()
    -MIN()
    -DATEDIFF()

============================================================================
*/

--Determine the first and last order date and the total duration in months
SELECT
    MIN(order_date) AS first_order,
    MAX(order_date) AS last_order,
    DATEDIFF(month, MIN(order_date), MAX(order_date)) AS order_range_months
FROM gold.fact_sales

--Retrieve the number of new customers per year
SELECT
    YEAR(signup_date) AS year,
    COUNT(DATETRUNC(year, signup_date)) AS new_customers
FROM gold.dim_customers
GROUP BY 