/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

-- ====================================================================
-- Checking 'silver.crm_cust_info'
-- ====================================================================
-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results


select *
from silver.crm_sales_details

select *
from silver.crm_sales_details
where TRIM(sls_ord_num)<>sls_ord_num

select *
from silver.crm_sales_details
where TRIM(sls_prd_key)<>sls_prd_key

select *
from silver.crm_sales_details
where sls_prd_key not in (select prd_key from silver.crm_prd_info)

select *
from silver.crm_sales_details
where sls_cust_id not in (select cst_id from silver.crm_cust_info)

select *
from silver.crm_sales_details
where sls_sales is null
or sls_sales<0
or sls_quantity is null
or sls_quantity <0
or sls_price is null
or sls_price <0
or sls_sales <> sls_quantity*sls_price
-----------------------------------------------------
select top 10 *
from silver.crm_prd_info

select prd_id,COUNT(*)
from silver.crm_prd_info
group by prd_id
having COUNT(*)>1

select *
from silver.crm_prd_info a
full join silver.erp_PX_CAT_G1V2 b
on a.cat_id=b.ID
where a.cat_id is null
or b.ID is null

select *
from silver.crm_prd_info
where TRIM(prd_nm)<>prd_nm

select *
from silver.crm_prd_info
where prd_cost is null
or prd_cost < 0

select distinct prd_line
from silver.crm_prd_info

select *
from silver.crm_prd_info
where pd_end_dt< prd_start_dt

select *
from silver.crm_prd_info
-------------------------------
select top 10 *
from silver.crm_cust_info

select cst_id,COUNT(*)
from silver.crm_cust_info
group by cst_id
Having COUNT(*)>1

select *
from silver.crm_cust_info a
full join silver.erp_LOC_A101 b
on a.cst_key=b.CID
where a.cst_key is null
or b.CID is null

select *
from silver.crm_cust_info a
full join silver.erp_CUST_AZ12 b
on a.cst_key=b.CID
where a.cst_key is null
or b.CID is null

select *
from silver.crm_cust_info
where TRIM(cst_firstname)<>cst_firstname

select *
from silver.crm_cust_info
where TRIM(cst_lastname)<>cst_lastname

select distinct cst_marital_status
from silver.crm_cust_info

select distinct cst_gndr
from silver.crm_cust_info

----------------------------------------------------
select top 10 *
from silver.erp_loc_A101

select distinct CNTRY
from silver.erp_loc_A101
----------------------------------------------
select top 10 *
from silver.erp_CUST_AZ12

select *
from silver.erp_CUST_AZ12
where BDATE>GETDATE()

select distinct GEN
from silver.erp_CUST_AZ12
--------------------------------
