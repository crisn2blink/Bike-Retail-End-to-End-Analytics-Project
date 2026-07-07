/*=========================================================================
RANKING ANALYSIS
===========================================================================
Purpose:
    * To rank items (ex: products, customers) based on performance
    * To identify leaders or laggards in a category

SQL Funcitons Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER, TOP
    - Clauses: GROUP BY, ORDER BY

===========================================================================
*/

--Calculate the profit for Top 10 bikes in DESC order
SELECT TOP 10
    category,
    model_name,
    AVG(profit_margin) AS average_profit_margin,
    is_active
FROM(
    SELECT
        d.model_name,
        f.sale_price,
        d.cost,
        d.category,
        (f.sale_price - d.cost) AS profit_margin,
        d.is_active
    FROM gold.fact_sales AS f
    LEFT JOIN gold.dim_products AS d
    ON f.product_key = d.product_key
) AS t
WHERE category IN('Hybrid Bike', 'Road Bike', 'Mountain Bike')
GROUP BY category, model_name, is_active
ORDER BY AVG(profit_margin) DESC

--Calculate the profit for Top 10 accessories in DESC order
SELECT TOP 10
    category,
    model_name,
    AVG(profit_margin) AS average_profit_margin,
    is_active
FROM(
    SELECT
        d.model_name,
        d.cost,
        f.sale_price,
        d.category,
        (f.sale_price - d.cost) AS profit_margin,
        d.is_active
    FROM gold.fact_sales AS f
    LEFT JOIN gold.dim_products AS d
    ON f.product_key = d.product_key
) AS t
WHERE category NOT IN('Hybrid Bike', 'Road Bike', 'Mountain Bike')
GROUP BY category, model_name, is_active
ORDER BY AVG(profit_margin) DESC

--Top 5 products (models) in each category that have the highest average profit
SELECT
*
FROM(
    SELECT
    *,
    RANK() OVER(PARTITION BY category ORDER BY profit DESC) AS top_profit_products
    FROM(
        SELECT
            d.category,
            d.model_name,
            AVG(f.sale_price - d.cost) AS profit
        FROM gold.fact_sales AS f
        LEFT JOIN gold.dim_products AS d
        ON f.product_key = d.product_key
        GROUP BY d.category, d.model_name
    ) AS t
) AS tt
WHERE top_profit_products <= 5

--Top 10 customers by sales revenue
SELECT
*,
CASE
    WHEN total_revenue >= 40000 THEN 'Premier Status'
    WHEN total_revenue BETWEEN 20000 AND 39999 THEN 'Plus Status'
    ELSE 'Normal Status'
END AS customer_status
FROM(
    SELECT
        d.customer_key,
        (d.first_name + ' ' + d.last_name) AS customer_name,
        SUM(f.sales_revenue) AS total_revenue
    FROM gold.fact_sales AS f
    LEFT JOIN gold.dim_customers AS d
    ON f.customer_key = d.customer_key
    GROUP BY d.customer_key, (d.first_name + ' ' + d.last_name)
) AS t
ORDER BY total_revenue DESC
