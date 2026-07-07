/*=========================================================================
CHANGE OVER TIME ANALYSIS
===========================================================================
Purpose: 
    * To analyze t=various business metrics as time progresses
    * To gain insight into the over-all performance of the business
    * Time-series analysis and identifying seasonality

SQL Funcitons Used:
    - Date aggregation: DATETRUNC(), MONTH, YEAR, DATEPART(), FORMAT()
    - Aggregate functions: SUM(), COUNT(), AVG()

===========================================================================
*/

/*Learn how the following metrics have changed YoY: total sales,
active customers and sales quantity*/
SELECT
    DATETRUNC(year, order_date) AS order_year,
    SUM(sales_revenue) AS total_sales,
    COUNT(DISTINCT customer_key) AS active_customers_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
GROUP BY DATETRUNC(year, order_date)

--Same as the above analysis using YEAR instead of DATETRUNC
SELECT
    YEAR(order_date) AS order_year,
    SUM(sales_revenue) AS total_sales,
    COUNT(DISTINCT customer_key) AS active_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
GROUP BY YEAR(order_date)

--Same as above analysiis using FORMAT isntead of YEAR
SELECT
    FORMAT(order_date, 'yyyy') AS order_year,
    SUM(sales_revenue) AS total_sales,
    COUNT(DISTINCT customer_key) AS active_customers,
    SUM(quantity) as total_quantity
FROM gold.fact_sales
GROUP BY FORMAT(order_date, 'yyyy')