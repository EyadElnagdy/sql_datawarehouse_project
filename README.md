# SQL Server Data Warehouse Project

## Overview
This project implements a **layered data warehouse architecture** using **Microsoft SQL Server**, designed to ingest and transform data from **ERP and CRM systems** delivered as CSV files.

The solution follows modern **ELT best practices** and the **Bronze–Silver–Gold** pattern to ensure data quality, scalability, and analytics readiness.

---

## Business Requirements
- Source systems (ERP and CRM) export data as **CSV files**
- Files are already available in a **designated folder**
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

### 🟤 Bronze Layer – Raw Ingestion
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

### ⚪ Silver Layer – Cleansed & Standardized
**Purpose:** Improve data quality and consistency.

- Data cleaning (null handling, deduplication)
- Standardized formats (dates, strings, keys)
- Business-ready structures
- Conformed entities across ERP and CRM

**Typical operations:**
- Data type corrections
- Column renaming
- Data validation rules

---

### 🟡 Gold Layer – Business Consumption
**Purpose:** Enable analytics and reporting.

- Business-level aggregations
- KPIs and metrics
- Optimized for BI tools and dashboards
- Implemented as **views**

**Examples:**
- Sales summaries
- Customer performance metrics
- Time-based aggregations

---

## Technology Stack
- **Database:** Microsoft SQL Server
- **Data Sources:** CSV files (ERP & CRM)
- **Approach:** ELT
- **Architecture:** Bronze / Silver / Gold

---

## Naming Conventions
All database objects follow **snake_case** for consistency and readability.

---

### Databases
```text
dw_bronze
dw_silver
dw_gold


