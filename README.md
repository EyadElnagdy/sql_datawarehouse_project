# SQL Server Data Warehouse Project

## Overview
This project implements a layered data warehouse architecture using Microsoft SQL Server.  
It is designed to ingest and transform data from ERP and CRM systems delivered as CSV files.

The solution follows modern ELT best practices and the Bronze–Silver–Gold architecture to ensure data quality, scalability, and analytics readiness.

---

## Business Requirements
- Source systems (ERP and CRM) export data as CSV files
- Files are already available in a designated folder
- Data must be:
  - Fully loaded into the data warehouse
  - Cleaned and standardized
  - Aggregated for business reporting and analytics

---

## Architecture Overview

### Data Flow
CSV Files (ERP / CRM) ➡️ Bronze Layer (Raw) ➡️ Silver Layer (Cleaned & Standardized) ➡️ Gold Layer (Business Views & Aggregations)


---

## Data Layers

### Bronze Layer – Raw Ingestion
**Purpose:** Preserve raw source data exactly as received.

- Full load from CSV files
- No transformations applied
- One-to-one mapping with source files
- Used for auditing and reprocessing

**Characteristics:**
- Raw data types
- Minimal constraints
- Truncate-and-load or append strategy

---

### Silver Layer – Cleansed & Standardized
**Purpose:** Improve data quality and consistency.

- Data cleaning (null handling, deduplication)
- Standardized formats (dates, strings, keys)
- Business-ready data structures
- Conformed entities across ERP and CRM

**Typical operations:**
- Data type corrections
- Column renaming
- Data validation rules

---

### Gold Layer – Business Consumption
**Purpose:** Enable analytics and reporting.

- Business-level aggregations
- KPIs and metrics
- Optimized for BI tools and dashboards
- Implemented as SQL views

**Examples:**
- Sales summaries
- Customer performance metrics
- Time-based aggregations

---

## Technology Stack
- Database: Microsoft SQL Server
- Data Sources: CSV files (ERP & CRM)
- Data Integration: SQL-based ELT pipelines
- Architecture: Bronze / Silver / Gold

---

## Naming Conventions
All database objects follow snake_case for consistency and readability.

---

### Databases
dw_bronze
dw_silver
dw_gold


---

### Tables
**Pattern:**
<layer><source><entity>


**Examples:**
bronze_erp_orders
bronze_crm_customers
silver_erp_products
silver_crm_customers


---

### Views (Gold Layer)
**Pattern:**
vw_<business_subject>


**Examples:**
vw_sales_summary
vw_customer_lifetime_value


---

### Columns
- Lowercase
- snake_case
- Clear and descriptive

**Examples:**
order_id
customer_id
order_date
total_amount


---

### Technical / Metadata Columns
Standard technical columns used across layers:

insert_date -- datetime when the record was loaded
update_date -- datetime of last update
source_system -- erp / crm
batch_id -- load identifier


---

### Stored Procedures
**Pattern:**
sp_<layer><action><entity>


**Examples:**
sp_bronze_load_erp_orders
sp_bronze_load_crm_customers
sp_silver_transform_orders


---

### Indexes
**Pattern:**
ix_<table_name>_<column_name>


**Examples:**
ix_silver_customers_customer_id
ix_bronze_orders_order_date


---

## Data Loading Strategy
- Bronze layer: Full load from CSV files without transformations
- Silver layer: Data cleansing and standardization using SQL logic
- Gold layer: Views implementing business logic and aggregations

---

## Project Goals
- Preserve raw source data
- Improve data quality and consistency
- Enable scalable transformations
- Support analytical and reporting workloads
- Follow industry-standard data warehousing practices

---

## Future Enhancements
- Incremental loading strategies
- Error handling and logging
- Data quality checks
- Automation and orchestration
- Integration with BI tools

---

## License
MIT License
