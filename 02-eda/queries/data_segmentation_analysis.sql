/*=========================================================================
DATA SEGMENTATION ANALYSIS
===========================================================================
Purpose:
    * To group data (bucketing) into meaningful categories for targeted insights
    * For customer segmentation, product categorization, or regional analysis

SQL Functions Used:
    - COUNT(), DISTINCT, CASE WHEN
    - GROUP BY: Groups data into segments
===========================================================================
*/

/*Categorize products (model_name) into different profit margin ranges; find total products profit margin category
While making sure that the models with "High" profit margins are all active
    -"High": profit margin is greater than 30%
    -"Mid": profit margine is between 15 & 29.99%
    -"Low": profit margin is below 15%

*/
SELECT
    profit_margin_category,
    COUNT(*) AS profit_margin_count
FROM
(
SELECT
    category,
    model_name,
    profit_margin,
    CASE
        WHEN profit_margin >=30 THEN 'High'
        WHEN profit_margin BETWEEN 15 AND 29.99 THEN 'Mid'
        ELSE 'Low'
    END AS profit_margin_category,
    is_active
FROM
(
    SELECT
        category,
        model_name,
        CAST(
            ROUND(((average_sale_price - cost)/NULLIF(average_sale_price, 0)) * 100, 2) AS DECIMAL(10,2)) AS profit_margin,
        is_active
    FROM
    (
        SELECT
            d.category,
            d.model_name,
            AVG(f.sale_price) AS average_sale_price,
            d.cost,
            d.is_active
        FROM gold.fact_sales AS f
        LEFT JOIN gold.dim_products AS d
        ON f.product_key = d.product_key
        GROUP BY d.category, d.model_name, d.cost, d.is_active
    ) AS t
) AS tt
) AS ttt
GROUP BY profit_margin_category

/* Group customers into segmentds based on their spending behavior:
    -VIP: Customers with spend of more than $15,000
    -Plus: Customers with spend between $5,000 - $15,000
    -Regular: Customers with less than $5,000 spend
*/

WITH customer_spend AS (
SELECT
    d.customer_id,
    d.first_name + ' ' + d.last_name AS full_name,
    SUM(sales_revenue) AS total_revenue
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS d
ON f.customer_key = d.customer_key
GROUP BY d.customer_id, d.first_name + ' ' + d.last_name
)
SELECT
    customer_type,
    COUNT(*) AS customer_count
FROM
(
SELECT
    customer_id,
    full_name,
    total_revenue,
    CASE
        WHEN total_revenue > 15000 THEN 'VIP'
        WHEN total_revenue BETWEEN 5000 AND 14999 THEN 'Plus'
        ELSE 'Regular'
        END AS customer_type
FROM customer_spend
) AS t
GROUP BY customer_type
ORDER BY customer_count DESC