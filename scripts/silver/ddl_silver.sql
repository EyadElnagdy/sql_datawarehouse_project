/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

USE Datawarehouse;
GO

DROP TABLE IF EXISTS  [silver].[crm_sales_details];
GO

CREATE TABLE [silver].[crm_sales_details] 
(
	sls_ord_num VARCHAR(50),
	sls_prd_key	VARCHAR(50),
	sls_cust_id	INT,
	sls_order_dt DATE,
	sls_ship_dt DATE,
	sls_due_dt DATE,
	sls_sales DECIMAL(10,2),
	sls_quantity INT,
	sls_price DECIMAL(10,2)
);
-------------------------------------------------
DROP TABLE IF EXISTS  [silver].[crm_prd_info];
GO

CREATE TABLE [silver].[crm_prd_info] 
(
	prd_id INT,
	prd_key VARCHAR(50),
	cat_id VARCHAR(50),
	prd_nm VARCHAR(50),
	prd_cost DECIMAL(10,2),
	prd_line VARCHAR(50),
	prd_start_dt DATE,
	pd_end_dt DATE
);
----------------------------------------------------
DROP TABLE IF EXISTS  [silver].[crm_cust_info];
GO

CREATE TABLE [silver].[crm_cust_info]
(
	cst_id INT,
	cst_key VARCHAR(50),
	cst_firstname VARCHAR(50),
	cst_lastname VARCHAR(50),
	cst_marital_status VARCHAR(50),
	cst_gndr VARCHAR(50),
	cst_create_date DATE
);
----------------------------------------------
DROP TABLE IF EXISTS  [silver].[erp_CUST_AZ12];
GO

CREATE TABLE [silver].[erp_CUST_AZ12]
(
	CID VARCHAR(50),
	BDATE DATE,
	GEN VARCHAR(50),
);
----------------------------------------------
DROP TABLE IF EXISTS  [silver].[erp_LOC_A101];
GO

CREATE TABLE [silver].[erp_LOC_A101]
(
	CID VARCHAR(50),
	CNTRY VARCHAR(50)
);
------------------------------------------------
DROP TABLE IF EXISTS  [silver].[erp_PX_CAT_G1V2];
GO

CREATE TABLE [silver].[erp_PX_CAT_G1V2]
(
	ID VARCHAR(50),
	CAT VARCHAR(50),
	SUBCAT VARCHAR(50),
	MAINTENANCE VARCHAR(50)
);
