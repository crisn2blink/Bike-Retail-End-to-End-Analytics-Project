/*=========================================================================
PERFORMANCE ANALYSIS (YoY / MoM)
===========================================================================
Purpose:
    * To compare performance of the current period (year) to the 
    overall average for customers, region, products
    * For benchmarking and identifying high-performing entities
    * To track yearly trends and frowth

SQL Functions Used:
    - CASE: Define conditional logic for trend analysis
    - AVG() OVER(): Calculate the average using partitions
    - LAG(): Access information from previous records

===========================================================================
*/

/* Analyze the yearly performance of products by comparing each product's sales 
to both their yearly average sales performance and their previous year's sales */
WITH yearly_product_sales AS (
SELECT
    DATETRUNC(year,f.order_date) AS order_year,
    d.model_name AS product,
    SUM(f.sales_revenue) AS total_revenue
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS d
ON f.product_key = d.product_key
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(year,f.order_date), d.model_name
)
SELECT
    order_year,
    product,
    total_revenue,
    AVG(total_revenue)OVER(PARTITION BY product) AS average_revenue,
    total_revenue - AVG(total_revenue)OVER(PARTITION BY product) AS diff_avg,
CASE
    WHEN total_revenue - AVG(total_revenue)OVER(PARTITION BY product) > 0 THEN 'Above Average'
    WHEN total_revenue - AVG(total_revenue)OVER(PARTITION BY product) < 0 THEN 'Below Average'
    ELSE 'Average'
END AS average_comparison,
    LAG(total_revenue,1) OVER(PARTITION BY product ORDER BY product, order_year) AS previous_year_revenue,
    total_revenue - (LAG(total_revenue,1) OVER(PARTITION BY product ORDER BY product, order_year)) AS change_in_revenue,
CASE
    WHEN total_revenue - (LAG(total_revenue,1) OVER(PARTITION BY product ORDER BY product, order_year)) IS NULL THEN 'No Previous Year'
    WHEN total_revenue - (LAG(total_revenue,1) OVER(PARTITION BY product ORDER BY product, order_year)) > 0 THEN 'Increase'
    WHEN total_revenue - (LAG(total_revenue,1) OVER(PARTITION BY product ORDER BY product, order_year)) < 0 THEN 'Decrease'
    ELSE 'No Change'
END AS previous_year_comparison
FROM yearly_product_sales