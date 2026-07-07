/*=========================================================================
PART TO WHOLE ANALYSIS
===========================================================================
Purpose:
    * Proportional analysis to identify percent of whole
    * To evaluate differences between columns

SQL Functions Used:
    - AVG(), SUM(): aggregate values for comparison
    - Window Fucntions: Sum() OVER() for total calculations

===========================================================================
*/

--Which categories contribute the most to the overall revenue
WITH category_sales AS (
SELECT
    d.category,
    SUM(f.sales_revenue) AS total_revenue
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_products AS d
ON f.product_key = d.product_key
GROUP BY d.category
)
SELECT
    category,
    total_revenue,
    SUM(total_revenue) OVER() AS overall_revenue,
    ROUND(CAST(total_revenue AS float)/SUM(total_revenue) OVER() * 100, 2) AS percentage_of_total
FROM category_sales
ORDER BY total_revenue DESC