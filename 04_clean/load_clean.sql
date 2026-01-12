-- Data Cleaning Rules:
--   - Remove duplicate records based on (order_id, product_id)
--   - Convert order_date and ship_date to DATE type
--   - Handle multiple date formats (DD-MM-YYYY, DD/MM/YYYY)
--   - Trim extra spaces from product_name
--   - Convert shipping_cost = 0 to NULL

-- Create a cleaned view applying all business and data quality rules
CREATE OR REPLACE VIEW clean.v_orders_cleaned AS
SELECT
    row_id,
    order_id,
    TO_DATE(order_date, 'DD-MM-YYYY') AS order_date,
    TO_DATE(ship_date, 'DD-MM-YYYY') AS ship_date,
    ship_mode,
    customer_id,
    customer_name,
    segment,
    city,
    state,
    country,
    postal_code,
    market,
    region,
    product_id,
    category,
    sub_category,
    TRIM(product_name) AS product_name,
    sales,
    quantity,
    discount,
    profit,
    NULLIF(shipping_cost, 0) AS shipping_cost,
    order_priority,
    load_date
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY order_id, product_id
               ORDER BY row_id
           ) AS rn
    FROM staging.stg_orders
) t
WHERE rn = 1;


-- Load cleaned data into clean.orders table (Explicit column mapping ensures schema safety)
INSERT INTO clean.orders (
    row_id,
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    customer_name,
    segment,
    city,
    state,
    country,
    postal_code,
    market,
    region,
    product_id,
    category,
    sub_category,
    product_name,
    sales,
    quantity,
    discount,
    profit,
    shipping_cost,
    order_priority,
    load_date
)
SELECT
    row_id,
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    customer_name,
    segment,
    city,
    state,
    country,
    postal_code,
    market,
    region,
    product_id,
    category,
    sub_category,
    product_name,
    sales,
    quantity,
    discount,
    profit,
    shipping_cost,
    order_priority,
    load_date
FROM clean.v_orders_cleaned;