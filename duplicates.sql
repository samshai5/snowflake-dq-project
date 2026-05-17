-- ============================================================
-- Project: Snowflake Data Quality Validation
-- File:    duplicates.sql
-- Rule:    Uniqueness — VIN must appear exactly once
-- Author:  Sam Shaikh
-- ============================================================

WITH VIN_COUNTS AS (
    SELECT
        VIN,
        VEHICLE_ID,
        MAKE,
        MODEL,
        SALE_DATE,
        COUNT(*) OVER (PARTITION BY VIN)              AS VIN_OCCURRENCES,
        ROW_NUMBER() OVER (PARTITION BY VIN ORDER BY SALE_DATE) AS RN
    FROM AUTOMOTIVE_DW.DQ_SCHEMA.VEHICLE_SALES
)
SELECT
    VIN,
    VEHICLE_ID,
    MAKE,
    MODEL,
    SALE_DATE,
    VIN_OCCURRENCES,
    CASE WHEN RN = 1 THEN 'ORIGINAL' ELSE 'DUPLICATE' END AS RECORD_TYPE
FROM VIN_COUNTS
WHERE VIN_OCCURRENCES > 1
ORDER BY VIN, SALE_DATE;
