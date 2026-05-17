-- ============================================================
-- Project: Snowflake Data Quality Validation
-- File:    price_range.sql
-- Rule:    Validity — sale price must be between $500 and $500,000
--          Also flags statistical outliers using STDDEV
-- Author:  Sam Shaikh
-- ============================================================

WITH PRICE_STATS AS (
    SELECT
        AVG(SALE_PRICE)    AS AVG_PRICE,
        STDDEV(SALE_PRICE) AS STD_PRICE
    FROM AUTOMOTIVE_DW.DQ_SCHEMA.VEHICLE_SALES
    WHERE SALE_PRICE BETWEEN 500 AND 500000
)
SELECT
    v.VEHICLE_ID,
    v.MAKE,
    v.MODEL,
    v.SALE_PRICE,
    ROUND(p.AVG_PRICE, 2) AS AVG_PRICE,
    CASE
        WHEN v.SALE_PRICE < 500    THEN 'Below minimum'
        WHEN v.SALE_PRICE > 500000 THEN 'Above maximum'
        WHEN ABS(v.SALE_PRICE - p.AVG_PRICE) > 3 * p.STD_PRICE THEN 'Statistical outlier'
    END AS ISSUE_TYPE
FROM AUTOMOTIVE_DW.DQ_SCHEMA.VEHICLE_SALES v
CROSS JOIN PRICE_STATS p
WHERE
    v.SALE_PRICE < 500
    OR v.SALE_PRICE > 500000
    OR ABS(v.SALE_PRICE - p.AVG_PRICE) > 3 * p.STD_PRICE
ORDER BY v.SALE_PRICE;
