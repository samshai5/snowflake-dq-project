-- ============================================================
-- Project: Snowflake Data Quality Validation
-- File:    profiling.sql
-- Rule:    Data Profiling — run this FIRST on any new dataset
--          Returns null rates, distinct counts, min/max per column
-- Author:  Sam Shaikh
-- ============================================================

SELECT
    'SALE_PRICE'                                        AS COLUMN_NAME,
    COUNT(*)                                            AS TOTAL_ROWS,
    COUNT(SALE_PRICE)                                   AS NON_NULL_COUNT,
    COUNT(*) - COUNT(SALE_PRICE)                        AS NULL_COUNT,
    ROUND(COUNT(SALE_PRICE) / COUNT(*) * 100, 1)       AS COMPLETENESS_PCT,
    COUNT(DISTINCT SALE_PRICE)                          AS DISTINCT_VALUES,
    MIN(SALE_PRICE)                                     AS MIN_VAL,
    MAX(SALE_PRICE)                                     AS MAX_VAL,
    ROUND(AVG(SALE_PRICE), 2)                           AS AVG_VAL
FROM AUTOMOTIVE_DW.DQ_SCHEMA.VEHICLE_SALES

UNION ALL

SELECT
    'MILEAGE',
    COUNT(*), COUNT(MILEAGE),
    COUNT(*) - COUNT(MILEAGE),
    ROUND(COUNT(MILEAGE) / COUNT(*) * 100, 1),
    COUNT(DISTINCT MILEAGE),
    MIN(MILEAGE), MAX(MILEAGE), ROUND(AVG(MILEAGE), 2)
FROM AUTOMOTIVE_DW.DQ_SCHEMA.VEHICLE_SALES

UNION ALL

SELECT
    'MODEL_YEAR',
    COUNT(*), COUNT(MODEL_YEAR),
    COUNT(*) - COUNT(MODEL_YEAR),
    ROUND(COUNT(MODEL_YEAR) / COUNT(*) * 100, 1),
    COUNT(DISTINCT MODEL_YEAR),
    MIN(MODEL_YEAR), MAX(MODEL_YEAR), ROUND(AVG(MODEL_YEAR), 2)
FROM AUTOMOTIVE_DW.DQ_SCHEMA.VEHICLE_SALES;
