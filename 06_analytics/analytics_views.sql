CREATE OR REPLACE VIEW analytics.vw_orders AS
SELECT
    -- Order info
    f.order_id,
    f.load_date,

    -- Customer
    c.customer_id,
    c.customer_name,
    c.segment,

    -- Product
    p.product_id,
    p.product_name,
    p.category,
    p.sub_category,

    -- Location
    l.city,
    l.state,
    l.country,
    l.market,
    l.region,

    -- Dates
    d_order.full_date   AS order_date,
    d_order.year        AS order_year,
    d_order.month       AS order_month,
    d_order.month_name  AS order_month_name,
    d_order.quarter     AS order_quarter,

    d_ship.full_date    AS ship_date,

    -- Measures
    f.sales,
    f.quantity,
    f.discount,
    f.profit,
    f.shipping_cost

FROM dw.fact_orders f
JOIN dw.dim_customer c  ON f.customer_key = c.customer_key
JOIN dw.dim_product p   ON f.product_key = p.product_key
JOIN dw.dim_location l  ON f.location_key = l.location_key
JOIN dw.dim_date d_order ON f.order_date_key = d_order.date_key
LEFT JOIN dw.dim_date d_ship ON f.ship_date_key = d_ship.date_key;

-- Sales by Year & Month
CREATE OR REPLACE VIEW analytics.vw_sales_by_month AS
SELECT
    order_year,
    order_month,
    order_month_name,
    SUM(sales)     AS total_sales,
    SUM(profit)    AS total_profit,
    SUM(quantity)  AS total_quantity
FROM analytics.vw_orders
GROUP BY
    order_year,
    order_month,
    order_month_name;

-- Sales by Customer
CREATE OR REPLACE VIEW analytics.vw_sales_by_customer AS
SELECT
    customer_id,
    customer_name,
    segment,
    SUM(sales)  AS total_sales,
    SUM(profit) AS total_profit
FROM analytics.vw_orders
GROUP BY
    customer_id,
    customer_name,
    segment;

-- Sales by Product
CREATE OR REPLACE VIEW analytics.vw_sales_by_product AS
SELECT
    product_id,
    product_name,
    category,
    sub_category,
    SUM(sales)     AS total_sales,
    SUM(quantity)  AS total_quantity,
    SUM(profit)    AS total_profit
FROM analytics.vw_orders
GROUP BY
    product_id,
    product_name,
    category,
    sub_category;

-- Sales by Region
CREATE OR REPLACE VIEW analytics.vw_sales_by_region AS
SELECT
    country,
    market,
    region,
    SUM(sales)  AS total_sales,
    SUM(profit) AS total_profit
FROM analytics.vw_orders
GROUP BY
    country,
    market,
    region;

-- High-level KPIs
CREATE OR REPLACE VIEW analytics.vw_kpis AS
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(sales)               AS total_sales,
    SUM(profit)              AS total_profit,
    SUM(quantity)            AS total_quantity,
    ROUND(SUM(profit) / NULLIF(SUM(sales), 0), 2) AS profit_margin
FROM analytics.vw_orders;

