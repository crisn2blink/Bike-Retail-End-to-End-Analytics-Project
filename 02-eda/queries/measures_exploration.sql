/*=========================================================================
MEASURES EXPLORATION
===========================================================================
Purpose:
    * To calculate aggregate measures (SUM, AVG, MAX etc.) for quick insights
    * To evaluate trends and find anomalities

SQL Functions Used
    -SUM()
    -AVG()
    -COUNT()

===========================================================================
*/

--Calculate the total number of orders
SELECT
    COUNT(sale_id) AS total_orders
FROM gold.fact_sales

--Calculate the total number of products
SELECT
    COUNT(DISTINCT model_name) AS total_products
FROM gold.dim_products

--Calculate the number of stores
SELECT
    COUNT(DISTINCT store_name) AS total_stores
FROM gold.fact_sales

--Calculate the number of sales channels
SELECT
COUNT(DISTINCT sales_channel) AS total_sales_channels
FROM gold.fact_sales