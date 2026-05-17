-- ============================================================
-- Project: Snowflake Data Quality Validation
-- File:    date_validity.sql
-- Rule:    Accuracy — sale dates must not be in the future
--          or before dealership opened (2015-01-01)
-- Author:  Sam Shaikh
-- ============================================================

SELECT
    VEHICLE_ID,
    MAKE,
    MODEL,
    SALE_DATE,
    CURRENT_DATE()                                    AS TODAY,
    DATEDIFF('day', CURRENT_DATE(), SALE_DATE)        AS DAYS_IN_FUTURE,
    CASE
        WHEN SALE_DATE > CURRENT_DATE()   THEN 'Future date'
        WHEN SALE_DATE < '2015-01-01'     THEN 'Before operations'
    END AS DATE_ISSUE
FROM AUTOMOTIVE_DW.DQ_SCHEMA.VEHICLE_SALES
WHERE
    SALE_DATE > CURRENT_DATE()
    OR SALE_DATE < '2015-01-01'
ORDER BY SALE_DATE DESC;
