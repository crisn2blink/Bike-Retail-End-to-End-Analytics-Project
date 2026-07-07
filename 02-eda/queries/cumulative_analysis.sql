/*=========================================================================
CUMMULATIVE ANALYSIS
===========================================================================
Purpose:
    * To evaluate whether our business is growing or shrinking over time
    * Aggregate our data proggresively over time

SQL Funcitons Used:
    - Window Functions: SUM() OVER(), AVG OVER()
    - Date aggregations: DATRUNC()

===========================================================================
*/

--Calculate a running total and the moving average for revenue across time
SELECT
    order_month,
    total_revenue,
    SUM(total_revenue) OVER(ORDER BY order_month) AS running_total,
    AVG(total_revenue) OVER(ORDER BY order_month) AS moving_average
FROM
(
    SELECT
        DATETRUNC(month, order_date) AS order_month,
        SUM(sales_revenue) AS total_revenue
    FROM gold.fact_sales
    GROUP BY DATETRUNC(month, order_date)
) AS t