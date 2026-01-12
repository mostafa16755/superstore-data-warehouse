-- Check data volume
SELECT COUNT(*) FROM staging.stg_orders;

-- Explore first 10 rows
SELECT * FROM staging.stg_orders LIMIT 10;

-- Check for Unique Orders
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_orders
FROM staging.stg_orders;

-- Duplicates Analysis
SELECT
    order_id,
    product_id,
    COUNT(*) AS cnt
FROM staging.stg_orders
GROUP BY order_id, product_id
HAVING COUNT(*) > 1;

-- Nulls Analysis (for critical columns)
SELECT
    COUNT(*) FILTER (WHERE order_id IS NULL) AS order_id_nulls,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS customer_id_nulls,
    COUNT(*) FILTER (WHERE product_id IS NULL) AS product_id_nulls,
    COUNT(*) FILTER (WHERE sales IS NULL) AS sales_nulls,
	COUNT(*) FILTER (WHERE order_date IS NULL) AS order_date_nulls
FROM staging.stg_orders;

-- Check if there is shipping date before order date
SELECT COUNT(*)
FROM staging.stg_orders
WHERE TO_DATE(ship_date, 'DD-MM-YYYY')
    < TO_DATE(order_date, 'DD-MM-YYYY');

-- Numeric Fields Validation
SELECT
    COUNT(*) FILTER (WHERE sales <= 0) AS negative_sales_count,
    COUNT(*) FILTER (WHERE quantity <= 0) AS negative_quantity_count,
	COUNT(*) FILTER (WHERE shipping_cost <= 0) AS negative_shipping_cost_count
FROM staging.stg_orders;

-- Check if there are discounts out of the range
SELECT COUNT(*)
FROM staging.stg_orders
WHERE discount < 0 OR discount > 1;

-- Check for extra spaces
SELECT
    COUNT(*) FILTER (WHERE customer_name <> TRIM(customer_name)) AS customer_name_trim_issues,
    COUNT(*) FILTER (WHERE ship_mode <> TRIM(ship_mode)) AS ship_mode_trim_issues,
    COUNT(*) FILTER (WHERE segment <> TRIM(segment)) AS segment_trim_issues,
    COUNT(*) FILTER (WHERE city <> TRIM(city)) AS city_trim_issues,
    COUNT(*) FILTER (WHERE state <> TRIM(state)) AS state_trim_issues,
    COUNT(*) FILTER (WHERE country <> TRIM(country)) AS country_trim_issues,
    COUNT(*) FILTER (WHERE market <> TRIM(market)) AS market_trim_issues,
    COUNT(*) FILTER (WHERE region <> TRIM(region)) AS region_trim_issues,
    COUNT(*) FILTER (WHERE category <> TRIM(category)) AS category_trim_issues,
    COUNT(*) FILTER (WHERE product_name <> TRIM(product_name)) AS product_name_trim_issues
FROM staging.stg_orders;

-- Check for empty strings in text columns that should be NULL
SELECT
    COUNT(*) FILTER (WHERE order_id = '') AS order_id_empty,
    COUNT(*) FILTER (WHERE customer_id = '') AS customer_id_empty,
    COUNT(*) FILTER (WHERE customer_name = '') AS customer_name_empty,
    COUNT(*) FILTER (WHERE segment = '') AS segment_empty,
    COUNT(*) FILTER (WHERE city = '') AS city_empty,
    COUNT(*) FILTER (WHERE state = '') AS state_empty,
    COUNT(*) FILTER (WHERE country = '') AS country_empty,
    COUNT(*) FILTER (WHERE market = '') AS market_empty,
    COUNT(*) FILTER (WHERE region = '') AS region_empty,
    COUNT(*) FILTER (WHERE product_id = '') AS product_id_empty,
    COUNT(*) FILTER (WHERE category = '') AS category_empty,
    COUNT(*) FILTER (WHERE product_name = '') AS product_name_empty
FROM staging.stg_orders;

-- validate ship mode
SELECT ship_mode, COUNT(*)
FROM staging.stg_orders
GROUP BY ship_mode
ORDER BY 2 DESC;

-- validate segments
SELECT segment, COUNT(*)
FROM staging.stg_orders
GROUP BY segment;

--distribution check for sales
SELECT
    MIN(sales) AS min_sales,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY sales) AS p25_sales,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY sales) AS median_sales,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY sales) AS p75_sales,
    MAX(sales) AS max_sales,
    AVG(sales) AS avg_sales
FROM staging.stg_orders;


--distribution check for shipping_cost
SELECT
    MIN(shipping_cost) AS min_shipping_cost,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY shipping_cost) AS p25_shipping_cost,
    PERCENTILE_CONT(0.5)  WITHIN GROUP (ORDER BY shipping_cost) AS median_shipping_cost,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY shipping_cost) AS p75_shipping_cost,
    MAX(shipping_cost) AS max_shipping_cost,
    AVG(shipping_cost) AS avg_shipping_cost
FROM staging.stg_orders;
