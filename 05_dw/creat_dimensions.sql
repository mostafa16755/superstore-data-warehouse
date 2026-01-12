-- Customer Dimension
CREATE TABLE IF NOT EXISTS dw.dim_customer (
    customer_key SERIAL PRIMARY KEY,   -- surrogate key
    customer_id TEXT UNIQUE,            -- business key
    customer_name TEXT,
    segment TEXT
);

-- Product Dimension
CREATE TABLE IF NOT EXISTS dw.dim_product (
    product_key SERIAL PRIMARY KEY,
    product_id TEXT UNIQUE,
    product_name TEXT,
    category TEXT,
    sub_category TEXT
);

-- Location Dimension
CREATE TABLE IF NOT EXISTS dw.dim_location (
    location_key SERIAL PRIMARY KEY,
    city TEXT,
    state TEXT,
    country TEXT,
    market TEXT,
    region TEXT
);

-- Date Dimension
CREATE TABLE IF NOT EXISTS dw.dim_date (
    date_key INT PRIMARY KEY,   -- YYYYMMDD format
    full_date DATE UNIQUE,
    day INT,
    month INT,
    month_name TEXT,
    quarter INT,
    year INT,
    day_of_week INT,
    day_name TEXT
);