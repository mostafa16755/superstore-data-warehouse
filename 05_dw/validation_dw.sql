-- clean orders count
SELECT COUNT(*) FROM clean.orders;
-- fact count
SELECT COUNT(*) FROM dw.fact_orders;

-- Check NULL foreign keys
SELECT
    COUNT(*) FILTER (WHERE customer_key IS NULL) AS customer_nulls,
    COUNT(*) FILTER (WHERE product_key IS NULL) AS product_nulls,
    COUNT(*) FILTER (WHERE location_key IS NULL) AS location_nulls,
    COUNT(*) FILTER (WHERE order_date_key IS NULL) AS order_date_nulls
FROM dw.fact_orders;

SELECT *
FROM dw.fact_orders
LIMIT 10;
