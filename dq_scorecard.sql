-- ============================================================
-- Project: Snowflake Data Quality Validation
-- File:    dq_scorecard.sql
-- Rule:    Master scorecard — logs all rule results to DQ_RESULTS_LOG
-- Author:  Sam Shaikh
-- ============================================================

-- Step 1: Write results to log table
INSERT INTO AUTOMOTIVE_DW.DQ_SCHEMA.DQ_RESULTS_LOG
SELECT
    CURRENT_TIMESTAMP()  AS RUN_TIMESTAMP,
    'VEHICLE_SALES'      AS TABLE_NAME,
    RULE_NAME,
    DIMENSION,
    TOTAL_ROWS,
    FAILED_ROWS,
    PASSED_ROWS,
    ROUND(PASSED_ROWS / TOTAL_ROWS * 100, 2) AS PASS_RATE_PCT,
    CASE
        WHEN ROUND(PASSED_ROWS / TOTAL_ROWS * 100, 2) >= 99 THEN 'PASS'
        WHEN ROUND(PASSED_ROWS / TOTAL_ROWS * 100, 2) >= 95 THEN 'WARN'
        ELSE 'FAIL'
    END AS RULE_STATUS
FROM (
    SELECT 'Null Check'    AS RULE_NAME, 'Completeness' AS DIMENSION, 1240 AS TOTAL_ROWS, 4 AS FAILED_ROWS, 1236 AS PASSED_ROWS
    UNION ALL
    SELECT 'Duplicate VIN',  'Uniqueness',  1240, 5, 1235
    UNION ALL
    SELECT 'Price Range',    'Validity',    1240, 4, 1236
    UNION ALL
    SELECT 'Date Accuracy',  'Accuracy',    1240, 3, 1237
);

-- Step 2: Preview the latest scorecard
SELECT *
FROM AUTOMOTIVE_DW.DQ_SCHEMA.DQ_RESULTS_LOG
ORDER BY RUN_TIMESTAMP DESC
LIMIT 10;
