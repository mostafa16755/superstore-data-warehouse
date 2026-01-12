CREATE TABLE IF NOT EXISTS dw.fact_orders (
    fact_order_key BIGSERIAL PRIMARY KEY,

    -- Dimension foreign keys
    customer_key INT NOT NULL,
    product_key INT NOT NULL,
    location_key INT NOT NULL,
    order_date_key INT NOT NULL,
    ship_date_key INT,

    -- Measures
    sales NUMERIC(10,2),
    quantity INT,
    discount NUMERIC(5,2),
    profit NUMERIC(10,2),
    shipping_cost NUMERIC(10,2),

    -- Degenerate dimension
    order_id TEXT,

    -- Metadata
    load_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Foreign key constraints
    CONSTRAINT fk_fact_customer
        FOREIGN KEY (customer_key)
        REFERENCES dw.dim_customer(customer_key),

    CONSTRAINT fk_fact_product
        FOREIGN KEY (product_key)
        REFERENCES dw.dim_product(product_key),

    CONSTRAINT fk_fact_location
        FOREIGN KEY (location_key)
        REFERENCES dw.dim_location(location_key),

    CONSTRAINT fk_fact_order_date
        FOREIGN KEY (order_date_key)
        REFERENCES dw.dim_date(date_key),

    CONSTRAINT fk_fact_ship_date
        FOREIGN KEY (ship_date_key)
        REFERENCES dw.dim_date(date_key)
);
