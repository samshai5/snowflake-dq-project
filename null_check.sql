-- ============================================================
-- Project: Snowflake Data Quality Validation
-- File:    null_check.sql
-- Rule:    Completeness — required fields must not be NULL
-- Author:  Sam Shaikh
-- ============================================================

SELECT
    VEHICLE_ID,
    VIN,
    MAKE,
    MODEL,
    SALE_PRICE,
    SALE_DATE,
    CASE
        WHEN VIN        IS NULL THEN 'Missing VIN'
        WHEN MAKE       IS NULL THEN 'Missing MAKE'
        WHEN MODEL      IS NULL THEN 'Missing MODEL'
        WHEN SALE_PRICE IS NULL THEN 'Missing PRICE'
        WHEN SALE_DATE  IS NULL THEN 'Missing DATE'
    END AS FAILURE_REASON
FROM AUTOMOTIVE_DW.DQ_SCHEMA.VEHICLE_SALES
WHERE
    VIN        IS NULL
    OR MAKE       IS NULL
    OR MODEL      IS NULL
    OR SALE_PRICE IS NULL
    OR SALE_DATE  IS NULL
ORDER BY VEHICLE_ID;
