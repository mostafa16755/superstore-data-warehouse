TRUNCATE TABLE staging.stg_orders;

-- Copy Data from CSv file to staging layer in superstore_dw
COPY staging.stg_orders (
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
    order_priority
)
FROM 'C:/PostgresData/Global_Superstore.csv'
DELIMITER ','
CSV HEADER
ENCODING 'LATIN1';

