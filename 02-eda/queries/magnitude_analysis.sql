/*=========================================================================
MAGNITUDE ANALYSIS
===========================================================================
Purpose:
    * To begin to understand measure values within specific categories
    * To quantify data and group results by specific categories

SQL Functions Used:
    - Aggregate functions (SUM(), AVG(), COUNT())
    - GROUP BY, ORDER BY

===========================================================================
*/

--Calculate total sales for accessories sorted by most sales
SELECT
    d.category,
    SUM(sales_revenue) AS total_sales
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS d
ON f.product_key = d.product_key
WHERE d.category NOT IN('Hybrid Bike', 'Road Bike', 'Mountain Bike')
GROUP BY d.category
ORDER BY SUM(sales_revenue) DESC

--Calculate total sales for bikes
SELECT
d.category,
SUM(sales_revenue) AS total_sales
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS d
ON f.product_key = d.product_key
WHERE d.category IN ('Hybrid Bike', 'Road Bike', 'Mountain Bike')
GROUP BY d.category
ORDER BY SUM(sales_revenue) DESC

--Calculate the quantity of bikes sold
SELECT
    d.category,
    SUM(f.quantity) AS total_quantity
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS d
ON f.product_key = d.product_key
WHERE d.category IN('Hybrid Bike', 'Road Bike', 'Mountain Bike')
GROUP BY d.category
ORDER BY SUM(f.quantity) DESC

--Calculate the quantity of accessories sold
SELECT
    d.category,
    SUM(f.quantity) AS total_quantity
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS d
ON f.product_key = d.product_key
WHERE d.category NOT IN('Hybrid Bike', 'Road Bike', 'Mountain Bike')
GROUP BY d.category
ORDER BY SUM(f.quantity) DESC

--Calculate the average selling price for bikes
SELECT
    d.category,
    AVG(d.selling_price) AS average_selling_price
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS d
ON f.product_key = d.product_key
WHERE d.category IN('Hybrid Bike', 'Road Bike', 'Mountain Bike')
GROUP BY d.category
ORDER BY AVG(d.selling_price) DESC

--Caclulate the average selling price for accessories
SELECT
    d.category,
    AVG(d.selling_price) AS average_selling_price
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS d
ON f.product_key = d.product_key
WHERE d.category NOT IN('Hybrid Bike', 'Road Bike', 'Mountain Bike')
GROUP BY d.category
ORDER BY AVG(d.selling_price) DESC

--Number of customers that have placed an order
SELECT
    COUNT(DISTINCT f.customer_key) AS active_customers
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS d
ON f.customer_key = d.customer_key

--Double checking that all customers have indeed placed an order (result from above query)
SELECT
    f.customer_key
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS d
ON f.customer_key = d.customer_key
WHERE d.customer_key NOT IN(d.customer_key)

--Total customers per state
SELECT
    state,
    COUNT(*) AS total_customers
FROM GOLD.dim_customers
GROUP BY state
ORDER BY COUNT(*) DESC

--Total sales revenue per sales channel
SELECT
    sales_channel,
    SUM(sales_revenue) AS total_revenue
FROM gold.fact_sales
GROUP BY sales_channel
ORDER BY SUM(sales_revenue) DESC

--Total quantity per sales channel
SELECT
    sales_channel,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
GROUP BY sales_channel
ORDER BY SUM(quantity) DESC

--Total sales per store
SELECT
    store_name,
    SUM(sales_revenue) AS total_sales
FROM gold.fact_sales
GROUP BY store_name
ORDER BY SUM(sales_revenue) DESC

--Total quantity per store
SELECT
    store_name,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
GROUP BY store_name
ORDER BY SUM(quantity) DESC