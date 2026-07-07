/* ========================================================================
DIMENSION EXPLORATION
===========================================================================
Purpose:
    To explore the distinct values and structures of dimension tables

SQL Functions Used:
    -DISTINCT
    -ORDER BY

===========================================================================
*/

--Retrieves a list of unique state and city from which customers originate from
SELECT DISTINCT
    state,
    city
FROM gold.dim_customers
ORDER BY state, city

--Retrieves a list of unique categories, brands and model names for the products
SELECT DISTINCT
    brand,
    category,
    model_name
FROM gold.dim_products
ORDER BY brand, category, model_name

--Retrieve a list of the differenet sales channels and store names
SELECT DISTINCT
    sales_channel
FROM gold.fact_sales

SELECT DISTINCT
    store_name
FROM gold.fact_sales