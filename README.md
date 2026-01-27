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

