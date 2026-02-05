/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================
DROP VIEW IF EXISTS gold.dim_products;
GO

CREATE VIEW gold.dim_products
AS
SELECT
	ROW_NUMBER() OVER(ORDER BY a.prd_key, prd_start_dt) product_key,
	a.prd_id product_id,
	a.prd_key product_number,
	a.prd_nm product_name,
	a.cat_id,
	a.prd_line product_line,
	b.CAT category,
	b.SUBCAT subcategory,
	b.MAINTENANCE maintenance,
	a.prd_cost cost,
	a.prd_start_dt [start_date]
FROM silver.crm_prd_info a
LEFT JOIN silver.erp_PX_CAT_G1V2 b
ON a.cat_id=b.ID
where pd_end_dt is null;
GO
-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================
DROP VIEW IF EXISTS gold.dim_customers;
GO

CREATE VIEW gold.dim_customers
AS
SELECT
	ROW_NUMBER() OVER(ORDER BY a.cst_key,a.cst_create_date) customer_key,
	a.cst_id customer_id,
	a.cst_key customer_number,
	a.cst_firstname first_name,
	a.cst_lastname last_name,
	a.cst_marital_status marital_status,
	CASE
		WHEN a.cst_gndr <> 'n/a' THEN a.cst_gndr
		ELSE COALESCE(c.GEN,'n/a')
	END AS gender,
	CNTRY country,
	BDATE birth_date,
	a.cst_create_date create_date
FROM silver.crm_cust_info a
LEFT JOIN silver.erp_loc_A101 b
	ON a.cst_key =b.CID
LEFT JOIN silver.erp_CUST_AZ12 c
	ON a.cst_key=c.CID;
GO
-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================
DROP VIEW IF EXISTS gold.fact_sales;
GO

CREATE VIEW gold.fact_sales
AS
SELECT
	a.sls_ord_num order_number,
	b.product_key product_key,
	c.customer_key customer_key,
	a.sls_order_dt order_date,
	a.sls_ship_dt shipping_date,
	a.sls_due_dt due_date,
	a.sls_sales sales_amount,
	a.sls_quantity quantity,
	a.sls_price price
FROM silver.crm_sales_details a
LEFT JOIN gold.dim_products b
	ON a.sls_prd_key=b.product_number
LEFT JOIN gold.dim_customers c
	ON a.sls_cust_id=c.customer_id;

GO
