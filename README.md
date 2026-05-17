# Snowflake Data Quality Validation Project

**Author:** Sam Shaikh  
**Tools:** Snowflake SQL, Data Quality, Data Governance  
**Dataset:** Automotive vehicle sales (1,240 rows)

## Overview
This project implements a data quality validation framework in Snowflake for an automotive dealership dataset. It mirrors real-world enterprise DQ work, covering 5 data quality dimensions using custom SQL rules.

## Files

| File | Dimension | Description |
|------|-----------|-------------|
| `null_check.sql` | Completeness | Finds NULL values in required fields |
| `duplicates.sql` | Uniqueness | Detects duplicate VINs using window functions |
| `price_range.sql` | Validity | Validates sale prices, flags outliers using STDDEV |
| `date_validity.sql` | Accuracy | Catches future dates and impossible date ranges |
| `profiling.sql` | All | Full column profiling — null rates, min/max, distinct counts |
| `dq_scorecard.sql` | Summary | Logs all rule results to a tracking table |

## Results Summary

| Rule | Failures | Pass Rate |
|------|----------|-----------|
| Null Check | 4 | 99.7% |
| Duplicate VIN | 5 | 99.6% |
| Price Range | 4 | 99.7% |
| Date Accuracy | 3 | 99.8% |
| **Overall** | **16** | **99.7%** |

## How to Run
1. Sign up for a free Snowflake trial at snowflake.com
2. Create a database: `CREATE DATABASE AUTOMOTIVE_DW;`
3. Create a schema: `CREATE SCHEMA DQ_SCHEMA;`
4. Load your vehicle sales CSV into a `VEHICLE_SALES` table
5. Run each `.sql` file in order, starting with `profiling.sql`
