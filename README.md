# Snowflake Data Quality Validation Framework

**Author:** Sam Shaikh · [github.com/samshai5](https://github.com/samshai5)  
**Stack:** Snowflake SQL · Data Quality · Data Governance  
**Dataset:** Automotive vehicle sales dataset (1,240 rows)  
**Status:** ✅ Complete

---

## Overview

This project implements a production-style **data quality (DQ) validation framework** in Snowflake for an automotive dealership dataset. It mirrors real-world enterprise data quality workflows used by companies like Edmunds, CarMax, and Cox Automotive — covering **5 core data quality dimensions** using custom SQL rules, outlier detection, and a DQ scorecard for tracking results over time.

The goal: catch bad data before it reaches consumers, analysts, or downstream systems.

---

## Why This Project

Bad data costs businesses millions. A single incorrect VIN, a $0 sale price, or a future sale date in a production database can break inventory systems, mislead analysts, and erode consumer trust. This project was built to demonstrate the kind of attribute-level data validation used in enterprise automotive data platforms — where accuracy isn't optional.

---

## Data Quality Dimensions Covered

| Dimension | What It Checks |
|---|---|
| **Completeness** | Are required fields populated? No NULLs in critical columns |
| **Uniqueness** | Are VINs truly unique? Duplicate detection using window functions |
| **Validity** | Are sale prices within expected ranges? Outlier flagging using STDDEV |
| **Accuracy** | Are dates realistic? No future dates, no impossible date ranges |
| **Profiling** | Full column-level analysis — null rates, min/max, distinct counts |

---

## Project Files

| File | Dimension | Description |
|---|---|---|
| `profiling.sql` | All | Full column profiling — null rates, min/max, distinct counts across all fields |
| `null_check.sql` | Completeness | Identifies NULL values in required fields (VIN, sale price, sale date, make, model) |
| `duplicates.sql` | Uniqueness | Detects duplicate VINs using SQL window functions (ROW_NUMBER) |
| `price_range.sql` | Validity | Validates sale prices, flags statistical outliers using STDDEV thresholds |
| `date_validity.sql` | Accuracy | Catches future-dated sales and impossible date ranges |
| `dq_scorecard.sql` | Summary | Logs all rule results to a persistent DQ tracking table for trend analysis |

---

## Results Summary

| Rule | Records Checked | Failures Found | Pass Rate |
|---|---|---|---|
| Null Check | 1,240 | 4 | 99.7% |
| Duplicate VIN | 1,240 | 5 | 99.6% |
| Price Range (Outliers) | 1,240 | 4 | 99.7% |
| Date Accuracy | 1,240 | 3 | 99.8% |
| **Overall** | **1,240** | **16** | **99.7%** |

> 16 data quality issues identified and flagged across 1,240 records — each with a recommended action for remediation.

---

## Key Technical Highlights

- **Window Functions** — used `ROW_NUMBER() OVER (PARTITION BY vin)` for duplicate VIN detection without deleting records
- **Statistical Outlier Detection** — used `AVG()` and `STDDEV()` to flag sale prices beyond 2 standard deviations from the mean
- **DQ Scorecard Table** — all rule results are logged to a persistent table, enabling trend tracking over time
- **Modular SQL Design** — each rule is a standalone `.sql` file, making it easy to add, remove, or modify individual checks
- **Enterprise-Grade Approach** — framework mirrors DQ validation workflows used in production automotive data platforms

---

## How to Run

1. Sign up for a free Snowflake trial at [snowflake.com](https://snowflake.com)
2. Create a database:
```sql
CREATE DATABASE AUTOMOTIVE_DW;
```
3. Create a schema:
```sql
CREATE SCHEMA DQ_SCHEMA;
```
4. Load your vehicle sales CSV into a `VEHICLE_SALES` table
5. Run files in this order:
   - `profiling.sql` — understand your data first
   - `null_check.sql`
   - `duplicates.sql`
   - `price_range.sql`
   - `date_validity.sql`
   - `dq_scorecard.sql` — log and track all results

---

## Skills Demonstrated

`Snowflake SQL` `Data Quality Validation` `Data Governance` `Window Functions` `Statistical Analysis` `Outlier Detection` `Enterprise DQ Frameworks` `Automotive Data` `Database Design` `Debugging & Performance Optimization`

---

## Related Projects

- 🔗 [sql-dq-engine](https://github.com/samshai5/sql-dq-engine) — Automated SQL data quality engine with Python integration
- 🔗 [dq-dashboard](https://github.com/samshai5/dq-dashboard) — Frontend dashboard for visualizing data quality results
- 🔗 [Trading](https://github.com/samshai5/Trading) — AI-powered trading application

---

*Built by Sam Shaikh — Computer Science student at the University of Houston, passionate about data quality, automotive data, and building systems that keep bad data out of production.*
