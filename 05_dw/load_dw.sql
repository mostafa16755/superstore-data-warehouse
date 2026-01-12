WITH monthly_data AS (
    SELECT 
        dd.year,
        dd.month_name,
        COUNT(*) AS order_count,
        SUM(fo.sales) AS sales,
        SUM(fo.profit) AS profit
    FROM dw.fact_orders fo
    JOIN dw.dim_date dd ON fo.order_date_key = dd.date_key
    GROUP BY dd.year, dd.month_name, dd.month
)
SELECT 
    year,
    month_name,
    order_count,
    ROUND(sales, 2) AS sales,
    ROUND(profit, 2) AS profit,
    ROUND(profit / NULLIF(sales, 0) * 100, 1) AS margin_pct,
    ROUND(sales / order_count, 2) AS avg_order_value
FROM monthly_data
ORDER BY year DESC, month DESC
LIMIT 12;